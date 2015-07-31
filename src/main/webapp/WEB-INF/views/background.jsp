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
<link href="<c:url value='css/background.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="container clearfix">
	<div class="block">
		<div id="btn-my" class="btn btn-tab btn-active" onclick="pageTab('my')">迪吧词库</div>
		<div id="btn-listener" class="btn btn-tab" onclick="pageTab('listener')">听众搜索</div>
		<div id="btn-oil" class="btn btn-tab" onclick="pageTab('oil')">听众贡献</div>
		
		<div id="question-my" class="question-block active">
			<c:forEach items="${answerList}" var="answer">
				<div class="question-row clearfix">
					<div class="info">${answer.title}</div>
					<div class="btn-control" onclick="deleteAnswer(${answer.id}, this)">删除</div>
					<div class="btn-control" onclick="getAnswer(${answer.id})">更新</div>
				</div>
			</c:forEach>
		</div>
		
		<div id="question-listener" class="question-block inactive">
			<c:forEach items="${questionList}" var="question">
				<div class="question-row clearfix">
					<div class="info">${question.question}</div>
					<div class="btn-control" onclick="ignoreQuestion(${question.id}, this)">忽略</div>
					<div class="btn-control" onclick="giveAnAnswer(${question.id}, '${question.question}')">解答</div>
				</div>
			</c:forEach>
		</div>
		
		<div id="question-oil" class="question-block inactive">
			<c:forEach items="${fansAnswerList}" var="fansAnswer">
				<div class="question-row clearfix">
					<div class="info">${fansAnswer.fansName}: ${fansAnswer.title}</div>
					<div class="btn-control" onclick="deleteFansAnswer(${fansAnswer.id}, this)">删除</div>
					<div class="btn-control" onclick="getFansAnswer(${fansAnswer.id})">查看</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<div class="block">
		<input id="title" placeholder="标题：" type="text" maxlength="100"/>
		<textarea id="answer" placeholder="内容：" maxlength="1000"></textarea>
		<input id="isEasterEgg" type="checkbox"/>彩蛋
		<input id="easterCode" placeholder="彩蛋码：" type="text" maxlength="6"/>
		<input id="nextEasterTip" placeholder="下一条彩蛋提示：" type="text" maxlength="100"/>
		<div class="btn" onclick="addAnswer()">提交</div>
	</div>
	
	<input id="answer-id" type="hidden"/>
	<input id="question-id" type="hidden"/>
	<input id="oil-id" type="hidden"/>
</div>

<script src="<c:url value='js/jquery.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
<script>
	function pageTab(id) {
		$(".btn-tab").removeClass("btn-active");
		$("#btn-" + id).addClass("btn-active");
		
		$(".question-block").removeClass("active");
		$(".question-block").addClass("inactive");
		$("#question-" + id).removeClass("inactive");
		$("#question-" + id).addClass("active");
	}
	
	function addAnswer() {
		var title = $("#title").val();
		var answer = $("#answer").val();
		var easterChecked = $("#isEasterEgg").prop("checked");
		var isEasterEgg = easterChecked ? 1 : 0;
		var easterCode = $("#easterCode").val();
		var nextEasterTip = $("#nextEasterTip").val();
		
		if (!title) {
			alert("请输入词条标题");
			return;
		}
		if (!answer) {
			alert("请输入词条内容");
			return;
		}
		
		if (title && answer) {
			var result = confirm("确认就这样提交吗？");
			if (result) {
				var questionId = $("#question-id").val();
				if (!questionId) {
					questionId = 0;
				}
				var oilId = $("#oil-id").val();
				if (!oilId) {
					oilId = 0;
				}
				var id = $("#answer-id").val();
				AjaxUtil.post("<c:url value='/addanswer/" + questionId + "/" + oilId + "'/>",
					{id:id, title:title, answer:answer, isEasterEgg:isEasterEgg, easterCode:easterCode, nextEasterTip:nextEasterTip},
					function(data) {
						if (data == "success") {
							if (id == 0) {
								location.reload(true);
							} else {
								clearInput();
							}
						}
					}
				);
			}
		}
	}
	
	function getAnswer(id) {
		$("#answer-id").val(id);
		$.get("<c:url value='/answerdetail/" + id + "'/>", function(data) {
			$("#title").val(data.title);
			$("#answer").val(data.answer);
			var isEasterEgg = data.isEasterEgg;
			if (isEasterEgg) {
				$("#isEasterEgg").prop("checked", true);
			} else {
				$("#isEasterEgg").prop("checked", false);
			}
			$("#easterCode").val(data.easterCode);
			$("#nextEasterTip").val(data.nextEasterTip);
		});
	}
	
	function deleteAnswer(id, element) {
		var result = confirm("确认删掉这一条吗？");
		if (result) {
			$.post("<c:url value='/deleteanswer/" + id + "'/>", null, function(data) {
				if (data == "success") {
					removeRow(element);
				}
			});
		}
	}
	
	function giveAnAnswer(id, question) {
		$("#question-id").val(id);
		$("#title").val(question);
		$("#answer").val("");
	}
	
	function ignoreQuestion(id, element) {
		$.post("<c:url value='/ignorequestion/" + id + "'/>", null, function(data) {
			if (data == "success") {
				removeRow(element);
			}
		});
	}
	
	function removeRow(element) {
		var elem = $(element);
		var par = elem.parent();
		par.remove();
	}
	
	function getFansAnswer(id) {
		$("#question-id").val("");
		$("#answer-id").val("");
		$("#oil-id").val(id);
		$.get("<c:url value='/getfansanswer/" + id + "'/>", function(data) {
			$("#title").val(data.title);
			$("#answer").val(data.answer);
		});
	}
	
	function clearInput() {
		$("#question-id").val("");
		$("#answer-id").val("");
		$("#oil-id").val("");
		$("#title").val("");
		$("#answer").val("");
		$("#isEasterEgg").prop("checked", false);
		$("#easterCode").val("");
		$("#nextEasterTip").val("");
	}
	
	function deleteFansAnswer(id, element) {
		var result = confirm("确认删掉这一条吗？");
		if (result) {
			$.post("<c:url value='/deletefansanswer/" + id + "'/>", null, function(data) {
				if (data == "success") {
					removeRow(element);
				}
			});
		}
	}
</script>
</body>
</html>