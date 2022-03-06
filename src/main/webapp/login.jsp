<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
        <%
            String path = request.getContextPath()+"/";
            String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
        %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="copyright" content="All Rights Reserved, Copyright (C) 2016   xxx Ltd." />
<title>登录</title>

<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/1.4.5/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/wu.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/icon.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>easyui/1.4.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>easyui/1.4.5/locale/easyui-lang-zh_CN.js"></script>
 <script type="text/javascript">
        document.onkeydown = function (e) {
            var event = e || window.event;
            var code = event.keyCode || event.which || event.charCode;
            if (code == 13) {
                login();
            }
        }
        $(function () {
            $("input[name='login']").focus();
            refreshCode();
        });
        function cleardata() {
            $('#loginForm').form('clear');
        }
        function refreshCode() {
            $("#imgCaptcha").attr("src","<%=basePath%>images/captcha.jpg?t="+Math.random());
        }
        function login() {
            if ($("input[name='login']").val() == "" || $("input[name='password']").val() == "") {
                $("#showMsg").html("用户名或密码为空，请输入");
                $("input[name='login']").focus();
            } else {
                if($("input[name='captcha']").val() == ""){
                    $("#showMsg").html("请输入验证码!");
                    $("input[name='captcha']").focus();
                    return ;
                }
                //ajax异步提交
                $.ajax({
                    type: "POST",   //post提交方式默认是get
                    url: "doLogin",
                    data: $("#loginForm").serialize(),   //序列化
                    error: function (request) {      // 设置表单提交出错
                        $("#showMsg").html(request);  //登录错误提示信息
                    },
                    success: function (data) {
                    	if(data=="success"){
                            try{
                                window.parent.location.href="index.html";
                            }catch(ex){
                                document.location = "index.html";
                            }
                    	}
                    	else{
                    		 $("#showMsg").html(data);
                             refreshCode();
                    	}
                    }
                });
            }
        }
    </script>
</head>
<body  >
	  <div id="loginWin" class="easyui-window" title="登录" style="width:350px;height:300px;padding:5px;"
         minimizable="false" maximizable="false" resizable="false" collapsible="false" closable="false">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding:5px;background:#fff;border:1px solid #ccc;">
                <form id="loginForm" method="post">
                    <div style="padding:5px 0;">
                        <label for="login">帐号:</label>
                        <input type="text" name="login" style="width:260px;" />
                    </div>
                    <div style="padding:5px 0;">
                        <label for="password">密码:</label>
                        <input type="password" name="password" style="width:260px;" />
                    </div>
                    <div style="padding:5px 0;">
                        <label for="captcha">验证码:</label>
                        <input type="text" name="captcha" style="width:260px;"  autocomplete="off"/>
                    </div>
                    <div style="padding:5px 0;">
                        <img id="imgCaptcha"  /> <a class="easyui-linkbutton" iconcls="icon-refresh" href="javascript:void(0)" onclick="refreshCode()">刷新</a>
                    </div>
                    <div style="padding:5px 0;text-align: center;color: red;" id="showMsg"></div>
                </form>
            </div>
            <div region="south" border="false" style="text-align:right;padding:5px 0;">
                <a class="easyui-linkbutton" iconcls="icon-ok" href="javascript:void(0)" onclick="login()">登录</a>
            </div>
        </div>
    </div>
</body>
</html>
