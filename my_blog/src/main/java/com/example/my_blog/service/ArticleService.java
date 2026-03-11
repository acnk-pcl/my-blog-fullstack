package com.example.my_blog.service;

import com.example.my_blog.entity.Article;
import com.example.my_blog.mapper.ArticleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    //调用Mapper层的插入方法
    public int addArticle(Article article){
        return articleMapper.insert(article);
    }
}
