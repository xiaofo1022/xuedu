<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>薛 度 之 登 录</title>
<link rel="icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" />
<link href="<c:url value='css/login.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="login-block">
	<input id="username" placeholder="用户名" type="text" maxlength="100"/>
	<input id="password" placeholder="密码" type="password" maxlength="100"/>
	<div class="login-btn" onclick="login()">登 录</div>
</div>
<script src="<c:url value='js/jquery.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
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