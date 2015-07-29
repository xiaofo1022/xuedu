<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>薛 度 之 后 台</title>
<link rel="icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" /> 
<link rel="shortcut icon" href="<c:url value='images/favicon.ico'/>" type="image/x-icon" />
<style>
@font-face {
	font-family:"bige-young-2";
	src:url(fonts/bige-young-2.ttf);
}

html, body {
	margin:0;
	padding:0;
	width:100%;
	height:100%;
	font-family:"bige-young-2";
	text-align:center;
}

.container {
	display:inline-block;
}

.clearfix:after {
	content:"";
	clear:both;
}

.block {
	width:430px;
	height:490px;
	border:1px solid #000;
	text-align:center;
	box-sizing:border-box;
	float:left;
	margin:10px;
}

.block input {
	outline:none;
	width:400px;
	height:30px;
	margin:10px;
	margin-bottom:0;
	border:1px solid #000;
	font-family:"bige-young-2";
	font-size:22px;
}

.block textarea {
	outline:none;
	width:400px;
	height:380px;
	margin:10px;
	margin-bottom:0;
	border:1px solid #000;
	font-family:"bige-young-2";
	font-size:16px;
	resize:none;
	box-sizing:border-box;
}

.btn {
	display:inline-block;
	width:185px;
	height:35px;
	margin:10px;
	border:1px solid #000;
	text-align:center;
	padding:5px;
	font-size:22px;
	box-sizing:border-box;
	transition:background-color .5s, color .5s;
}

.btn:hover {
	cursor:pointer;
	background-color:#000;
	color:#fff;
}

.question-block {
	display:inline-block;
	width:400px;
	height:420px;
	border:1px solid #000;
	box-sizing:border-box;
	overflow:auto;
}

.question-row {
	height:40px;
	border-bottom:1px solid #000;
	width:100%;
	text-align:left;
	padding:10px;
	box-sizing:border-box;
}

.question-row .info {
	float:left;
}

.question-row .btn-control {
	float:right;
	padding-left:10px;
	padding-right:10px;
	border-left:1px solid #000;
	transition:background-color .5s, color .5s;
}

.question-row .btn-control:hover {
	cursor:pointer;
	background-color:#000;
	color:#fff;
}

.btn-active {
	background-color:#000;
	color:#fff;
}

.active {
	display:inline-block;
}

.inactive {
	display:none;
}
</style>
</head>
<body>
<div class="container clearfix">
	<div class="block">
		<div id="btn-my" class="btn btn-active" onclick="showMy()">我的问答</div>
		<div id="btn-listener" class="btn" onclick="showListener()">听众的搜索</div>
		
		<div id="question-my" class="question-block active">
			<c:forEach items="${answerList}" var="answer">
				<div class="question-row clearfix">
					<div class="info">${answer.title}</div>
					<div class="btn-control" onclick="deleteAnswer(${answer.id})">删除</div>
					<div class="btn-control" onclick="getAnswer(${answer.id})">更新</div>
				</div>
			</c:forEach>
		</div>
		
		<div id="question-listener" class="question-block inactive">
			<c:forEach items="${questionList}" var="question">
				<div class="question-row clearfix">
					<div class="info">${question.question}</div>
					<div class="btn-control" onclick="ignoreQuestion(${question.id})">忽略</div>
					<div class="btn-control" onclick="giveAnAnswer(${question.id}, '${question.question}')">解答</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<div class="block">
		<input id="title" placeholder="问：" type="text" maxlength="100"/>
		<textarea id="answer" placeholder="答：" maxlength="1000"></textarea>
		<div class="btn" onclick="addAnswer()">提交</div>
	</div>
	
	<input id="answer-id" type="hidden"/>
	<input id="question-id" type="hidden"/>
</div>

<script src="<c:url value='js/jquery.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
<script>
	function showListener() {
		$("#btn-my").removeClass("btn-active");
		$("#btn-listener").addClass("btn-active");
		
		$("#question-my").removeClass("active");
		$("#question-my").addClass("inactive");
		$("#question-listener").removeClass("inactive");
		$("#question-listener").addClass("active");
	}
	
	function showMy() {
		$("#btn-my").addClass("btn-active");
		$("#btn-listener").removeClass("btn-active");
		
		$("#question-listener").removeClass("active");
		$("#question-listener").addClass("inactive");
		$("#question-my").removeClass("inactive");
		$("#question-my").addClass("active");
	}
	
	function addAnswer() {
		var title = $("#title").val();
		var answer = $("#answer").val();
		if (title && answer) {
			var result = confirm("确认就这样提交吗？");
			if (result) {
				var questionId = $("#question-id").val();
				if (!questionId) {
					questionId = 0;
				}
				var id = $("#answer-id").val();
				AjaxUtil.post("<c:url value='/addanswer/" + questionId + "'/>", {id:id, title:title, answer:answer}, function(data) {
					if (data == "success") {
						location.reload(true);
					}
				});
			}
		}
	}
	
	function getAnswer(id) {
		$("#answer-id").val(id);
		$.get("<c:url value='/answerdetail/" + id + "'/>", function(data) {
			$("#title").val(data.title);
			$("#answer").val(data.answer);
		});
	}
	
	function deleteAnswer(id) {
		var result = confirm("确认删掉这一问吗？");
		if (result) {
			$.post("<c:url value='/deleteanswer/" + id + "'/>", null, function(data) {
				if (data == "success") {
					location.reload(true);
				}
			});
		}
	}
	
	function giveAnAnswer(id, question) {
		$("#question-id").val(id);
		$("#title").val(question);
		$("#answer").val("");
	}
	
	function ignoreQuestion(id) {
		$.post("<c:url value='/ignorequestion/" + id + "'/>", null, function(data) {
			if (data == "success") {
				location.reload(true);
			}
		});
	}
</script>
</body>
</html>