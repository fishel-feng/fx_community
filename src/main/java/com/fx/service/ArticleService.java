package com.fx.service;

import com.fx.entity.Article;
import com.fx.entity.PageBean;

import java.sql.Timestamp;
import java.util.List;

public interface ArticleService {

    public List<Article> getArticleList();

    public Article getArticleById(Integer aid);

    public int addArticle(String title, String content, Timestamp timestamp, Integer uid, String lable);

    public List<Article> getArticleByUid(Integer uid);

    public int deleteArticleById(Integer aid);

    public PageBean getArticlePageList(int currentPage, int pageSize);

    public List<Article> searchArticleByKey(String key);
}
