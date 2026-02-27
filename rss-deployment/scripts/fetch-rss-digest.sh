#!/bin/bash
# FreshRSS 文章获取脚本 - 供 OpenClaw 使用
# 用法: ./fetch-rss-digest.sh [hours] [limit] [format]
# 示例: ./fetch-rss-digest.sh 24 20 json   # JSON 格式
# 示例: ./fetch-rss-digest.sh 24 10 md     # Markdown 格式 (供 AI 阅读)

set -e

FRESHRSS_USER="${FRESHRSS_USER:-kylinmiao}"
HOURS="${1:-24}"
LIMIT="${2:-20}"
FORMAT="${3:-json}"

# 计算时间戳
if [[ "$OSTYPE" == "darwin"* ]]; then
    SINCE_TIMESTAMP=$(date -v-${HOURS}H +%s)
else
    SINCE_TIMESTAMP=$(date -d "${HOURS} hours ago" +%s)
fi

# 从 FreshRSS SQLite 获取文章
ARTICLES=$(docker exec freshrss php -r "
\$db = new SQLite3('/var/www/FreshRSS/data/users/${FRESHRSS_USER}/db.sqlite');
\$since = ${SINCE_TIMESTAMP};
\$limit = ${LIMIT};
\$result = \$db->query(\"SELECT e.title, e.link, e.date, f.name as feed, substr(e.content, 1, 500) as content FROM entry e JOIN feed f ON e.id_feed = f.id WHERE e.date >= \$since ORDER BY e.date DESC LIMIT \$limit\");
\$articles = [];
while (\$row = \$result->fetchArray(SQLITE3_ASSOC)) {
    \$row['date'] = date('Y-m-d H:i', \$row['date']);
    \$row['content'] = strip_tags(\$row['content']);
    \$articles[] = \$row;
}
echo json_encode(\$articles, JSON_UNESCAPED_UNICODE);
" 2>/dev/null)

if [ "$FORMAT" == "md" ]; then
    echo "## 📰 RSS 订阅更新 (过去 ${HOURS} 小时)"
    echo ""
    echo "$ARTICLES" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for i, a in enumerate(data, 1):
    print(f\"{i}. **[{a['feed']}]** {a['title']}\")
    print(f\"   🔗 {a['link']}\")
    print(f\"   📅 {a['date']}\")
    print()
"
else
    echo "$ARTICLES"
fi

