# OpenClaw 当前状态

> 最后更新: 2026-02-26

## 📊 系统状态

| 组件 | 状态 | 说明 |
|------|:----:|------|
| **Gateway** | ✅ | 运行中 (pid 20354)，延迟 19ms |
| **飞书通道** | ✅ | WebSocket 连接，消息正常收发 |
| **Memory** | ⚠️ | memory-lancedb 已注册，但缺少 @lancedb/lancedb 模块 |
| **Browser** | ✅ | Headless 模式，profile: openclaw |
| **LaunchAgent** | ✅ | 开机自启 + 崩溃自动重启 |

## 🔧 核心配置

### AI 模型

| 配置项 | 值 |
|--------|-----|
| **主模型** | `bailian/qwen3.5-plus` |
| **Fallback 链** | qwen3-max-2026-01-23 → glm-5 → kimi-k2.5 |
| **API 端点** | https://coding.dashscope.aliyuncs.com/v1 |
| **上下文窗口** | 1,000,000 tokens |

### 飞书通道

| 配置项 | 值 |
|--------|-----|
| **App ID** | `cli_a914d0c6033adcc5` |
| **连接模式** | WebSocket (长连接) |
| **渲染模式** | Card (卡片消息) |
| **群聊策略** | mention (需要 @机器人) |
| **图片理解** | ✅ 已启用 (vision + downloadImages) |

### 浏览器

| 配置项 | 值 |
|--------|-----|
| **模式** | Headless |
| **Profile** | openclaw |
| **路径** | 内置 Chromium |

## 🔌 已安装插件

| 插件 | 版本 | 状态 | 说明 |
|------|------|:----:|------|
| `@m1heng-clawd/feishu` | 0.1.11 | ✅ | 第三方飞书插件，支持 import_document |
| `memory-lancedb` | 内置 | ⚠️ | 向量记忆，缺少依赖未启用 |
| `google-gemini-cli-auth` | 内置 | ✅ | Google Gemini 认证 |

## ⏰ Cron 定时任务

共 **11** 个任务，发送到群聊 `oc_d6abf34f98733528e4599e5e59cb56e7`：

| 任务名 | 时间 | 状态 |
|--------|------|:----:|
| coding-tip-daily | 08:00 | ❌ error |
| ai-leaders-tracker | 08:00 | ❌ error |
| daily-ai-news | 09:00 | ❌ error |
| daily-github-commits | 10:00 | ❌ error |
| evening-reminder | 18:00 | ✅ ok |
| daily-cron-report | 22:00 | ✅ ok |
| friday-weekly-report | 周五 17:00 | 🔵 idle |
| rag-trends-weekly | 周一 09:00 | ✅ ok |
| tech-trends-weekly | 周一 09:00 | 🔵 idle |
| weekly-github-summary | 周一 10:00 | 🔵 idle |
| monthly-review | 每月1日 10:00 | 🔵 idle |

> ⚠️ 部分任务 error 是因为 web_search 未配置

## 📂 关键路径

| 路径 | 说明 |
|------|------|
| `~/.openclaw/openclaw.json` | 主配置文件 |
| `~/.openclaw/extensions/feishu/` | 第三方飞书插件 |
| `~/.openclaw/cron/jobs.json` | Cron 任务配置 |
| `~/.openclaw/logs/` | 日志目录 |
| `~/.openclaw/scripts/` | 自定义脚本 |
| `~/Library/LaunchAgents/ai.openclaw.gateway.plist` | LaunchAgent |
| `~/.dotfiles/` | Dotfiles Git 仓库 |

## 🔐 安全配置

- **Gateway 认证**: Token 模式
- **飞书密钥**: 存储在 dotfiles 加密文件中
- **加密方式**: OpenSSL AES-256-CBC + PBKDF2
- **加密密码**: `openclaw2026`

