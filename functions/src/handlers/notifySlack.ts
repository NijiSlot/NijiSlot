import type { Request, Response } from "express";
import { postToSlack } from "../libs/slack";

// ここが Cloud Functions の本体
export async function notifySlack(req: Request, res: Response) {
  try {
    const { message } = (req.method === "POST" ? req.body : req.query) || {};
    const text: string = message || "アプリがダウンロードされました";

    // 必要なら blocks に切替も可：
    // await postToSlack({ blocks: [{ type: "section", text: { type: "mrkdwn", text } }] });
    await postToSlack({ text });

    res.status(200).send("Notification sent to Slack");
  } catch (err) {
    console.error(err);
    res.status(500).send("Function error");
  }
}
