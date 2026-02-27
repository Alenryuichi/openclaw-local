#!/bin/bash
# FreshRSS 部署脚本
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$SCRIPT_DIR"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║              FreshRSS 部署脚本                               ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# 1. 检查 Docker
echo "🔍 检查 Docker..."
if ! command -v docker &> /dev/null; then
    echo "❌ Docker 未安装，请先安装 Docker"
    exit 1
fi
echo "✅ Docker 已安装"

# 2. 检查代理
echo ""
echo "🔍 检查代理 (127.0.0.1:7897)..."
if curl -s --proxy http://127.0.0.1:7897 --max-time 5 "https://github.com" > /dev/null 2>&1; then
    echo "✅ 代理可用"
else
    echo "⚠️  代理不可用，GitHub 源可能无法同步"
fi

# 3. 创建数据目录
echo ""
echo "📁 创建数据目录..."
mkdir -p freshrss/data freshrss/extensions
echo "✅ 目录已创建"

# 4. 启动容器
echo ""
echo "🚀 启动 FreshRSS..."
docker-compose up -d

# 5. 等待服务启动
echo ""
echo "⏳ 等待服务启动..."
sleep 5

# 6. 检查服务状态
if docker-compose ps | grep -q "Up"; then
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    部署成功! ✅                              ║"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║                                                              ║"
    echo "║  🌐 访问地址: http://localhost:8080                          ║"
    echo "║                                                              ║"
    echo "║  📋 下一步:                                                  ║"
    echo "║     1. 打开浏览器访问上述地址                                ║"
    echo "║     2. 创建管理员账号                                        ║"
    echo "║     3. 导入 OPML: opml/ai-trends.opml                        ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
else
    echo "❌ 部署失败，请检查日志: docker-compose logs"
    exit 1
fi
