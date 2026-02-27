# 历史决策记录

> 记录项目关键决策和对话上下文，供后续 AI 参考

## 📅 2026-02-25 ~ 2026-02-26 初始配置

### 技术选型决策

| 决策 | 选择 | 原因 |
|------|------|------|
| **AI 模型提供商** | 阿里云百炼 (Coding Plan) | 用户已有账号，支持中文好 |
| **通信渠道** | 飞书 WebSocket | 无需公网 IP，长连接稳定 |
| **飞书插件** | @m1heng-clawd/feishu | 支持 import_document，格式更好 |
| **Embedding 模型** | 百炼 text-embedding-v2 | 与 AI 模型同一提供商，1536 维度 |
| **进程管理** | macOS LaunchAgent | 开机自启 + 崩溃重启 |
| **配置管理** | Dotfiles + OpenSSL 加密 | Git 版本控制 + 安全存储 |

### 关键配置历程

1. **初始安装** - OpenClaw v2026.2.23 通过 npm 全局安装
2. **飞书集成** - 使用 WebSocket 模式，无需公网
3. **模型配置** - qwen3.5-plus 主模型 + fallback 链
4. **插件冲突** - 第三方插件覆盖内置插件（预期行为）
5. **Cron 任务** - 11 个定时任务，发送到指定群聊
6. **Vision 支持** - 启用图片理解功能
7. **Headless 浏览器** - 配置无头模式
8. **Dotfiles 备份** - 创建 Git 仓库并推送到 GitHub

### 遇到的问题和解决方案

| 问题 | 解决方案 |
|------|----------|
| 飞书消息无卡片样式 | 添加 `cardkit:card:write` 权限 |
| Cron 不发群聊 | 配置 `groupAllowlist` + `groupAllowFrom` |
| AI 报"群聊未发送" | 更新 prompt 说明系统自动发送 |
| 图片无法理解 | 启用 `downloadImages` + `vision` |

---

## 🔍 Web Search 调研（进行中）

### 背景

OpenClaw 的 `web_search` 工具原生只支持：
- **Brave Search** - 用户称需付费
- **Perplexity Sonar** - 需要 OpenRouter 充值

### 已排除方案

| 方案 | 原因 |
|------|------|
| SearXNG 脚本 | 存在但未集成到 OpenClaw |
| Brave Search | 用户反馈不免费 |

### 待研究方案

| 方案 | 说明 | 状态 |
|------|------|:----:|
| **Serper.dev** | Google Search API，2500 免费/月 | 🔵 待尝试 |
| **Tavily MCP** | 专为 AI Agent 设计 | 🔵 待研究 |
| **awesome-openclaw-skills** | 社区 Skill 仓库 | 🔵 待查看 |

---

## 📋 多机部署讨论

### 问题

用户询问：如果另一台机器使用相同 dotfiles 部署，飞书消息会发到哪台？

### 结论

飞书 WebSocket 是**单实例设计**：
- 同一 App ID 只允许一个活跃 WebSocket 连接
- 后连接会踢掉先连接

### 建议方案

用户选择**创建新的飞书应用**，而不是主备模式。

---

## 🔗 重要链接汇总

| 资源 | 链接 |
|------|------|
| Dotfiles 仓库 | https://github.com/Alenryuichi/openclaw-dotfiles |
| 飞书应用管理 | https://open.feishu.cn/app/cli_a914d0c6033adcc5 |
| 百炼控制台 | https://dashscope.console.aliyun.com/ |
| OpenClaw 文档 | https://docs.openclaw.ai/ |
| awesome-openclaw-skills | https://github.com/VoltAgent/awesome-openclaw-skills |

---

## 💡 用户偏好

- **语言**: 中文
- **执行模式**: 自闭环执行（proceed without asking）
- **时区**: Asia/Shanghai (UTC+8)

---

*最后更新: 2026-02-26*

