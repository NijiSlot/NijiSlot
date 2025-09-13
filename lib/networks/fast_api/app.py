# app.py
import os
import time
import secrets
import base64
import hashlib
import uuid
import json  
import boto3
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from mangum import Mangum

# DynamoDB
TABLE_NAME = os.environ["TABLE_NAME"]
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(TABLE_NAME)

app = FastAPI()

# ---------- utils ----------
def random_token(nbytes: int = 32) -> str:
    return base64.urlsafe_b64encode(secrets.token_bytes(nbytes)).rstrip(b"=").decode("ascii")

def pk_from_token(token: str) -> str:
    return hashlib.sha256(token.encode("utf-8")).hexdigest()



# ---------- Firebase-like ID Token generator ----------
def _b64u(d: dict) -> str:
    """辞書を Base64URL (padding無し) 文字列に変換"""
    return base64.urlsafe_b64encode(
        json.dumps(d, separators=(",", ":")).encode("utf-8")
    ).decode("ascii").rstrip("=")

def create_firebase_like_id_token(
    uid: str,
    email: str | None = None,
    email_verified: bool | None = None,
    auth_time: int | None = None,
    iat: int | None = None,
    ttl: int = 3600,
) -> str:
    """Firebase風のIDトークン(JWT)を生成（署名無し）"""
    now = int(time.time())
    iat = iat or now
    auth_time = auth_time or iat

    header = {"alg": "RS256", "typ": "JWT"}
    payload = {
        "auth_time": auth_time,
        "sub": uid,
        "iat": iat,
        "exp": iat + ttl,
        "email": email,
        "email_verified": email_verified,
    }
    return f"{_b64u(header)}.{_b64u(payload)}."


# ---------- I/O models ----------
class VerifyIn(BaseModel):
    refresh_token: str
    uid: str | None = None  # 任意：一致チェックに使う

class RevokeIn(BaseModel):
    refresh_token: str

# ---------- endpoints ----------
@app.post("/tokens/issue")
def issue_token():
    uid = uuid.uuid4().hex
    refresh_token = random_token(32)
    pk = pk_from_token(refresh_token)
    now = int(time.time())

    table.put_item(
        Item={
            "refresh_token_hash": pk,
            "issued_at": now,
            "revoked": False,
            "uid": uid,
        },
        ConditionExpression="attribute_not_exists(refresh_token_hash)"
    )

    # 有効期限は 1 時間後
    ttl = 3600

    id_token = create_firebase_like_id_token(
        uid,
        email=None,
        email_verified=False,
        auth_time=now,
        iat=now,
        ttl=ttl,  # JWT の exp に反映
    )

    return {
        "uid": uid,
        "refresh_token": refresh_token,
        "id_token": id_token,
    }



@app.post("/tokens/verify")
def verify_token(body: VerifyIn):
    pk = pk_from_token(body.refresh_token)
    item = table.get_item(Key={"refresh_token_hash": pk}).get("Item")
    if not item or item.get("revoked"):
        raise HTTPException(status_code=401, detail="invalid or revoked")
    if body.uid and item.get("uid") != body.uid:
        raise HTTPException(status_code=401, detail="uid mismatch")
    return {"ok": True, "uid": item["uid"]}

@app.post("/tokens/revoke")
def revoke_token(body: RevokeIn):
    pk = pk_from_token(body.refresh_token)
    table.update_item(
        Key={"refresh_token_hash": pk},
        UpdateExpression="SET revoked = :r",
        ExpressionAttributeValues={":r": True},
        ConditionExpression="attribute_exists(refresh_token_hash)"
    )
    return {"ok": True}

# Lambda handler
handler = Mangum(app)
