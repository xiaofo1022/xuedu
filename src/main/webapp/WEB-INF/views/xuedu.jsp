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
	<div class="side-block-down" style="border:0px solid gray;">
		<div class="down-box" style="border:0px solid black;">
			<div class="search-block">
				<a>
					<input id="search-text" type="text" maxlength="100"/>
					<span class="top"></span>
					<span class="left"></span>
					<span class="bottom"></span>
				</a>
				<a class="search-btn" onclick="requestQuestion()">薛人一度</a>
				<div id="search-dropdown" class="search-dropdown"></div>
			</div>
			<a class="oil-link" onclick="showContribute()">
				我为迪吧献石油
				<span class="under-link"></span>
			</a>
			<div id="hot-search" class="search-board hot-search"></div>
			<div id="new-search" class="search-board new-search"></div>
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

<div class="contribute hidden">
	<div class="form">
		<span class="close-btn" onclick="hideContribute()"></span>
		<input id="fans-name" type="text" maxlength="100" placeholder="我是谁？" />
		<input id="fans-title" type="text" maxlength="100" placeholder="我要说？" />
		<textarea id="fans-answer" maxlength="1000" placeholder="是什么？"></textarea>
		<div class="btn" onclick="contributeOil()">提交</div>
	</div>
</div>

<div class="footer">
	薛人一度 优斯无数 Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> ©2015
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
	
	function showDu(id, donotSetSearch) {
		var result = resultMap[id];
		if (result) {
			$.post("<c:url value='/increasesearch/" + id + "'/>", null, function(data) {});
			if (!donotSetSearch) {
				$("#search-text").val(result.title);
			}
			$("#answer-title").html(result.title);
			$("#answer-info").html(result.answer.replace(/\n/g, "<br/>"));
		}
		showResult();
	}
	
	var hotestAnswerList = [];
	var lastestAnswerList = [];
	var maxPresentSize = 9;
	
	+function init() {
		$.get("<c:url value='/answerlist'/>", function(list) {
			if (list) {
				hotestAnswerList = list;
				for (var i in list) {
					var data = list[i];
					searchMap[data.title] = data.id;
					resultMap[data.id] = data;
					if (i < maxPresentSize) {
						appendHotSearchLink("hot-search", i, data);
					} else {
						//appendShowAllLink("hot-search");
						break;
					}
				}
			}
		});
		
		$.get("<c:url value='/lastestAnswerlist'/>", function(list) {
			if (list) {
				lastestAnswerList = list;
				for (var i in list) {
					var data = list[i];
					if (i < maxPresentSize) {
						appendHotSearchLink("new-search", i, data);
					} else {
						//appendShowAllLink("new-search");
						break;
					}
				}
			}
		});
	}();
	
	function appendShowAllLink(searchId) {
		$("#" + searchId).append($("<a id='" + searchId + "' class='show-all-link' onclick='presentAllAnswer(this)'>查看全部 </a>"));
	}
	
	function presentAllAnswer(allLink) {
		var link = $(allLink);
		var linkId = link.attr("id");
		var list;
		if (linkId == "new-search") {
			list = lastestAnswerList;
		} else {
			list = hotestAnswerList;
		}
		link.hide();
		var searchBlock = $("#" + linkId);
		for (var i = maxPresentSize; i < list.length; i++) {
			var data = list[i];
			searchBlock.append(createHotSearchBlock(parseInt(i) + 1, data.id, data.title, data.searchCount));
		}
	}
	
	function appendHotSearchLink(searchId, index, data) {
		$("#" + searchId).append(createHotSearchBlock(parseInt(index) + 1, data.id, data.title, data.searchCount));
	}
	
	function createHotSearchBlock(index, id, title, count) {
		var indexClass = "";
		
		if (index == 1) {
			indexClass = "very-hot";
		} else if (index == 2) {
			indexClass = "so-hot";
		} else if (index == 3) {
			indexClass = "normal-hot";
		} else {
			indexClass = "just-sos";
		}
		
		return $('<span class="hot-block">' + 
					'<span class="' + indexClass + '">' + index + '.</span>' + 
					'<a class="hot-link" onclick="showDu(' + id + ', true)"><span>' + title + '</span>' + 
						'<span class="under-link"></span>' + 
					'</a>' + 
					'<span class="' + indexClass + ' fright">' + count + '</span>' + 
				'</span>');
	}
	
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
	
	var contributing = false;
	
	function contributeOil() {
		if (!contributing) {
			var fansName = $("#fans-name").val();
			var title = $("#fans-title").val();
			var answer = $("#fans-answer").val();
			
			if (!fansName) {
				alert("你要是不告诉我你是谁，我就不告诉你我是谁");
				$("#fans-name").focus();
				return;
			}
			if (!title) {
				alert("你要说什么呀");
				$("#fans-title").focus();
				return;
			}
			if (!answer) {
				alert("那么这是什么呢");
				$("#fans-answer").focus();
				return;
			}
			
			contributing = true;
			
			AjaxUtil.post("<c:url value='/addfansanswer'/>", {fansName:fansName, title:title, answer:answer}, function(data) {
				alert("您的提议会很快得到薛科长的审批，审批通过后您的提议会被纳入薛度词条，感谢！");
				location.reload(true);
			});
		}
	}
</script>
</body>
</html>