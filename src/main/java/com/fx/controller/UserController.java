package com.fx.controller;

import com.fx.entity.Article;
import com.fx.entity.User;
import com.fx.service.ArticleService;
import com.fx.service.UserService;
import com.fx.util.LogUtils;
import com.fx.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ArticleService articleService;

    @RequestMapping(value = "/regist", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> regist(@RequestParam("username") String username, @RequestParam("password") String password) {
        Map<String, String> map = new HashMap<>();
        if (userService.findUser(username, null) != null) {
            LogUtils.info("用户名已存在！");
            map.put("data", "用户名已存在！");
            return map;
        }
        String headimg = "/resources/imgs/head.png";
        int result = userService.addUser(username, StringUtils.MD5(password), headimg);
        if (result > 0) {
            LogUtils.info("注册成功！用户名:{},密码：{}", username, password);
            map.put("data", "注册成功,请重新登录！");
        } else {
            LogUtils.info("注册失败!");
            map.put("data", "注册失败！");
        }
        LogUtils.info("2");
        return map;
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> login(HttpSession session, @RequestParam("username") String username, @RequestParam("password") String password) {
        User user = userService.findUser(username, StringUtils.MD5(password));
        Map<String, String> map = new HashMap<>();
        if (user != null) {
            LogUtils.info("登录成功！用户名:{},密码：{}", username, password);
            map.put("data", "登录成功！");
            session.setAttribute("user", user);
        } else {
            LogUtils.info("登录失败!");
            map.put("data", "登录失败！");
        }
        return map;
    }

    @RequestMapping("/manager/{uid}")
    public ModelAndView getUserManager(@PathVariable("uid") Integer uid) {
        ModelAndView modelAndView = new ModelAndView();
        User user = userService.getUserById(uid);
        List<Article> articleList = articleService.getArticleByUid(uid);
        modelAndView.addObject("u", user);
        modelAndView.addObject("articleList", articleList);
        modelAndView.setViewName("user/userManager");
        return modelAndView;
    }

    @RequestMapping("/info/{uid}")
    public ModelAndView getUserInfo(@PathVariable("uid") Integer uid) {
        ModelAndView modelAndView = new ModelAndView();
        User user = userService.getUserById(uid);
        modelAndView.addObject("info", user);
        modelAndView.setViewName("user/userInfo");
        return modelAndView;
    }

    @RequestMapping(value = "/headimg/{uid}", method = RequestMethod.POST)
    public String updateHeadImg(HttpServletRequest request, @RequestParam("file") MultipartFile file, @PathVariable("uid") Integer uid) {
        // TODO
        return "redirect:/index.jsp";
    }

    @RequestMapping(value = "/updatePassword/{uid}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> updatePassword(HttpSession session, @PathVariable("uid") Integer uid,@RequestParam("password") String password) {
        Map<String, String> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (!Objects.equals(user.getUid(), uid)) {
            map.put("data", "不能修改他人信息！");
            return map;
        }
        int result = userService.updatePassword(StringUtils.MD5(password), uid);
        if (result > 0) {
            LogUtils.info("成功更新id为{}的用户密码！新密码:{}", uid, password);
            map.put("data", "密码修改成功！");
        } else {
            map.put("data", "密码修改失败！");
        }
        return map;
    }

    @RequestMapping("/exit")
    public String exit(HttpSession session) {
        session.invalidate();
        return "redirect:/index.jsp";
    }

}
