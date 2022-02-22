<%--
  Created by IntelliJ IDEA.
  User: 22709
  Date: 2021/11/23
  Time: 0:21
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文件配置管理</title>
    <link rel="stylesheet" href="/component/pear/css/pear.css"/>
</head>
<body class="pear-container">
<form class="layui-form" action="" id="popSearchRoleTest" style="display:none;" autocomplete="off">
    <div class="mainBox">
        <div class="main-container">
            <div class="main-container">
                <div class="layui-form-item" id="div-branchCode">
                    <label class="layui-form-label">渠道：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="d-branchCode" name="branchCode" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item" id="div-fileType">
                    <label class="layui-form-label">任务类型：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="d-type" name="type" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">工作日：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="d-workDate" name="workDate" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-form-item layui-inline">
                        <button class="pear-btn pear-btn-md pear-btn-primary" lay-submit lay-filter="downloadFileSend">
                            <i class="layui-icon layui-icon-search"></i>
                            下载
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

<div class="layui-card">
    <div class="layui-card-body">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <div class="layui-form-item layui-inline">
                    <label class="layui-form-label">渠道</label>
                    <div class="layui-input-inline">
                        <select name="branchCode" lay-verify="required" id="q-branchCode">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item layui-inline">
                    <button class="pear-btn pear-btn-md pear-btn-primary" lay-submit lay-filter="user-query">
                        <i class="layui-icon layui-icon-search"></i>
                        查询
                    </button>
                </div>
            </div>
        </form>


    </div>
</div>
<div class="layui-card">
    <div class="layui-card-body">
        <table id="user-table" lay-filter="user-table"></table>
    </div>
</div>

<script type="text/html" id="fileConfig-bar">
    {{#  if(d.actionMode == "0"){ }}
    <button class="pear-btn pear-btn-danger pear-btn-sm" lay-event="downloadFile">下载</button>
    {{# } }}


</script>

<!--模板-->
<script type="text/html" id="user-sex">
    {{#if (d.sex == 1) { }}
    <span>男</span>
    {{# }else if(d.sex == 2){ }}
    <span>女</span>
    {{# } }}
</script>

<script src="/component/layui/layui.js"></script>
<script src="/component/pear/pear.js"></script>
<script>
    layui.use(['table', 'form', 'jquery', 'common', 'laydate'], function () {
        let laydate = layui.laydate;
        let table = layui.table;
        let form = layui.form;
        let $ = layui.jquery;
        let common = layui.common;

        let MODULE_PATH = "fileConfig/";

        let cols = [
            [{
                type: 'checkbox'
            },
                {
                    title: 'ID',
                    field: 'id',
                    align: 'center'
                },
                {
                    title: '渠道',
                    field: 'branchCodeDesc',
                    align: 'center'
                },
                {
                    title: '文件名称',
                    field: 'descName',
                    align: 'center'
                },
                {
                    title: '操作',
                    toolbar: '#fileConfig-bar',
                    align: 'center'
                }
            ]
        ];

        table.render({
            elem: '#user-table',
            url: '/xxx/list.htm',
            parseData: function (res) {//res 即为原始返回的数据
                res = $.parseJSON(res);
                if (res.code != '000000') {
                    res.code = 0;
                    res['data'] = [];
                }
                return res;
            },
            cols: cols,
            skin: 'line',
            defaultToolbar: []
        });

        laydate.render({
            elem: '#d-workDate' //指定元素
            ,format: 'yyyyMMdd' //日期格式
            ,btns: ['clear', 'confirm']
        });

        //下载
        table.on('tool(user-table)', function (obj) {
            if (obj.event === 'downloadFile') {
                window.downloadFile(obj);
            }
        });

        form.on('submit(user-query)', function (data) {
            table.reload('user-table', {
                url: '/xxx/list.htm',
                where: data.field
            });
            return false;
        });

        form.on('submit(downloadFileSend)', function(data){

            var branchCode = $('#d-branchCode').val();
            var workDate = $('#d-workDate').val();
            var type = $('#d-type').val();

            // window.location.href = "/xxx/downloadFile.htm?branchCode=" + branchCode + "&workDate=" + workDate + "&type=" + type;
            var downloadURL = "/xxx/downloadFile.htm?branchCode=" + branchCode + "&workDate=" + workDate + "&type=" + type;
            // window.open(downloadURL);
            // return false;


            // window.open(downloadURL, '_blank', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=400,height=600');
            window.open(downloadURL, '_parent');

            //表单清空
            $("#popSearchRoleTest")[0].reset();
            //更新表单
            layui.form.render();
            //关闭弹窗
            layer.close(layer.index);
            return false;
        });

        window.downloadFile = function (obj) {
            layer.open({
                //layer提供了5种层类型。可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                type: 1,
                title: "文件下载提示",
                area: ['60%', '60%'],
                content: $("#popSearchRoleTest"),
                cancel: function(){
                    // 右上角关闭事件的逻辑
                    $("#popSearchRoleTest")[0].reset();
                    layui.form.render();
                    table.reload('user-table');
                }
            });
            //隐藏渠道
            $("#div-branchCode").hide();
            $("#div-fileType").hide();
            $('#d-branchCode').val(obj.data.branchCode);
            $('#d-type').val(obj.data.type);
        };

        $.ajax({
            url: '/genenumbyclass.htm',
            dataType: 'json',
            data: {
                'className': 'com.qiangungun.core.enums.BranchCode'
            }, //查询状态为正常的所有机构类型
            type: 'post',
            success: function (data) {
                var dataArr = JSON.parse(data);
                $.each(dataArr, function (index, item) {
                    $('#q-branchCode').append(
                        new Option(item.text, item.code));// 下拉菜单里添加元素
                });
                layui.form.render("select");
            }
        });
    });
</script>
</body>
</html>
