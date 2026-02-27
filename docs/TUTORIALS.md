# 教程和指南

> OpenClaw 配置和使用教程汇总

## 📚 教程目录

1. [Memory-LanceDB 使用 DashScope 配置](#memory-lancedb-使用-dashscope-配置)
2. [飞书文档权限设置](#飞书文档权限设置)
3. [Cron 任务管理](#cron-任务管理)
4. [Dotfiles 管理](#dotfiles-管理)

---

## Memory-LanceDB 使用 DashScope 配置

> 详细教程已发送到飞书文档，这里是简要步骤

### 1. 修改插件源码

```bash
cd /opt/homebrew/lib/node_modules/openclaw/extensions/memory-lancedb

# 备份
cp index.ts index.ts.bak

# 修改 new OpenAI({ apiKey }) 为：
# new OpenAI({ apiKey, baseURL: "https://dashscope.aliyuncs.com/compatible-mode/v1" })
```

### 2. 配置 OpenClaw

```bash
openclaw config set plugins.entries.memory-lancedb.enabled true
openclaw config set plugins.entries.memory-lancedb.config.embedding.apiKey "你的百炼API_KEY"
openclaw config set plugins.entries.memory-lancedb.config.embedding.model "text-embedding-v2"
```

### 3. 安装依赖

```bash
cd /opt/homebrew/lib/node_modules/openclaw/extensions/memory-lancedb
npm install @lancedb/lancedb
```

### 4. 创建 Patch 脚本

```bash
cat > ~/.openclaw/scripts/patch-lancedb.sh << 'EOF'
#!/bin/bash
PLUGIN_PATH="/opt/homebrew/lib/node_modules/openclaw/extensions/memory-lancedb"
sed -i.bak 's/new OpenAI({ apiKey })/new OpenAI({ apiKey, baseURL: "https:\/\/dashscope.aliyuncs.com\/compatible-mode\/v1" })/' "$PLUGIN_PATH/index.ts"
echo "✅ Patched memory-lancedb for DashScope"
EOF
chmod +x ~/.openclaw/scripts/patch-lancedb.sh
```

---

## 飞书文档权限设置

### 添加 API 权限

1. 访问 https://open.feishu.cn/app/cli_a914d0c6033adcc5/auth
2. 搜索并开通：
   - `docs:permission.member:update` - 更新协作者权限
   - `docs:permission.member:read` - 查看协作者
   - `docs:permission:transfer` - 转移所有权（可选）

### 让 AI 设置权限

```
把文档 [文档Token] 设置为"组织内获得链接的人可编辑"
```

或在创建文档时指定：
```
创建文档后，设置文档权限为"组织内获得链接的人可编辑"
```

---

## Cron 任务管理

### 常用命令

```bash
# 列出所有任务
openclaw cron list

# 查看任务详情
openclaw cron get <任务ID>

# 手动执行任务
openclaw cron run <任务ID>

# 编辑任务
openclaw cron edit <任务ID> --message "新的 prompt"

# 设置发送目标
openclaw cron edit <任务ID> --channel feishu --to "oc_群聊ID"
```

### 任务 Prompt 最佳实践

在任务 prompt 末尾添加：
```
## 重要说明
- 不需要手动发送群聊通知，系统会自动将任务结果发送到群聊
- 专注于生成内容即可
```

---

## Dotfiles 管理

### 仓库结构

```
~/.dotfiles/
├── openclaw/
│   ├── openclaw.json.template  # 配置模板
│   ├── cron-jobs.json          # Cron 任务备份
│   └── scripts/                # 自定义脚本
├── secrets.env.enc             # 加密的 API 密钥
└── install.sh                  # 安装脚本
```

### 加密/解密 Secrets

```bash
# 加密
openssl enc -aes-256-cbc -pbkdf2 -salt -in secrets.env -out secrets.env.enc

# 解密
openssl enc -aes-256-cbc -pbkdf2 -d -in secrets.env.enc -out secrets.env
# 密码: openclaw2026
```

### 同步更新

```bash
cd ~/.dotfiles

# 更新配置
cp ~/.openclaw/cron/jobs.json openclaw/cron-jobs.json

# 提交
git add -A
git commit -m "Update: 描述"
git push origin main
```

---

*最后更新: 2026-02-26*

