@echo off
echo Starting Spring Boot backend...
start cmd /c "cd D:\project\my_blog\my_blog && mvn spring-boot:run"

echo Starting Vue frontend...
start cmd /c "cd D:\project\my_blog\my_blog_frontend && npm run dev"

echo Both servers started!
pause