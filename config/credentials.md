# 凭证参考

> ⚠️ 敏感信息已脱敏，完整凭证存储在 `~/.dotfiles/secrets.env.enc`

## 🔐 凭证清单

### 飞书应用

| 项目 | 值 | 说明 |
|------|-----|------|
| **App ID** | `cli_a914d0c6033adcc5` | 公开，可直接使用 |
| **App Secret** | `7yTh4s************emkD` | 飞书开放平台获取 |

**管理链接**: https://open.feishu.cn/app/cli_a914d0c6033adcc5

---

### 阿里云百炼

| 项目 | 值 | 用途 |
|------|-----|------|
| **Coding Plan API Key** | `sk-sp-d2eb***********3ca6` | AI 模型调用 |
| **DashScope API Key** | `sk-971f***********66fa` | Embedding 模型 |

**控制台**: https://dashscope.console.aliyun.com/

---

### OpenClaw Gateway

| 项目 | 值 |
|------|-----|
| **Auth Token** | `169af7***************d61a` |
| **Dashboard** | http://127.0.0.1:18789/ |

---

### 群聊 ID

| 群聊 | ID |
|------|-----|
| **Cron 任务群** | `oc_d6abf34f98733528e4599e5e59cb56e7` |

---

## 📦 加密存储

完整凭证存储在 dotfiles 仓库的加密文件中：

```bash
# 解密查看
cd ~/.dotfiles
openssl enc -aes-256-cbc -pbkdf2 -d -in secrets.env.enc -out secrets.env

# 密码
openclaw2026

# 用完后删除明文
rm secrets.env
```

---

## 🔄 凭证轮换

### 飞书 App Secret

1. 访问 https://open.feishu.cn/app/cli_a914d0c6033adcc5/credential
2. 点击"重置"
3. 更新 `~/.openclaw/openclaw.json` 中的 `appSecret`
4. 重启 Gateway

### 百炼 API Key

1. 访问 https://dashscope.console.aliyun.com/apiKey
2. 创建新 Key / 禁用旧 Key
3. 更新配置
4. 重启 Gateway

---

*最后更新: 2026-02-26*

