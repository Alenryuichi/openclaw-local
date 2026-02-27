# OpenClaw 本地部署项目

> 本项目记录 OpenClaw 在本地 Mac 上的部署配置、当前状态、问题追踪和未来发展计划。

## 🦞 项目概述

| 项目 | 值 |
|------|-----|
| **OpenClaw 版本** | 2026.2.23 |
| **部署环境** | macOS 15.7.3 (arm64) |
| **AI 模型提供商** | 阿里云百炼 (Coding Plan) |
| **主要模型** | qwen3.5-plus (1000k ctx) |
| **通信渠道** | 飞书 (WebSocket 长连接) |
| **Dotfiles 仓库** | [Alenryuichi/openclaw-dotfiles](https://github.com/Alenryuichi/openclaw-dotfiles) |

## 📁 项目结构

```
openclaw-local/
├── README.md              # 项目说明（本文件）
├── CLAUDE.md              # AI 接手指南（快速上下文）
├── docs/
│   ├── CURRENT-STATUS.md  # 当前状态和配置
│   ├── ISSUES.md          # 问题追踪
│   ├── ROADMAP.md         # 未来发展计划
│   ├── TUTORIALS.md       # 教程和指南
│   └── HISTORY.md         # 历史决策记录
└── config/
    └── credentials.md     # 凭证参考（敏感信息已脱敏）
```

## 🚀 快速命令

```bash
# 检查状态
openclaw status

# 查看日志
openclaw logs --follow

# 重启服务
launchctl bootout gui/$(id -u)/ai.openclaw.gateway
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.gateway.plist

# 发送消息测试
openclaw message send --channel feishu --target "群聊ID" -m "测试消息"
```

## 📚 相关文档

- [AI 接手指南](CLAUDE.md) - **后续 AI 先看这个**
- [当前状态](docs/CURRENT-STATUS.md) - 配置详情、插件状态、Cron 任务
- [问题追踪](docs/ISSUES.md) - 已知问题和待解决事项
- [发展路线](docs/ROADMAP.md) - 未来优化计划
- [教程指南](docs/TUTORIALS.md) - 配置教程汇总
- [历史记录](docs/HISTORY.md) - 历史决策和对话上下文

## 🔗 外部链接

- [OpenClaw 官方文档](https://docs.openclaw.ai/)
- [飞书开放平台](https://open.feishu.cn/app/cli_a914d0c6033adcc5)
- [阿里云百炼控制台](https://dashscope.console.aliyun.com/)

---

*最后更新: 2026-02-26*

