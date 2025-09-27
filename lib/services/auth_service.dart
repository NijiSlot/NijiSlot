import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rains/model/response/token_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  // メモリキャッシュ
  String? _cachedUid;

  // Base64URL デコード -> UTF8 文字列
  String _b64UrlDecodeToString(String input) {
    var s = input.replaceAll('-', '+').replaceAll('_', '/');
    final pad = s.length % 4;
    if (pad > 0) s += '=' * (4 - pad);
    return utf8.decode(base64.decode(s));
  }

  // idToken (JWT 形式 header.payload.signature) から uid を取り出す
  String? _parseUidFromIdToken(String idToken) {
    try {
      final parts = idToken.split('.');
      if (parts.length < 2) return null;
      final payloadJson = _b64UrlDecodeToString(parts[1]);
      final payload = jsonDecode(payloadJson) as Map<String, dynamic>;
      return (payload['sub'] ?? payload['uid'])?.toString();
    } catch (_) {
      return null;
    }
  }

  // 永続化とキャッシュ
  Future<void> _saveUid(String uid) async {
    _cachedUid = uid;
    await _storage.write(key: 'uid', value: uid);
  }

  // いつでも参照できるように uid を返す
  Future<String?> getUid() async {
    if (_cachedUid != null) return _cachedUid;
    final stored = await _storage.read(key: 'uid');
    _cachedUid = stored;
    return stored;
  }

  Future<Map<String, String?>> readTokens() async {
    final idToken = await _storage.read(key: 'idToken');
    final refreshToken = await _storage.read(key: 'refreshToken');
    return {'idToken': idToken, 'refreshToken': refreshToken};
  }

  Future<void> saveTokens({required String idToken, required String refreshToken}) async {
    await _storage.write(key: 'idToken', value: idToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<TokenResponse> issueToken() async {
    final url = Uri.parse(
      "https://45kgunyeh6.execute-api.ap-northeast-1.amazonaws.com/tokens/issue",
    );
    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({}),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      return TokenResponse.fromJson(data);
    }
    throw Exception('issueToken failed: ${resp.statusCode} ${resp.body}');
  }

  Future<Map<String, String>> getOrIssueTokens() async {
    final tokens = await readTokens();
    final auth = tokens['idToken'];
    final refresh = tokens['refreshToken'];

    if (auth != null && refresh != null) {
      // 既にトークンがある場合は uid を確保しておく
      final maybeUid = _parseUidFromIdToken(auth);
      if (maybeUid != null) await _saveUid(maybeUid);
      return {'idToken': auth, 'refreshToken': refresh};
    }

    try {
      final tr = await issueToken();
      await saveTokens(idToken: tr.idToken, refreshToken: tr.refreshToken);
      // 発行された idToken から uid を取り出して保存
      final issuedUid = _parseUidFromIdToken(tr.idToken);
      if (issuedUid != null) await _saveUid(issuedUid);
      notifyDownloaded();
      return {'idToken': tr.idToken, 'refreshToken': tr.refreshToken};
    } catch (_) {
      throw Exception('getOrIssueTokens failed:');
    }
  }

  Future<void> clearCredentials() async {
    _cachedUid = null;
    await _storage.delete(key: 'idToken');
    await _storage.delete(key: 'refreshToken');
    await _storage.delete(key: 'uid');
  }

  Future<void> notifyDownloaded() async {
    final url = Uri.parse('https://asia-northeast1-nijislo.cloudfunctions.net/notifySlack');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': 'アプリがダウンロードされました'}),
    );
    if (resp.statusCode != 200) {
      throw Exception('Slack通知失敗: ${resp.statusCode} ${resp.body}');
    }
  }
}
