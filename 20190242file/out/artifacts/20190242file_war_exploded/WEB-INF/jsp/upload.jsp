<%--
  Created by IntelliJ IDEA.
  User: 22709
  Date: 2021/11/22
  Time: 22:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文件上传</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui-v2.6.7/layui/css/layui.css"  media="all">

    <script src="${pageContext.request.contextPath}/statics/VUE/jquery-3.2.1.min.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">
            <a href="${pageContext.request.contextPath}/user/toWelcome">
                <span style="color: black">欢迎您，<%=session.getAttribute("userLoginInfor")%></span>
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
                    <%=session.getAttribute("userLoginInfor")%>
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
                    </dl>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">
        <%--   <div>
               <form action="${pageContext.request.contextPath}/file/upload" enctype="multipart/form-data" method="post">
                   <input type="hidden" name="uid" value="${uid}">
                   <input type="file" name="file"/>
                   <button  class="layui-upload-button" lay-submit>提交</button>
               </form>
           </div>
           <table class="layui-table" id="fileTable"></table>
       </div>--%>
            <div class="layui-upload" style="padding-top:100px">
                <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
                <div class="layui-upload-list" style="max-width: 1000px;">
                    <table class="layui-table">
                        <colgroup>
                            <col>
                            <col width="150">
                            <col width="260">
                            <col width="150">
                        </colgroup>
                        <thead>
                        <tr><th>文件名</th>
                            <th>大小</th>
                            <th>上传进度</th>
                            <th>操作</th>
                        </tr></thead>
                        <tbody id="demoList"></tbody>
                    </table>
                </div>
                <button type="button" class="layui-btn" id="testListAction">开始上传</button>
            </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/statics/layui-v2.6.7/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['upload','element'],function () {

        var upload = layui.upload,
        element = layui.element;
        var uploadListIns = upload.render({
            elem: '#testList'
            ,elemList: $('#demoList') //列表元素对象
            ,url: '${pageContext.request.contextPath}/file/upload' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            ,accept: 'file'
            ,multiple: true

            ,number: 3
            ,auto: false
            ,bindAction: '#testListAction'
            ,choose: function(obj){
                var that = this;
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result){
                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ file.name +'</td>'
                        ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                        ,'<td><div class="layui-progress" lay-filter="progress-demo-'+ index +'"><div class="layui-progress-bar" lay-percent=""></div></div></td>'
                        ,'<td>'
                       // ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                        ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                        ,'</td>'
                        ,'</tr>'].join(''));

                    //单个重传
                   /* tr.find('.demo-reload').on('click', function(){
                        obj.upload(index, file);
                    });*/

                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        delete files[index]; //删除对应的文件
                        tr.remove();
                        uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                    });

                    that.elemList.append(tr);
                    element.render('progress'); //渲染新加的进度条组件
                });
            }
            ,done: function(res, index, upload){ //成功的回调
                var that = this;
                //if(res.code == 0){ //上传成功
                var tr = that.elemList.find('tr#upload-'+ index)
                    ,tds = tr.children();
                tds.eq(3).html(''); //清空操作
                delete this.files[index]; //删除文件队列已经上传成功的文件
                return;
                //}
                this.error(index, upload);
            }
            ,allDone: function(obj){ //多文件上传完毕后的状态回调
                console.log(obj)
            }
            ,error: function(index, upload){ //错误回调
                var that = this;
                var tr = that.elemList.find('tr#upload-'+ index)
                    ,tds = tr.children();
                tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
            }
            ,progress: function(n, elem, e, index){ //注意：index 参数为 layui 2.6.6 新增
                element.progress('progress-demo-'+ index, n + '%'); //执行进度条。n 即为返回的进度百分比
            }
        });
    })

</script>

</body>
</html>
