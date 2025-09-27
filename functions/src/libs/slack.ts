import { getEnv } from "./env";

// Slack 送信ロジックを分離（テストしやすい＆再利用しやすい）
export async function postToSlack(payload: {
  text?: string;
  blocks?: unknown;
}) {
  const { WEBHOOK_URL } = getEnv();

  const resp = await fetch(WEBHOOK_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload),
  });

  if (!resp.ok) {
    const errText = await resp.text();
    throw new Error(`Slack webhook error: ${resp.status} ${errText}`);
  }
}
