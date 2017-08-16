package com.fx.controller;

import com.fx.service.CommentService;
import com.fx.util.LogUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> addComment(@RequestParam(value = "content", required = false) String content, @RequestParam(value = "aid") Integer aid, @RequestParam(value = "uid") Integer uid) {
        Map<String, String> map = new HashMap<>();
        int result = commentService.addComment(content, aid, uid, new Timestamp(new Date().getTime()));
        if (result > 0) {
            LogUtils.info("回复成功！内容为:" + content);
            map.put("data", "回复成功！");
        } else {
            LogUtils.info("回复失败！");
            map.put("data", "回复失败！");
        }
        return map;
    }
}
