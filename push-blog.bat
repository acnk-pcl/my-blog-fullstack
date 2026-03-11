@echo off
cd /d "D:\project\my_blog"
echo 🔄 正在添加文件...
git add .

echo 📝 请输入提交信息（直接回车使用默认）:
set /p commit_msg=
if "%commitMsg%"=="" (
    set commit_msg=Update full-stack blog project
)

echo 📤 正在提交更改...
git commit -m "%commitMsg%"

echo 🚀 正在推送到 GitHub...
git push origin main

if %ERRORLEVEL% EQU 0 (
    echo ✅ 推送成功！
    echo 💡 OpenClaw 将自动分析你的全栈项目。
) else (
    echo ❌ 推送失败！请检查网络连接和 GitHub 凭证。
)

pause