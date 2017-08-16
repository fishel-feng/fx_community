package com.fx.controller;

import com.fx.entity.*;
import com.fx.service.ArticleService;
import com.fx.service.CommentService;
import com.fx.service.UserService;
import com.fx.util.LogUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.*;

@Controller
@RequestMapping("article")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    @RequestMapping("/list/{currentPage}")
    public ModelAndView getArticlePageList(HttpSession session, @PathVariable("currentPage") int currentPage) {
        ModelAndView modelAndView = new ModelAndView();
        PageBean articlePageBean = articleService.getArticlePageList(currentPage, 10);
        modelAndView.addObject("articlePageBean", articlePageBean);
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            session.setAttribute("user", userService.getUserById(user.getUid()));
        }
        modelAndView.setViewName("article/articleList");
        return modelAndView;
    }

    @RequestMapping("/details/{aid}")
    public ModelAndView getArticleByID(@PathVariable("aid") Integer aid) {
        ModelAndView modelAndView = new ModelAndView();
        Article article = articleService.getArticleById(aid);
        List<Comment> commentList = commentService.findComment(aid, null);
        List<Floor> floorList = commentService.findFloorComment(aid, null);
        modelAndView.addObject(article);
        modelAndView.addObject(commentList);
        modelAndView.addObject("floor", floorList);
        modelAndView.setViewName("article/articleContent");
        return modelAndView;
    }

    @RequestMapping("/delete/{aid}")
    @ResponseBody
    public Map<String, String> deleteArticleByID(HttpSession session, @PathVariable("aid") Integer aid) {
        Map<String, String> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        Integer uid = articleService.getArticleById(aid).getUser().getUid();
        if (!Objects.equals(user.getUid(), uid)) {
            map.put("data", "只能删除自己的帖子！");
            return map;
        }
        int result = articleService.deleteArticleById(aid);
        if (result > 0) {
            LogUtils.info("成功删除id为{}的帖子！", aid);
            map.put("data", "删除成功！");
        } else {
            LogUtils.info("删除失败id为{}的帖子！", aid);
            map.put("data", "删除失败！");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/floor/add", method = RequestMethod.POST)
    public Map<String, String> findFloorComment(HttpSession session, @RequestParam("aid") Integer aid, @RequestParam("cid") Integer cid, @RequestParam("uid") Integer uid, @RequestParam("content") String content) {
        Map<String, String> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (!Objects.equals(user.getUid(), uid)) {
            map.put("data", "回复失败！");
            return map;
        }
        int result = commentService.addFloorComment(aid, cid, uid, content);
        if (result > 0) {
            LogUtils.info("楼中楼评论成功!内容=>" + content);
        } else {
            LogUtils.info("楼中楼评论失败!");
        }
        return map;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> addArticle(HttpSession session, @RequestParam(value = "title") String title, @RequestParam(value = "content") String content, @RequestParam(value = "uid") Integer uid, @RequestParam(value = "lable") String lable) {
        Map<String, String> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            map.put("data", "请登录后在发帖！");
            return map;
        }
        if (StringUtils.isEmpty(title) || StringUtils.isBlank(title)) {
            map.put("data", "标题不能为空！");
            return map;
        }
        int result = articleService.addArticle(title, content, new Timestamp(new Date().getTime()), uid, lable);
        if (result > 0) {
            LogUtils.info("发帖成功,标题:{},内容长度:{}", title, content.length());
            map.put("data", "发帖成功！");
        } else {
            LogUtils.info("发帖失败！");
        }
        return map;
    }


    @RequestMapping("/search")
    public ModelAndView SearchArticle(@RequestParam("key") String key) {
        ModelAndView modelAndView = new ModelAndView();
        List<Article> list = articleService.searchArticleByKey(key);
        LogUtils.info("查询关键字:{},共查询到{}条记录", key, list.size());
        modelAndView.addObject("key", key);
        modelAndView.addObject("resultList", list);
        modelAndView.setViewName("search");
        return modelAndView;
    }
}
