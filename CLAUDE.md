# OpenClaw 本地项目 - AI 接手指南

> 本文件供后续 AI 快速了解项目状态和上下文

## 🎯 项目目标

管理和优化本地部署的 OpenClaw (v2026.2.23)，集成飞书作为通信渠道。

## 📋 快速状态

| 组件 | 状态 | 备注 |
|------|:----:|------|
| OpenClaw Gateway | ✅ | LaunchAgent 自动管理 |
| 飞书通道 | ✅ | WebSocket 长连接 |
| AI 模型 (百炼) | ✅ | qwen3.5-plus + fallback |
| Web Search | ❌ | **待配置** |
| LanceDB Memory | ⚠️ | 缺依赖，待修复 |
| Cron 任务 | ⚠️ | 部分 error（缺 web search） |

## 🔧 关键配置路径

```
~/.openclaw/openclaw.json          # 主配置
~/.openclaw/extensions/feishu/     # 第三方飞书插件
~/.openclaw/cron/jobs.json         # Cron 任务
~/.openclaw/scripts/               # 自定义脚本
~/.dotfiles/                       # Dotfiles Git 仓库
~/Library/LaunchAgents/ai.openclaw.gateway.plist  # LaunchAgent
```

## 🚨 当前最高优先级任务

1. **配置 Web Search** - 评估 Serper.dev / Tavily MCP / Brave Search
2. **启用 LanceDB** - 安装 @lancedb/lancedb 依赖
3. **飞书文档权限** - 添加 docs:permission.member:update

## 📝 常用命令

```bash
# 状态检查
openclaw status

# 日志查看
tail -f ~/.openclaw/logs/gateway.log

# 重启服务
launchctl bootout gui/$(id -u)/ai.openclaw.gateway
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.gateway.plist

# Cron 管理
openclaw cron list
openclaw cron run <ID>

# 发消息测试
openclaw message send --channel feishu --target "oc_xxx" -m "测试"
```

## 🔗 相关资源

- **Dotfiles 仓库**: https://github.com/Alenryuichi/openclaw-dotfiles
- **飞书应用**: https://open.feishu.cn/app/cli_a914d0c6033adcc5
- **百炼控制台**: https://dashscope.console.aliyun.com/
- **OpenClaw 文档**: https://docs.openclaw.ai/

## 📚 详细文档

- [docs/CURRENT-STATUS.md](docs/CURRENT-STATUS.md) - 完整配置状态
- [docs/ISSUES.md](docs/ISSUES.md) - 问题追踪
- [docs/ROADMAP.md](docs/ROADMAP.md) - 发展计划
- [docs/TUTORIALS.md](docs/TUTORIALS.md) - 配置教程

## ⚠️ 注意事项

1. **升级 OpenClaw 后** - memory-lancedb 的 DashScope patch 会被覆盖
2. **多机部署** - 同一飞书 App 只允许一个 WebSocket 连接
3. **Secrets 加密密码** - `openclaw2026`
4. **飞书插件重复警告** - 可忽略，第三方插件覆盖内置

---

*最后更新: 2026-02-26*

