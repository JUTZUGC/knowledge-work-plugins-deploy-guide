# Knowledge Work Plugins 插件市场安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace
# 更新日期：2026-10-27
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

npm.cmd install -g @anthropic-ai/claude-code
claude plugin marketplace add anthropics/knowledge-work-plugins
claude plugin install sales@knowledge-work-plugins
claude plugin list | Select-String 'knowledge-work-plugins'

Write-Host ''

Write-Host '部署完成：插件已注册到 Claude Code，输入 /plugin 可以查看已安装列表并启用其它岗位包'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/anthropics/knowledge-work-plugins#plugin-marketplace'
