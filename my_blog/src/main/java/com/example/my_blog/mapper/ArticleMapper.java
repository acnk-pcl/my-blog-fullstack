package com.example.my_blog.mapper;

import com.example.my_blog.entity.Article;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ArticleMapper {
   @Insert("INSERT INTO article(title, content) VALUES(#{title}, #{content})")
   int insert(Article article);
}
