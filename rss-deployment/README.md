# RSS 订阅系统部署

基于 FreshRSS 的 AI 趋势雷达订阅系统。

## 快速开始

```bash
# 1. 进入目录
cd rss-deployment

# 2. 运行部署脚本
./scripts/setup.sh

# 3. 访问 http://localhost:8080
```

## 目录结构

```
rss-deployment/
├── docker-compose.yml      # Docker 配置
├── freshrss/
│   ├── data/               # FreshRSS 数据 (自动生成)
│   └── extensions/         # 扩展插件
├── opml/
│   └── ai-trends.opml      # 订阅源清单 (25个)
├── scripts/
│   ├── setup.sh            # 部署脚本
│   └── notify-feishu.sh    # 飞书通知
└── README.md
```

## 订阅源 (25个)

| 类别 | 数量 | 代理 |
|------|:----:|:----:|
| 科技新闻 | 6 | ❌ |
| 中文源 | 1 | ❌ |
| 论文 | 2 | ❌ |
| AI 博客 | 3 | ❌ |
| YouTube | 2 | ❌ |
| GitHub | 10 | ✅ |

## 代理配置

GitHub 源需要代理，默认使用 `127.0.0.1:7897`。

修改 `docker-compose.yml` 中的 `HTTP_PROXY` 和 `HTTPS_PROXY` 环境变量。

## 常用命令

```bash
# 启动
docker-compose up -d

# 停止
docker-compose down

# 查看日志
docker-compose logs -f freshrss

# 重启
docker-compose restart

# 手动刷新订阅
docker-compose exec freshrss php ./cli/actualize.php
```

## 飞书通知

1. 设置环境变量:
   ```bash
   export FEISHU_WEBHOOK_URL="https://open.feishu.cn/open-apis/bot/v2/hook/xxx"
   ```

2. 测试发送:
   ```bash
   ./scripts/notify-feishu.sh "测试" "这是一条测试消息"
   ```
