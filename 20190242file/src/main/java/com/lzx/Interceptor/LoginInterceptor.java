package com.lzx.Interceptor;


import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

public class LoginInterceptor implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException, IOException {
        Object user = request.getSession().getAttribute("userLoginInfor");
        System.out.println(user);
        System.out.println("controller执行前");
        // 如果是登陆页面则放行
        System.out.println("uri:" + request.getRequestURI());
        if (request.getRequestURI().endsWith("login")) {
            return true;
        }
        //如果有用户则放行
        else if (user != null){
            return true;
        }
            // 用户没有登陆跳转到登陆页面
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return false;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        System.out.println(httpServletRequest.getSession().getAttribute("userLoginInfor"));
        System.out.println("controller执行后未返回视图执行");
    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        System.out.println("controller执行后");
    }
}
