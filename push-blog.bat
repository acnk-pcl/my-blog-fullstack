@echo off
chcp 65001 >nul 2>&1  :: 解决中文乱码
setlocal enabledelayedexpansion

:: ===================== 可配置项 =====================
set "PROJECT_DIR=D:\project\my_blog"
set "DEFAULT_COMMIT_MSG=Update full-stack blog project"
set "REMOTE_BRANCH=main"
:: ====================================================

:: 检查Git是否可用
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：未找到Git命令，请先安装Git并配置到环境变量
    pause
    exit /b 1
)

:: 切换到项目目录
echo 📂 切换到项目目录：%PROJECT_DIR%
cd /d "%PROJECT_DIR%"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：项目目录不存在 %PROJECT_DIR%
    pause
    exit /b 1
)

:: 检查是否是Git仓库
if not exist ".git" (
    echo ❌ 错误：当前目录不是Git仓库，请先初始化仓库
    pause
    exit /b 1
)

:: 添加所有更改
echo 🔄 正在添加所有更改...
git add .
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：Git Add 失败，请检查文件权限或路径
    pause
    exit /b 1
)

:: 检查是否有未提交的更改
git status --porcelain | findstr /r "^" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ✅ 暂无需要提交的更改，无需推送
    pause
    exit /b 0
)

:: 获取提交信息（支持手动输入或默认值）
echo 📝 请输入提交信息（直接回车使用默认：%DEFAULT_COMMIT_MSG%）:
set /p "commit_msg="
if "!commit_msg!"=="" (
    set "commit_msg=%DEFAULT_COMMIT_MSG%"
)

:: 提交更改
echo 📤 正在提交更改...
git commit -m "!commit_msg!"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：Git Commit 失败（可能是无更改或提交信息不合法）
    pause
    exit /b 1
)

:: 推送到远程仓库
echo 🚀 正在推送到 GitHub（分支：%REMOTE_BRANCH%）...
git push origin %REMOTE_BRANCH%
if %ERRORLEVEL% EQU 0 (
    echo ✅ 推送成功！
    echo 💡 OpenClaw 将自动分析你的全栈项目。
) else (
    echo ❌ 推送失败！请检查：
    echo    1. 网络连接是否正常
    echo    2. GitHub 凭证是否有效（可尝试重新登录：git config --global credential.helper manager-core）
    echo    3. 本地分支是否与远程同步（可尝试：git pull origin %REMOTE_BRANCH%）
)

pause
endlocal