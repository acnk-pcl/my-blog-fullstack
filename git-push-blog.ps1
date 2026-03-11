# Full-stack blog project auto-push script
# Usage: .\git-push-blog.ps1 [optional commit message]

param(
    [string]$CommitMessage = "Update full-stack blog project"
)

$projectDir = "D:\project\my_blog"

# Enter project directory
Set-Location $projectDir

# Check if in Git repository
if (!(Test-Path ".git")) {
    Write-Host "❌ Current directory is not a Git repository!" -ForegroundColor Red
    Write-Host "Please initialize Git repo and add remote origin" -ForegroundColor Yellow
    exit 1
}

# Add all changes
Write-Host "🔄 Adding files..." -ForegroundColor Cyan
git add .

# Check if there are changes to commit
$hasChanges = git status --porcelain
if ([string]::IsNullOrEmpty($hasChanges)) {
    Write-Host "✅ No new changes to push" -ForegroundColor Green
    exit 0
}

# Commit changes
Write-Host "📝 Committing changes..." -ForegroundColor Cyan
git commit -m "$CommitMessage"

# Push to GitHub
Write-Host "📤 Pushing to GitHub..." -ForegroundColor Cyan
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Push successful! OpenClaw will analyze your full-stack project." -ForegroundColor Green
    Write-Host "💡 Tip: Say 'analyze my blog project' in chat for instant feedback" -ForegroundColor Yellow
} else {
    Write-Host "❌ Push failed! Please check network and GitHub credentials." -ForegroundColor Red
}