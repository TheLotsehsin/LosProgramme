package com.lzx.Dao;

import com.lzx.Pojo.user;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {

    @Select("select * from user where u_name =#{uname}")
    user selectUserInforByUname(String uname);
}
