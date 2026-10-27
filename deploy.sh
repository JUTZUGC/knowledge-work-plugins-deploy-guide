#!/usr/bin/env bash
set -euo pipefail
# Knowledge Work Plugins 插件市场安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace
# 更新日期：2026-10-27
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "需要先安装 Node.js"; exit 1; }

mkdir -p .download
cd .download

npm install -g @anthropic-ai/claude-code
claude plugin marketplace add anthropics/knowledge-work-plugins
claude plugin install sales@knowledge-work-plugins
claude plugin list | grep -q knowledge-work-plugins && echo '插件已安装' || echo '未生效，先运行 claude --version 确认版本'

echo ""

echo "部署完成：插件已注册到 Claude Code，输入 /plugin 可以查看已安装列表并启用其它岗位包"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace"
