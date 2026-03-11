@echo off
cd /d "D:\project\my_blog"
powershell -ExecutionPolicy Bypass -File "git-push-blog.ps1"
pause