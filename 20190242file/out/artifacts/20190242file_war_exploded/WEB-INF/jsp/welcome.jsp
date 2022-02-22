<%--
  Created by IntelliJ IDEA.
  User: 22709
  Date: 2021/11/18
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>主页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui-v2.6.7/layui/css/layui.css"  media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/myCss/my.css">
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
                <ul class="layui-nav layui-nav-tree" lay-filter="">
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
            <div style="padding-top: 80px;padding-right: 200px">
                <table class="layui-hide" id="test" lay-filter="test"></table>

                <form class="layui-form" action="" method="post">
                    <div class="layui-form-item">
                        <label class="layui-form-label">文件类型</label>
                        <div class="layui-input-block">
                            <select lay-verify="required" id="filetype" name="tname" lay-search="">
                                <option></option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button  class="layui-btn">立即提交</button>
                        </div>
                    </div>
                </form>
                <script type="text/html" id="toolbarDemo">
                    <div class="layui-btn-container">
                        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
                        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
                        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
                    </div>
                </script>

                <script type="text/html" id="barDemo">
                    <a class="layui-btn layui-btn-warm" lay-event="download">查看文件</a>
                </script>
            </div>
    </div>

<script src="${pageContext.request.contextPath}/statics/layui-v2.6.7/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['table','layer','form'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var  form = layui.form;

        $.ajax({
            url:'${pageContext.request.contextPath}/file/selAllType',
            type:'get',
            dataType:'json',
            success:function(res){
                var list = res.tname;    //返回的数据
                var filetype = document.getElementById("filetype"); //server为select定义的id
                for(var p in list){
                    var option = document.createElement("option");  // 创建添加option属性
                    option.innerText=list[p];     // 打印option对应的纯文本
                    option.value=list[p];
                    filetype.appendChild(option);           //给select添加option子标签
                    form.render("select");            // 刷性select，显示出数据
                }
            }
        })

        table.render({
            id:'tableReload'
            ,elem: '#test'
            ,url:'${pageContext.request.contextPath}/file/selAllFiles'/*tpa=https://www.layuiweb.com/test/table/demo1.json*/
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '文件下载表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'fid', title:'文件编号', width:200, fixed: 'left', unresize: true, sort: true}
                ,{field:'fname', title:'文件名', width:120, edit: 'text'}
                ,{field:'uid', title:'上传用户', width:150, edit: 'text'}
                ,{field:'fsize', title:'文件大小', width:150, edit: 'text', sort: true}
                ,{field:'tname', title:'文件类型',width:250, edit:'text'}
                ,{field:'fnum', title:'下载次数', width:120, sort: true}
                ,{field:'fdate', title:'上传时间', width:200}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            ,page: true
        });

        $(".layui-btn").click(function () {
            var tname = $("#filetype").val();
            console.log(tname);
            table.reload('tableReload', {
                url:'${pageContext.request.contextPath}/file/selAllFiles',
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {//这里传参  向后台
                    tname: tname
                }
            })
            return false;
        })

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('您可以在评论后下载文件');
                    break;
                 };
            });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            console.log(data.fid)
            console.log(obj)
            if(obj.event === 'download'){
                layer.open({
                    type: 2,
                    title: '文件内容',
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['893px', '600px'],
                    content: '${pageContext.request.contextPath}/oneFile.jsp',
                    success: function(layero, index){
                        var body=layer.getChildFrame('body',index);
                        console.log(body.html())
                        var fileId = body.find("#fileId");
                        fileId.val(data.fid);
                    }
                });
            }
        });
    })
</script>
</body>
</html>