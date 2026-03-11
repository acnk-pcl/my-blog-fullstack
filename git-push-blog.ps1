# Full-stack blog project auto-push script
# Usage: .\git-push-fullstack.ps1 [optional commit message]

param(
    [string]$CommitMessage = "Update full-stack blog project"
)

$projectDir = "D:\project\my_blog"

# Enter project directory
Set-Location $projectDir

# Check if in Git repository
if (!(Test-Path ".git")) {
    Write-Host "❌ 当前目录不是 Git 仓库！" -ForegroundColor Red
    Write-Host "请先初始化 Git 仓库并添加远程地址" -ForegroundColor Yellow
    exit 1
}

# Add all changes
Write-Host "🔄 正在添加文件..." -ForegroundColor Cyan
git add .

# Check if there are changes to commit
$hasChanges = git status --porcelain
if ([string]::IsNullOrEmpty($hasChanges)) {
    Write-Host "✅ 没有新的更改需要推送" -ForegroundColor Green
    exit 0
}

# Commit changes
Write-Host "📝 正在提交更改..." -ForegroundColor Cyan
git commit -m "$CommitMessage"

# Push to GitHub
Write-Host "🚀 正在推送到 GitHub..." -ForegroundColor Cyan
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 推送成功！" -ForegroundColor Green
    Write-Host "💡 OpenClaw 将自动分析你的全栈项目。" -ForegroundColor Yellow
} else {
    Write-Host "❌ 推送失败！请检查网络连接和 GitHub 凭证。" -ForegroundColor Red
}