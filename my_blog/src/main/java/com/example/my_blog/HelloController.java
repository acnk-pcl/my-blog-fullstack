package com.example.my_blog;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

// 这个注解告诉Spring：这是一个处理Web请求的控制器，返回的是JSON/文本（不是页面）
@RestController
public class HelloController {
    // 这个注解告诉Spring：处理GET请求，访问路径是 /hello
    @GetMapping("/hello")
    public String sayhello(){
        // 返回给浏览器的内容
        return "Hello! 我的第一个Spring Boot博客项目启动成功啦！";
    }
}
