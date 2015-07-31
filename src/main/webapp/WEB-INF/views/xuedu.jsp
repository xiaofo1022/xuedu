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
	<div class="main-block">
		<div class="logo">
			Xue
			<img src="images/xuedu/MrXue.png"/>
			薛度
		</div>
		<div class="down-box">
			<div class="search-block">
				<a>
					<input id="search-text" type="text" maxlength="30"/>
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
		<div id="easter-egg-dialog" class="easter-egg-dialog"></div>
	</div>
	
	<div id="contribute" class="contribute hidden">
		<div class="form">
			<span class="close-btn" onclick="hideContribute()"></span>
			<input id="fans-name" type="text" maxlength="100" placeholder="我是谁？" />
			<input id="fans-title" type="text" maxlength="100" placeholder="我要说？" />
			<textarea id="fans-answer" maxlength="1000" placeholder="是什么？"></textarea>
			<div class="btn" onclick="contributeOil()">提交</div>
		</div>
	</div>
	
	<div id="all-lastest" class="contribute hidden">
		<div class="form" style="height:480px;">
			<span class="close-btn" onclick="hide50Latest()"></span>
			<span>最新二十条</span>
			<div id="new-50-search" class="more-search-board"></div>
		</div>
	</div>
	
	<div id="all-hotest" class="contribute hidden">
		<div class="form" style="height:480px;">
			<span class="close-btn" onclick="hide50Hotest()"></span>
			<span>最热二十条</span>
			<div id="hot-50-search" class="more-search-board"></div>
		</div>
	</div>
	
	<canvas id="canvas"></canvas>
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
				<p id="answer-info" class="answer-info">
				</p>
			</div>
			<div id="back-btn" class="back-btn" onclick="showMain()">
				&lt; 知道了吧？
			</div>
		</div>
	</div>
</div>

<div class="footer">
	薛人一度 优斯无数 Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> ©2015
</div>

<script src="<c:url value='js/jquery.js'/>"></script>
<script src="<c:url value='js/ajax-util.js'/>"></script>
<script src="<c:url value='js/xuedu.js'/>"></script>
<script src="<c:url value='js/spark.js'/>"></script>
<script>
	var searchMap = {};
	var resultMap = {};
	var resultCount = 0;
	var isDontKnow = false;
	
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
			var keyValue;
			var searchValue;
			for (var key in searchMap) {
				keyValue = key.toLowerCase();
				searchValue = search.toLowerCase();
				if (keyValue.indexOf(searchValue) >= 0) {
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
			if (!donotSetSearch) {
				$("#search-text").val(result.title);
			}
			$("#answer-title").html(result.title);
			$("#answer-info").html(result.answer.replace(/\n/g, "<br/>"));
			isDontKnow = false;
			if (result.isEasterEgg) {
				$.post("<c:url value='/removedeaster/" + id + "'/>", null, function(data) {});
				makeEasterEgg();
				showEasterTip(result.easterCode)
			} else {
				$.post("<c:url value='/increasesearch/" + id + "'/>", null, function(data) {});
				showResult();
			}
		}
	}
	
	function showEasterTip(easterCode) {
		var easterTip = "恭喜你搜中薛度彩蛋一枚";
		if (easterCode) {
			easterTip += (" 请牢记彩蛋码:" + easterCode);
		}
		$("#easter-egg-dialog").html(easterTip);
		$("#easter-egg-dialog").css("-webkit-filter", "blur(0rem)");
		$("#easter-egg-dialog").css("filter", "blur(0rem)");
		$("#easter-egg-dialog").css("opacity", "1");
	}
	
	var hotestAnswerList = [];
	var lastestAnswerList = [];
	var maxPresentSize = 9;
	var maxPresent50 = 20;
	
	+function init() {
		$.get("<c:url value='/answerlist'/>", function(list) {
			if (list) {
				hotestAnswerList = list;
				var isOverMax = false;
				for (var i in list) {
					var data = list[i];
					searchMap[data.title] = data.id;
					resultMap[data.id] = data;
					if (i < maxPresentSize) {
						appendHotSearchLink("hot-search", i, data);
					} else {
						if (!isOverMax) {
							appendShowAllLink("hot-search");
							isOverMax = true;
						}
					}
					if (i < maxPresent50) {
						appendHotSearchLink("hot-50-search", i, data);
					}
				}
				$("#hot-search").css("visibility", "visible");
			}
		});
		
		$.get("<c:url value='/lastestAnswerlist'/>", function(list) {
			if (list) {
				lastestAnswerList = list;
				var isOverMax = false;
				for (var i in list) {
					var data = list[i];
					if (i < maxPresentSize) {
						appendHotSearchLink("new-search", i, data);
					} else {
						if (!isOverMax) {
							appendShowAllLink("new-search");
							isOverMax = true;
						}
					}
					if (i < maxPresent50) {
						appendHotSearchLink("new-50-search", i, data);
					} else {
						break;
					}
				}
				$("#new-search").css("visibility", "visible");
			}
		});
	}();
	
	function appendShowAllLink(searchId) {
		var alltip = "";
		if (searchId == "new-search") {
			alltip = "最新二十条";
		} else {
			alltip = "最热二十条";
		}
		$("#" + searchId).append($("<a id='" + searchId + "' class='show-all-link' onclick='present50Answers(this)'>" + alltip + "</a>"));
	}
	
	function present50Answers(allLink) {
		var link = $(allLink);
		var linkId = link.attr("id");
		if (linkId == "new-search") {
			show50Latest();
		} else {
			show50Hotest();
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
			indexClass = "just-soso";
		}
		
		var linkText = title;
		
		if (linkText.length > 15) {
			linkText = linkText.substring(0, 15) + "...";
		}
		
		return $('<span class="hot-block">' + 
					'<span class="' + indexClass + '">' + index + '.</span>' + 
					'<a class="hot-link" onclick="showDu(' + id + ', true)"><span>' + linkText + '</span>' + 
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
				$("#answer-info").html("这个这个，我也不知道耶。");
				isDontKnow = true;
				showResult(true);
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
				alert("薛科长会尽快审批你的提议，好好干小同志！");
				location.reload(true);
			});
		}
	}
</script>
</body>
</html>