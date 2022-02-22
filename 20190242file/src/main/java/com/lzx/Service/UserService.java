package com.lzx.Service;

import com.lzx.Pojo.user;
import org.springframework.stereotype.Service;

public interface UserService {

    public user selectUserInforByUname(String uname);
}
