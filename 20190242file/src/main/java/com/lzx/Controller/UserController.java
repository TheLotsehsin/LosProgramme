package com.lzx.Controller;

import com.lzx.Dao.UserMapper;
import com.lzx.Pojo.user;
import com.lzx.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserMapper userMapper;



    @RequestMapping("/toWelcome")
    public String toWelcome(){
        return "welcome";
    }
    @RequestMapping("/toAdmin")
    public String toAdmin(){
        return "admin";
    }
    @RequestMapping(value = "/login")
    public String Login(HttpSession session,Model model, @RequestParam("userName") String uName, @RequestParam("upwd") String pws){
        System.out.println("用户名---"+uName);
        System.out.println("密码---"+pws);
        user user = userMapper.selectUserInforByUname(uName);
        System.out.println(user);
            if (pws.equals(user.getUpwd())) {
                session.setAttribute("userLoginInfor", uName);
                session.setAttribute("uid", user.getUid());
                //model.addAttribute("uid",user.getUid());
                model.addAttribute("userName", uName);
                session.setAttribute("userType",user.getUtype());
                System.out.println(user.getUpwd());
                if (user.getUtype().equals("管理员")) {
                    return "admin";
                }else{
                    return "welcome";
                }
            } else {
               /* model.addAttribute("pws", pws);*/
                return "redirect:/index.jsp";
            }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("userLoginInfor");
        System.out.println("正在退出---");
        return "redirect:/index.jsp";
    }
}
