package com.example.my_blog.entity;

import java.time.LocalDateTime;

// 对应数据库的article表，存储文章数据
public class Article {
    private Long id; // 文章ID
    private String title; // 标题
    private String content; // 内容
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间

    // 生成getter/setter方法（IDEA中按Alt+Insert，选择Getter and Setter，全选字段）
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
    public LocalDateTime getUpdateTime() { return updateTime; }
    public void setUpdateTime(LocalDateTime updateTime) { this.updateTime = updateTime; }
}