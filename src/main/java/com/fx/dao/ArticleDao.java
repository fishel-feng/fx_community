package com.fx.dao;

import com.fx.entity.Article;
import org.apache.ibatis.annotations.Param;

import java.sql.Timestamp;
import java.util.List;

public interface ArticleDao {

    public List<Article> getArticleList();

    public Article getArticleById(@Param("aid") Integer aid);

    public int addArticle(@Param("title") String title, @Param("content") String content, @Param("date") Timestamp timestamp, @Param("uid") Integer uid, @Param("lable") String lable);

    public List<Article> getArticleByUid(@Param("uid") Integer uid);

    public int deleteArticleById(@Param("aid") Integer aid);

    public List<Article> getArticlePageList(@Param("start") int start, @Param("size") int size);

    public List<Article> searchArticleByKey(@Param("key") String key);
}
