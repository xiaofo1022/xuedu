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
<script src="<c:url value='js/jquery.min.js'/>"></script>
<script src="<c:url value='js/bootstrap.min.js'/>"></script>
<style>
body {
	text-align:center;
}

.search-block {
	display:inline-block;
	width:95%;
	margin-top:20%;
	margin-bottom:5px;
}

.logo {
	display:block;
	text-align:center;
	font-size:40px;
	color:#E10601;
}

.logo img {
	width:60px;
	margin-top:-60px;
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
	width:95%;
	margin-top:10px;
	margin-bottom:5px;
}
</style>
</head>
<body>

<div class="search-block">
	<div class="logo">
		Xue
		<img src="images/xuedu/MrXue.png"/>
		薛度
	</div>
	<div class="input-group">
		<input id="search-text" type="text" class="form-control" maxlength="100" />
		<span class="input-group-btn">
			<button class="btn btn-primary" type="button" onclick="inputCheck()">薛人一度</button>
		</span>
	</div>
</div>

<ul class="list-group answer-list">
	<button type="button" class="list-group-item" style="color:#337AB7;">最新二十条</button>
	<c:forEach items="${answerList}" var="answer" varStatus="status">
		<c:if test="${status.index < 20}">
			<button type="button" class="list-group-item" style="color:#337AB7;" onclick="getAnswer(${answer.id})">${status.index + 1}. ${answer.title}</button>
		</c:if>
	</c:forEach>
</ul>

<ul class="list-group answer-list">
	<button type="button" class="list-group-item" style="color:#337AB7;">最热二十条</button>
	<c:forEach items="${hotestAnswerList}" var="answer" varStatus="status">
		<c:if test="${status.index < 20}">
			<button type="button" class="list-group-item" style="color:#337AB7;" onclick="getAnswer(${answer.id})">${status.index + 1}. ${answer.title}</button>
		</c:if>
	</c:forEach>
</ul>

<div id="answer-modal" class="modal fade" style="text-align:left;">
	<div class="modal-dialog">
		<div class="modal-content">
	        <div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        	<h4 class="modal-title"></h4>
	      	</div>
	      	<div class="modal-body">
	      	</div>
	      	<div class="modal-footer">
	        	<button id="close-btn" type="button" class="btn btn-default" data-dismiss="modal">我知道啦</button>
	      	</div>
	    </div>
	</div>
</div>

<div class="footer">
	薛人一度 优斯无数 Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> ©2015
</div>

<script>
	var searchMap = {};
	var resultMap = {};
	var resultCount = 0;
	
	+function init() {
		$.get("<c:url value='/answerlist'/>", function(list) {
			if (list) {
				for (var i in list) {
					var data = list[i];
					searchMap[data.title] = data.id;
					resultMap[data.id] = data;
				}
			}
		});
	}();
	
	function inputCheck() {
		var search = $("#search-text").val();
		if (search) {
			var keyValue;
			var searchValue;
			for (var key in searchMap) {
				keyValue = key.toLowerCase();
				searchValue = search.toLowerCase();
				if (keyValue.indexOf(searchValue) >= 0) {
					getAnswer(searchMap[key]);
					return;
				}
			}
			getAnswer(0);
		}
	}
	
	function getAnswer(id) {
		var result = resultMap[id];
		var modal = $("#answer-modal");
		if (result) {
			modal.find(".modal-title").html(result.title);
			modal.find(".modal-body").html(result.answer);
			modal.find("#close-btn").text("我知道啦");
		} else {
			modal.find(".modal-title").html("这个这个");
			modal.find(".modal-body").html("我也不知道啦");
			modal.find("#close-btn").text("那好吧");
		}
		modal.modal("show");
	}
</script>
</body>
</html>