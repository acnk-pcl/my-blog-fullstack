@echo off
:: 1. 强制设置控制台为UTF-8编码（解决乱码核心）
chcp 65001 >nul 2>&1
:: 2. 启用延迟变量扩展（解决if判断中变量赋值问题）
setlocal enabledelayedexpansion

:: ===================== 可配置项（修改为你的实际路径） =====================
set "PROJECT_DIR=D:\project\my_blog"
set "DEFAULT_COMMIT_MSG=Update full-stack blog project"
set "REMOTE_BRANCH=main"
:: ==========================================================================

:: 切换到项目目录（修复"文件名/目录名语法错误"）
echo 📂 切换到项目目录：%PROJECT_DIR%
cd /d "%PROJECT_DIR%"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：项目目录不存在或无法访问！
    pause
    exit /b 1
)

:: 添加所有更改（修复命令识别错误）
echo 🔄 正在添加所有更改...
git add .
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：Git Add 失败！
    pause
    exit /b 1
)

:: 检查是否有未提交的更改
git status --porcelain | findstr /r "^" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ✅ 暂无需要提交的更改！
    pause
    exit /b 0
)

:: 获取提交信息（修复变量名混用问题）
echo 📝 请输入提交信息（直接回车使用默认：%DEFAULT_COMMIT_MSG%）:
set /p "commit_msg="
if "!commit_msg!"=="" (
    set "commit_msg=%DEFAULT_COMMIT_MSG%"
)

:: 提交更改
echo 📤 正在提交更改...
git commit -m "!commit_msg!"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：Git Commit 失败！
    pause
    exit /b 1
)

:: 推送到远程仓库
echo 🚀 正在推送到 GitHub（分支：%REMOTE_BRANCH%）...
git push origin %REMOTE_BRANCH%

:: 推送结果判断（修复提示行命令截断问题）
if %ERRORLEVEL% EQU 0 (
    echo ✅ 推送成功！
    echo 💡 OpenClaw 将自动分析你的全栈项目。
) else (
    echo ❌ 推送失败！请按以下步骤排查：
    echo    1. 检查网络连接是否正常；
    echo    2. 检查GitHub权限（重点：公钥/凭证）；
    echo    3. 同步本地分支：git pull origin %REMOTE_BRANCH%；
    echo    4. 重新配置Git凭证：git config --global credential.helper manager-core；
)

pause
endlocal