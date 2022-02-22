package com.lzx.Service;

import com.lzx.Dao.UserMapper;
import com.lzx.Pojo.user;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl {
    @Autowired
    private UserMapper userMapper;

    public user selectUserInforByUname(String uname){
        return userMapper.selectUserInforByUname(uname);
    }
}
