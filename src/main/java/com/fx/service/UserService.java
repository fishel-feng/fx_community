package com.fx.service;

import com.fx.entity.User;

public interface UserService {

    public int addUser(String username, String password, String headimg);

    public User findUser(String username, String password);

    public User getUserById(Integer uid);

    public int updateHeadimg(String headimg, Integer uid);

    public int updatePassword(String password, Integer uid);
}
