package com.lzx.Pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class user {
    private Integer uid;
    private String uname;
    private String upwd;
    private String sex;
    private String utype;
}
