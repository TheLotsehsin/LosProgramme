<%--
  Created by IntelliJ IDEA.
  User: 22709
  Date: 2021/11/24
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui-v2.6.7/layui/css/layui.css"  media="all">
</head>
<body>

<div class="layui-logo layui-hide-xs layui-bg-black">
    <a href="${pageContext.request.contextPath}/user/toWelcome">
        <span style="color: black">欢迎您，${userName}</span>
    </a>
</div>
<!-- 头部区域（可配合layui 已有的水平导航） -->
<ul class="layui-nav layui-layout-left">
    <!-- 移动端显示 -->
    <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
        <i class="layui-icon layui-icon-spread-left"></i>
    </li>
</ul>
<ul class="layui-nav layui-layout-right">
    <li class="layui-nav-item layui-hide layui-show-md-inline-block">
        <a href="javascript:;">
            <img src="//tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" class="layui-nav-img">
            ${userName}
        </a>
        <dl class="layui-nav-child">
            <dd><a href="">个人信息</a></dd>
            <dd><a href="${pageContext.request.contextPath}/user/logout">登出</a></dd>
        </dl>
    </li>
    <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
        <a href="javascript:;">
            <i class="layui-icon layui-icon-more-vertical"></i>
        </a>
    </li>
</ul>
</div>
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree" lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="javascript:;">选择功能</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/file/toUpload">上传文件</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/file/toDownload">下载文件</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>
</body>
</html>


