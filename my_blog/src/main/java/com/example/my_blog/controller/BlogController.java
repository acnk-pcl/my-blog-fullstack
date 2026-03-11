package com.example.my_blog.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "http://localhost:5173")
public class BlogController {

    @GetMapping("/api/test")
    public String test(){
        return "Backend is working";
    }

    @GetMapping("/api/posts")
    public String[] getPosts(){
        return new String[]{"Post 1", "Post 2", "Post 3"};
    }
}
