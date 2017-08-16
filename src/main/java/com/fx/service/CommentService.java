package com.fx.service;

import com.fx.entity.Comment;
import com.fx.entity.Floor;

import java.sql.Timestamp;
import java.util.List;

public interface CommentService {

    public int addComment(String content, Integer aid, Integer uid, Timestamp timestamp);

    public List<Comment> findComment(Integer aid, Integer uid);

    public int getCommentCount(Integer aid);

    public List<Floor> findFloorComment(Integer aid, Integer cid);

    public int addFloorComment(Integer aid,Integer cid, Integer uid, String content);

}
