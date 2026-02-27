#!/bin/bash
# 飞书通知脚本 - 推送 RSS 更新摘要
# 用法: ./notify-feishu.sh "标题" "内容"

WEBHOOK_URL="${FEISHU_WEBHOOK_URL:-}"

if [ -z "$WEBHOOK_URL" ]; then
    echo "错误: 请设置 FEISHU_WEBHOOK_URL 环境变量"
    exit 1
fi

TITLE="${1:-📰 RSS 更新}"
CONTENT="${2:-无内容}"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

# 构建飞书消息
JSON_PAYLOAD=$(cat << PAYLOAD
{
  "msg_type": "interactive",
  "card": {
    "header": {
      "title": {
        "tag": "plain_text",
        "content": "${TITLE}"
      },
      "template": "blue"
    },
    "elements": [
      {
        "tag": "div",
        "text": {
          "tag": "lark_md",
          "content": "${CONTENT}"
        }
      },
      {
        "tag": "hr"
      },
      {
        "tag": "note",
        "elements": [
          {
            "tag": "plain_text",
            "content": "🕐 ${TIMESTAMP} | via FreshRSS"
          }
        ]
      }
    ]
  }
}
PAYLOAD
)

# 发送请求
curl -s -X POST "$WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD"

echo ""
echo "✅ 已发送飞书通知"
