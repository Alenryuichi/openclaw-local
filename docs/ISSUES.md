# 问题追踪

> 记录已知问题、待解决事项和已完成的修复

## 🔴 待解决问题

### 1. Web Search 未配置

**问题**: OpenClaw 的 `web_search` 工具未配置，导致需要联网搜索的任务失败

**影响**: 
- 多个 cron 任务报 error（coding-tip-daily, ai-leaders-tracker, daily-ai-news 等）
- AI 无法获取实时网络信息

**可选方案**:

| 方案 | 说明 | 状态 |
|------|------|:----:|
| Brave Search | 免费层 2000次/月（用户称收费） | ❓ 待验证 |
| Serper.dev | 免费层 2500次/月 | 🔵 待尝试 |
| Tavily MCP | 专为 AI Agent 设计的搜索 | 🔵 待研究 |
| SearXNG | 本地 Docker 部署 | ⚠️ 脚本存在但未集成 |

**相关文件**:
- `~/.openclaw/scripts/searxng-search.sh` - 未集成的 SearXNG 脚本

---

### 2. LanceDB 依赖缺失

**问题**: memory-lancedb 插件启用但缺少 `@lancedb/lancedb` 模块

**影响**: 向量记忆功能不可用

**解决方案**:
```bash
cd /opt/homebrew/lib/node_modules/openclaw/extensions/memory-lancedb
npm install @lancedb/lancedb
```

**状态**: 🔵 已知解决方案，待执行

---

### 3. 飞书文档权限问题

**问题**: 机器人创建的文档，用户无法编辑

**影响**: 需要手动设置文档权限或让 AI 设置

**解决方案**:
1. 在飞书开放平台添加权限: `docs:permission.member:update`
2. 让 AI 执行: `把文档 xxx 设置为"组织内获得链接的人可编辑"`

**状态**: ⚠️ 部分解决（需添加权限）

---

### 4. 重复插件警告

**问题**: `duplicate plugin id detected` 警告频繁出现

**原因**: 第三方 feishu 插件覆盖内置插件

**影响**: 无实际影响，仅为警告

**状态**: ✅ 已知，可忽略

---

## ✅ 已解决问题

| 问题 | 解决方案 | 日期 |
|------|----------|------|
| 卡片消息不显示 | 添加 `cardkit:card:write` 权限 | 2026-02-25 |
| 图片无法理解 | 启用 `downloadImages` + `vision` | 2026-02-25 |
| Cron 不发群聊 | 配置 `groupAllowlist` + `--to` | 2026-02-25 |
| 浏览器非 Headless | 设置 `browser.headless: true` | 2026-02-25 |
| 飞书文档格式差 | 恢复第三方插件 `import_document` | 2026-02-25 |
| AI 报"群聊通知未发送" | 更新任务 prompt 说明系统自动发送 | 2026-02-25 |
| 模型单点故障 | 配置 fallback 链 | 2026-02-25 |

---

## 📝 注意事项

1. **升级 OpenClaw 后**: memory-lancedb 的 DashScope 修改会被覆盖，需重新 patch
2. **多机部署**: 同一飞书 App 只允许一个 WebSocket 连接，后连接会踢掉先连接
3. **Docker 未启动**: SearXNG 依赖 Docker，当前 Docker 未运行

