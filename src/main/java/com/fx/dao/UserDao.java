package com.fx.dao;

import com.fx.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserDao {

    public int addUser(@Param("username") String username, @Param("password") String password, @Param("headimg") String headimg);

    public User findUser(@Param("username")String username,@Param("password")String password);

    public User getUserById(@Param("uid")Integer uid);

    public int updateHeadimg(@Param("headimg") String headimg, @Param("uid") Integer uid);

    public int updatePassword(@Param("password") String password,@Param("uid") Integer uid);
}
