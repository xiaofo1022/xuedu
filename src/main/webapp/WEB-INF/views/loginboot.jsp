<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="utf-8">
<title>薛 度</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" />
<link href="<c:url value='css/bootstrap.css'/>" rel="stylesheet"/>
<link href="<c:url value='css/boot/xuedu.css'/>" rel="stylesheet"/>
<script src="<c:url value='js/jquery.min.js'/>"></script>
<script src="<c:url value='js/bootstrap.min.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
<style>
	.login-block {
		margin:100px 0 20px 0;
	}
</style>
</head>
<body>

<div class="container">
	<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4 login-block">
		<div class="panel panel-default">
			<div class="panel-heading">
		    	<h3 class="panel-title">后台登录</h3>
		  	</div>
		  	<div class="panel-body" style="padding:10px;">
		    	<div class="form-group">
				    <input id="username" type="text" class="form-control" placeholder="账号">
				</div>
				<div class="form-group">
				    <input id="password" type="password" class="form-control" placeholder="密码">
				</div>
				<button class="btn btn-default" style="width:100%;" onclick="login()">登录</button>
		  	</div>
		</div>
	</div>
	<div class="col-md-4"></div>
	</div>
</div>

<div class="footer">
	薛人一度 优斯无数 Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> | 浙ICP备15023861号 | ©2015
</div>

<script>
	function login() {
		var username = $("#username").val();
		var password = $("#password").val();
		if (username && password) {
			AjaxUtil.post("<c:url value='/dologin'/>", {username:username, password:password}, function(data) {
				if (data == "success") {
					location.assign("<c:url value='/background'/>");
				} else {
					alert("用户名或密码错误");
				}
			});
		}
	}
</script>
</body>
</html>