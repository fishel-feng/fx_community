package com.fx.service.impl;

import com.fx.dao.UserDao;
import com.fx.entity.User;
import com.fx.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public int addUser(String username, String password, String headimg) {
        return userDao.addUser(username, password, headimg);
    }

    @Override
    public User findUser(String username, String password) {
        return userDao.findUser(username, password);
    }

    @Override
    public User getUserById(Integer uid) {
        return userDao.getUserById(uid);
    }

    @Override
    public int updateHeadimg(String headimg, Integer uid) {
        return userDao.updateHeadimg(headimg, uid);
    }

    @Override
    public int updatePassword(String password, Integer uid) {
        return userDao.updatePassword(password, uid);
    }
}
