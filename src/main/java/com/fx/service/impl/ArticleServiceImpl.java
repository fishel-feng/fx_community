package com.fx.service.impl;

import com.fx.dao.ArticleDao;
import com.fx.entity.Article;
import com.fx.entity.PageBean;
import com.fx.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleDao articleDao;

    @Override
    public List<Article> getArticleList() {
        return articleDao.getArticleList();
    }

    @Override
    public Article getArticleById(Integer aid) {
        return articleDao.getArticleById(aid);
    }

    @Override
    public int addArticle(String title, String content, Timestamp timestamp, Integer uid, String lable) {
        return articleDao.addArticle(title, content, timestamp, uid, lable);
    }

    @Override
    public List<Article> getArticleByUid(Integer uid) {
        return articleDao.getArticleByUid(uid);
    }

    @Override
    public int deleteArticleById(Integer aid) {
        return articleDao.deleteArticleById(aid);
    }

    @Override
    public PageBean getArticlePageList(int currentPage, int pageSize) {
        int count = articleDao.getArticleList().size();
        int totalPage = (int) Math.ceil(count * 1.0 / pageSize);
        List<Article> articleList = articleDao.getArticlePageList((currentPage - 1) * pageSize, pageSize);
        return new PageBean(currentPage, pageSize, count, totalPage, articleList);
    }

    @Override
    public List<Article> searchArticleByKey(String key) {
        return articleDao.searchArticleByKey(key);
    }
}
