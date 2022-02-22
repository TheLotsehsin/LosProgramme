<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 22709
  Date: 2021/11/24
  Time: 23:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui-v2.6.7/layui/css/layui.css"  media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/myCss/my.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/statics/myCss/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/statics/myCss/personal.css" media="all">
    <script src="${pageContext.request.contextPath}/statics/VUE/jquery-3.2.1.min.js"></script>
</head>
<body>
    <form id="mm" class="layui-form" action="" method="post">
        <div class="layui-input-block">
            <input type="hidden" name="fileId" id="fileId">
            <button type="button" class="layui-btn" id="btn">立刻下载</button>
            <button type="button" class="layui-btn1" id="btn-tt">评论</button>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">编辑评论</label>
            <div class="layui-input-block">
                <textarea name="desc" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
    </form>
    <div class="layui-card">
        <div class="comment_list">
            <h2 >全部评论</h2>
            <hr>
            <div class="comment">
                <div class="imgdiv"><img class="imgcss"  src="${pageContext.request.contextPath}/statics/png/1.jfif"/></div>
                <div class="conmment_details">
                    <span class="comment_name">li </span>     <span>22分钟前</span>
                    <div class="comment_content" >可以</div>
                    <div class="del"> <i class="icon layui-icon"  >赞(11)</i>
                        <a class="del_comment" data-id="1"> <i class="icon layui-icon" >删除</i></a>
                    </div>
                </div>
                <hr>
            </div>

        </div>
        <div class="comment_add_or_last" >
            没有更多评论了
        </div>
        <div class="layui-card-body">
        </div>
    </div>
<script src="${pageContext.request.contextPath}/statics/VUE/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/statics/layui-v2.6.7/layui/layui.js" charset="utf-8"></script>
<script>

    /*$(".layui-btn").click(function () {
        var fileId = $("#fileId").val()
        console.log("file===="+fileId)
        $.ajax({
            url: '${pageContext.request.contextPath}/file/download?fid='+fileId,
            success: function (data) {
                layer.msg("提交成功")
            }
        });
    })*/
    var can = false;

    $(document).on('click', '.layui-btn1', function() {
        add();
    });

    $(document).on('click', '.layui-btn1', function() {
        add();
    });

    function  delComment(id) {
        alert(id);
    }
    function  add() {
        var comment=$(".layui-textarea").val();

        can = true;
        var s = " ";
        s += '<div class="comment">';
        s += '<div class="imgdiv"><img class="imgcss"  src="${pageContext.request.contextPath}/statics/png/1.jfif"/></div>';
        s += '<div class="conmment_details">';
        s +=  '<span class="comment_name">li </span>     <span>1分钟前</span>';
        s += 	'<div class="comment_content" >'+$(".layui-textarea").val()+ '</div>';
        s += 	'<div class="del"> <i class="icon layui-icon"  >赞(12)</i>';
        s += 	'<a class="del_comment"  data-id="1"><i class="icon layui-icon" >删除</i></a></div></div><hr></div>';


        $('.comment_list').append(s);
    }
    layui.use(["layer"],function () {

        var layer = layui.layer;
        $(".layui-btn").click(function () {
            if(can === false){
                alert("请先评论！！!")
            }else{
            var fileId = $("#fileId").val();
            var comm = $("#comm").val();
            console.log(comm)
            var url = '${pageContext.request.contextPath}/file/download?fid='+fileId;
            // 封装form表单
            var form = $("<form></form>").attr("action", url).attr("method", "post");
            form.append($("<input></input>").attr("type", "hidden").attr("name", "myComm").attr("value",comm));
            form.appendTo('body').submit().remove();
            }
        })

    })

</script>
</body>
</html>
