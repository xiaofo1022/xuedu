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
<link href="<c:url value='css/boot/xuedu.css'/>" rel="stylesheet"/>
<script src="<c:url value='js/jquery.min.js'/>"></script>
<script src="<c:url value='js/bootstrap.min.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
</head>
<body>

<div class="container">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<jsp:include page="corecomponent.jsp" flush="true"/>
		</div>
		<div class="col-md-2"></div>
	</div>
</div>

<div class="footer">
	薛人一度 优斯无数 Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> | 浙ICP备15023861号 | ©2015
</div>

<script>
	var baseurl = "<c:url value='/'/>";
</script>
<script src="<c:url value='js/boot/xuedu.js'/>"></script>
</body>
</html>