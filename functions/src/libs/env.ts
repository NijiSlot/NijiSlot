// 環境変数の取得とバリデーションを一箇所に集約
export function getEnv() {
  const WEBHOOK_URL = process.env.SLACK_WEBHOOK_URL;
  if (!WEBHOOK_URL) {
    // ここで throw すると、実行時に 500 で気づける & 型的にも undefined を排除できる
    throw new Error("環境変数 SLACK_WEBHOOK_URL が設定されていません");
  }
  return { WEBHOOK_URL };
}
