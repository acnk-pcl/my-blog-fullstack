<#
.SYNOPSIS
全栈博客项目Git自动推送脚本
.DESCRIPTION
支持自定义提交信息，包含完整的错误检查和友好提示
.PARAMETER CommitMessage
可选，自定义提交信息（默认：Update full-stack blog project）
.EXAMPLE
.\git-push-blog.ps1 "修复首页响应式布局问题"
#>

# ===================== 可配置项 =====================
$projectDir = "D:\project\my_blog"
$defaultCommitMsg = "Update full-stack blog project"
$remoteBranch = "main"
# ====================================================

# 设置编码和控制台样式
$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$host.ui.RawUI.WindowTitle = "Blog Git Push Script"

# 检查Git是否可用
try {
    Get-Command git -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "❌ 错误：未找到Git命令，请先安装Git并配置到环境变量" -ForegroundColor Red
    exit 1
}

# 切换到项目目录
try {
    Write-Host "📂 切换到项目目录：$projectDir" -ForegroundColor Cyan
    Set-Location $projectDir -ErrorAction Stop
}
catch {
    Write-Host "❌ 错误：项目目录不存在或无法访问：$projectDir" -ForegroundColor Red
    exit 1
}

# 检查是否是Git仓库
if (-not (Test-Path ".git" -PathType Container)) {
    Write-Host "❌ 错误：当前目录不是Git仓库，请先执行 git init 并关联远程仓库" -ForegroundColor Red
    exit 1
}

# 添加所有更改
Write-Host "🔄 正在添加所有更改..." -ForegroundColor Cyan
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 错误：Git Add 失败，请检查文件权限或路径" -ForegroundColor Red
    exit 1
}

# 检查是否有未提交的更改
$hasChanges = git status --porcelain
if ([string]::IsNullOrEmpty($hasChanges)) {
    Write-Host "✅ 暂无需要提交的更改，无需推送" -ForegroundColor Green
    exit 0
}

# 处理提交信息（参数优先，无参数则用默认值）
param(
    [string]$CommitMessage = $defaultCommitMsg
)

# 提交更改
Write-Host "📝 正在提交更改（信息：$CommitMessage）..." -ForegroundColor Cyan
git commit -m $CommitMessage
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 错误：Git Commit 失败" -ForegroundColor Red
    exit 1
}

# 推送到远程仓库
Write-Host "🚀 正在推送到 GitHub（分支：$remoteBranch）..." -ForegroundColor Cyan
git push origin $remoteBranch
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 推送成功！" -ForegroundColor Green
    Write-Host "💡 OpenClaw 将自动分析你的全栈项目。" -ForegroundColor Yellow
}
else {
    Write-Host "❌ 推送失败！请检查以下项：" -ForegroundColor Red
    Write-Host "   1. 网络连接是否正常" -ForegroundColor Yellow
    Write-Host "   2. GitHub 凭证是否有效（执行：git config --global credential.helper manager-core 重新登录）" -ForegroundColor Yellow
    Write-Host "   3. 本地分支与远程同步（执行：git pull origin $remoteBranch）" -ForegroundColor Yellow
    exit 1
}