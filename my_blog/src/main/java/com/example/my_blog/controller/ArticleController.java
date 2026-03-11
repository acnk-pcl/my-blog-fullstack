package com.example.my_blog.controller;

import com.example.my_blog.entity.Article;
import com.example.my_blog.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    // 新增文章接口，接收JSON格式的文章数据
    @PostMapping("/article/add")
    public String addArticle(@RequestBody Article article) {
        int result = articleService.addArticle(article);
        if (result > 0) {
            return "文章新增成功！";
        } else {
            return "文章新增失败！";
        }
    }
}