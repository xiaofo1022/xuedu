<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="utf-8">
<title>薛 度</title>
<meta charset="utf-8">
<meta name="keywords" content="优斯迪吧、薛度、薛 度、薛优雅、薛东辉、李羽、李斯文、彪马苏、苏德彪"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" />
<link href="<c:url value='css/bootstrap.css'/>" rel="stylesheet"/>
<script src="<c:url value='js/jquery.min.js'/>"></script>
<script src="<c:url value='js/bootstrap.min.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
<style>
body {
	text-align:center;
}

.clearfix:after {
	content:"";
	clear:both;
}

.nooutline {
	outline:none;
}

.search-block {
	display:inline-block;
	width:95%;
	margin-top:40px;
	margin-bottom:5px;
}

.logo {
	display:block;
	text-align:center;
	font-size:30px;
	color:#E10601;
}

.logo img {
	width:40px;
	margin-top:-30px;
}

.footer {
	text-align:center;
	color:#A9A9A9;
	font-size:12px;
	margin-bottom:5px;
}

.footer a {
	display:inline-block;
}

.answer-list {
	display:inline-block;
	width:100%;
	margin:-1px;
}

.contribute-block {
	margin-top:5px;
}

.contribute-block button {
	width:95%;
}

.answer-panel {
	display:inline-block;
	width:95%;
	margin-top:10px;
	padding:0;
}

.supple-block {
	border-top:1px solid #E5E5E5;
	margin-top:10px;
	padding-top:10px;
}
</style>
</head>
<body>

<jsp:include page="corecomponent.jsp" flush="true"/>

<div class="footer">
	Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> | 浙ICP备15023861号 | ©2015
</div>

<script>
	var baseurl = "<c:url value='/'/>";
</script>
<script src="<c:url value='js/boot/xuedu.js'/>"></script>
</body>
</html>