<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>薛 度</title>
<link rel="icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" />
<link href="<c:url value='css/xuedu.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="main active">
	<div class="side-block-up">
		<div class="logo">
			Xue
			<img src="images/xuedu/MrXue.png"/>
			薛度
		</div>
	</div>
	<div class="side-block-down">
		<div class="search-block">
			<a>
				<input id="search-text" type="text" maxlength="100"/>
				<span class="top"></span>
				<span class="left"></span>
				<span class="bottom"></span>
			</a>
			<a class="search-btn" onclick="requestQuestion()">薛人一度</a>
			<div id="search-dropdown" class="search-dropdown">
			</div>
		</div>
	</div>
</div>

<div class="result inactive">
	<div class="speaker">
		<div class="header">
			<img src="images/xuedu/MrXue.png"/>
		</div>
	</div>
	<div class="answer">
		<div class="dialog">
			<div id="answer" class="ans-block hidden">
				<h1 id="answer-title"></h1>
				<p>
					答：
				</p>
				<p id="answer-info">
				</p>
			</div>
			<div class="back-btn" onclick="showMain()">
				&lt; 知道了吧？
			</div>
		</div>
	</div>
</div>

<div class="footer">
	薛人一度 优思无数 Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> ©2015
</div>

<script src="<c:url value='js/jquery.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
<script src="<c:url value='js/xuedu.js'/>"></script>
<script>
	var searchMap = {};
	var resultMap = {};
	var resultCount = 0;
	
	$("#search-text").keypress(function(e) {
		if (e.keyCode == "13") {
			requestQuestion();
        }
	});
	
	$("#search-text").attr("autocomplete", "off"); 
	$("#search-text").bind("propertychange input", function(event) {
		var search = $("#search-text").val();
		inputCheck(search);
	});
	
	function inputCheck(search) {
		$("#search-dropdown").html("");
		resultCount = 0;
		if (search) {
			for (var key in searchMap) {
				if (key.indexOf(search) >= 0) {
					$("#search-dropdown").append("<p onclick='showDu(" + searchMap[key] + ")'>" + key + "</p>");
					resultCount++;
					if (resultCount > 5) {
						break;
					}
				}
			}
		}
	}
	
	function showDu(id) {
		var result = resultMap[id];
		if (result) {
			$("#search-text").val(result.title);
			$("#answer-title").html(result.title);
			$("#answer-info").html(result.answer.replace(/\n/g, "<br/>"));
		}
		showResult();
	}
	
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
	
	function requestQuestion() {
		var question = $("#search-text").val();
		if (question) {
			var searchid = searchMap[question];
			if (searchid) {
				showDu(searchid);
			} else {
				$("#answer-title").html(question);
				$("#answer-info").html("你这都什么问题啊，胡闹胡闹！");
				showResult();
				AjaxUtil.post("<c:url value='/question'/>", {question:question}, function(data) {});
			}
		}
	}
</script>
</body>
</html>