package com.fx.dao;

import com.fx.entity.Comment;
import com.fx.entity.Floor;
import org.apache.ibatis.annotations.Param;

import java.sql.Timestamp;
import java.util.List;

public interface CommentDao {

    public int addComment(@Param("content") String content, @Param("aid") Integer aid, @Param("uid") Integer uid, @Param("date") Timestamp timestamp);

    public List<Comment> findComment(@Param("aid") Integer aid, @Param("uid") Integer uid);

    public int getCommentCount(@Param("aid") Integer aid);

    public List<Floor> findFloorComment(@Param("aid") Integer aid, @Param("cid") Integer cid);

    public int addFloorComment(@Param("aid") Integer aid,@Param("cid") Integer cid, @Param("uid") Integer uid, @Param("content") String content);

}
