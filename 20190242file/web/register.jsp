<%@ page contentType="text/html;charset=UTF-8"%> <%--设置文档类型  防止页面中文乱码--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>         <%--引入jstl核心标签库--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   <%--引入jstl函数标签库--%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>注册页面</title>
	<meta name="keywords" content="z网">
	<meta name="content" content="z网">
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/dreamland.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
</head>

<body class="login_bj" style="background-color: grey">

<div class="zhuce_body" >
    <div class="zhuce_kong" id="dre_div">
    	<div class="zc">
        	<div class="bj_bai" style="height: 408px">
            <h3>欢迎注册</h3>
       	  	  <form action="${pageContext.request.contextPath}/doRegister" method="post">
                  <span id="reg_span"></span>
                <input id="email" name="email" type="text" class="kuang_txt email" onblur="checkEmail();"placeholder="邮箱"><span id="email_ok"></span>
                  <br/>
                  <span id="email_span" style="color: red"></span>
                <input id="password" name="password" type="password" class="kuang_txt password" placeholder="密码" onKeyUp="CheckIntensity(this.value)" onblur="checkPassword();">
                  <br/>
                  <span id="password_span"></span>
                <input id="name" name="name" type="text" class="kuang_txt name" placeholder="昵称" onblur="checkNickName();">
                  <br/>
                  <span id="name_span" style="color: red"></span>
                  <br>
                  <br>
                  <input type="submit"  id ="to_register" class="btn_zhuce" value="注册">
                  <br/>
                  <br>
                  <br/>
                  <span style="color: red">${error}</span>
                </form>
                    <p>已有账号？<a href="index.jsp">立即登录</a></p>
            </div>
        </div>
    </div>
</div>
    
<div style="text-align:center;">
</div>
</body>

<script type="text/javascript">
    //校验密码强弱
    var flag = false;
    var i = 0;
    var c = 0;
    function CheckIntensity(pwd) {
        var val = $("#password_span").text();
        if(c==0 && (val==null || val =="")){
            increaseHeight();
            c++;
        }
        //去两边空格
        if(pwd!=null) {
            pwd = pwd.replace(/^\s+|\s+$/g, "");
        }
        var len = 0;
        if(pwd != "" && pwd!=null){
            len = pwd.length;
        }
        if( len < 6){
            $("#password_span").text("密码长度少于6位，请重新输入！").css("color","red");
        }else {
            if(/^[0-9]*$/.test(pwd) || /^[A-Za-z]+$/.test(pwd)){

                $("#password_span").text("密码强度弱！").css("color","red");
            }else if(/^[A-Za-z0-9]+$ /.test(pwd) || pwd.length <= 10){

                $("#password_span").text("密码强度中！").css("color","#FF6100");
            }else{

                $("#password_span").text("密码强度强！").css("color","green");

            }
            flag = true;


        }
        return flag;
    }

    //密码框离焦事件
    var cp = 0;
    function checkPassword() {
        var password = $("#password").val();
        password = password.replace(/^\s+|\s+$/g,"");
        if(password == ""){
            $("#password_span").text("请输入密码！").css("color","red");
            if(cp==0){
                increaseHeight();
                cp++;
            }
            return false;
        }
        if(password.length < 6){
            $("#password_span").text("密码长度少于6位，请重新输入！").css("color","red");
            if(cp==0){
                cp++;
                increaseHeight();
            }
            return false;
        }


        if(flag){
            $("#password_span").text("");
            $("#reg_span").text("");

            if(cp==1){
                reduceHeight();
                cp=0;
            }
            return true;
        }
    }

    function increaseHeight() {

        var hgt = $("#regist-left").height();
        $("#regist-left").height(hgt+30);
        $("#regist-right").height(hgt+30);

    }
    //根据内容减少而减少高度
    function reduceHeight() {
        var hgt = $("#regist-left").height();
        $("#regist-left").height(hgt-30);
        $("#regist-right").height(hgt-30);
    }

    //昵称校验
    function checkNickName() {
        var nickName = $("#nickName").val();
        nickName = nickName.replace(/^\s+|\s+$/g,"");
        if(nickName == ""){
            $("#nickName_span").text("请输入昵称！");
            return false;
        }else{
            $("#nickName_span").text("");
            $("#reg_span").text("");
            return true;
        }
    };


    var e = 0;
    var flag_e =false;
    function checkEmail() {
        var email = $("#email").val();
        email = email.replace(/^\s+|\s+$/g,"");
        if(email == "" || email==null){
            if(e==0){
                increaseHeight();
                e++;
            }
            $("#email_span").text("请输入邮箱账号！");
            $("#email_ok").text("");
            flag_e = false;
        }
        if(!(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+$/.test(email))){
            $("#email_span").text("邮箱账号不存在，请重新输入！");
            $("#email_ok").text("");
            if(e==0){
                increaseHeight();
                e++;
            }
            flag_e = false;
        }else{
            //验证邮箱是否已经注册
            $.ajax({
                type:'post',
                url:'/checkEmail',
                data: {"email":email},
                dataType:'json',
                success:function(data) {
                    var val = data['message'];
                    if(val=="success"){
                        $("#email_span").text("");
                        $("#reg_span").text("");
                        $("#email_ok").text("√").css("color","green");

                        var content = $("#email_ok").text();
                        if(content=="√" ){
                            var hgt = $("#regist-left").height();
                            if(v==1){
                                $("#regist-left").height(hgt-30);
                                $("#regist-right").height(hgt-30);
                            }
                            v=0;
                        }
                        flag_e = true;

                    }else{

                        $("#email_span").text("该Email已经注册！");
                        $("#email_ok").text("");
                        var hgt = $("#regist-left").height();
                        if(v==0){
                            $("#regist-left").height(hgt+30);
                            $("#regist-right").height(hgt+30);
                            v++;
                        }
                        flag_e =  false;
                    }
                }
            });

        }
        return flag_e;
    }

</script>
</html>