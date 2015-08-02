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
	.manage-block {
		margin:20px 0 20px 0;
	}
	
	td {
		text-align:left;
	}
	
	td button {
		margin:0 5px;
	}
	
	.table-block {
		margin-top:20px;
		text-align:center;
	}
	
	.show {
		display:block;
	}
	
	.hidden {
		display:none;
	}
	
	.li-tab:hover {
		cursor:pointer;
	}
	
	.clearfix:after {
		content:"";
		clear:both;
	}
</style>
</head>
<body>

<div class="container">
<div class="row">
<div class="col-md-1"></div>
<div class="col-md-10 manage-block">
	<div class="panel panel-default">
		<div class="panel-heading clearfix">
	    	<h3 class="panel-title">
	    		词库管理
	    		<button class="btn btn-primary btn-xs" style="float:right" onclick="addAnswer()">添加词条</button>
	    	</h3>
	  	</div>
	  	<div class="panel-body" style="padding:10px;">
	  		<ul class="nav nav-tabs nav-justified">
				<li id="li-wordbank" role="presentation" class="li-tab active" onclick="changeTableView(this)"><a>迪吧词库</a></li>
			  	<li id="li-wordcontribute" role="presentation" class="li-tab" onclick="changeTableView(this)"><a>听众贡献</a></li>
			  	<li id="li-wordsupple" role="presentation" class="li-tab" onclick="changeTableView(this)"><a>听众补充</a></li>
			  	<li id="li-wordsearch" role="presentation" class="li-tab" onclick="changeTableView(this)"><a>搜索记录</a></li>
			</ul>
			
			<div id="wordbank" class="table-block show">
				<table class="table table-bordered table-hover">
					<thead>
				        <tr>
				          <th>#</th>
				          <th>更新时间</th>
				          <th>标题</th>
				          <th>操作</th>
				        </tr>
				    </thead>
				    <tbody id="answer-tbody">
				    </tbody>
				</table>
			</div>
			
			<div id="wordcontribute" class="table-block hidden">
				<table class="table table-bordered table-hover">
					<thead>
				        <tr>
				          <th>#</th>
				          <th>时间</th>
				          <th>来自</th>
				          <th>标题</th>
				          <th>操作</th>
				        </tr>
				    </thead>
				    <tbody id="contribute-tbody">
				    </tbody>
				</table>
			</div>
			
			<div id="wordsupple" class="table-block hidden">
				<table class="table table-bordered table-hover">
					<thead>
				        <tr>
				          <th>#</th>
				          <th>时间</th>
				          <th>来自</th>
				          <th>关于</th>
				          <th>的补充</th>
				          <th>操作</th>
				        </tr>
				    </thead>
				    <tbody id="supple-tbody">
				    </tbody>
				</table>
			</div>
			
			<div id="wordsearch" class="table-block hidden">
				<table class="table table-bordered table-hover">
					<thead>
				        <tr>
				          <th>#</th>
				          <th>检索时间</th>
				          <th>内容</th>
				          <th>操作</th>
				        </tr>
				    </thead>
				    <tbody id="search-tbody">
				    </tbody>
				</table>
			</div>
	  	</div>
	</div>
</div>
<div class="col-md-1"></div>
</div>
</div>

<div class="footer">
	薛人一度 优斯无数 Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> | 浙ICP备15023861号 | ©2015
</div>

<div id="word-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        		<h4 class="modal-title" id="exampleModalLabel">词库编辑</h4>
      		</div>
	      	<div class="modal-body">
          		<div class="form-group">
            		<input id="title" placeholder="标题" type="text" class="form-control" maxlength="100">
          		</div>
          		<div class="form-group">
            		<textarea id="answer" placeholder="内容" class="form-control" rows="6" maxlength="1000"></textarea>
          		</div>
	      	</div>
	      	<div class="modal-footer">
	        	<button type="button" class="btn btn-default" style="outline:none;" data-dismiss="modal">关闭</button>
	        	<button type="button" class="btn btn-primary" style="outline:none;" onclick="doSubmit()">提交</button>
	      	</div>
    	</div>
  	</div>
</div>

<script>
	$("#word-modal").on("hidden.bs.modal", function(e) {
		$("#title").val("");
		$("#answer").val("");
	});

	function changeTableView(element) {
		$(".li-tab").removeClass("active");
		$(".show").addClass("hidden");
		$(".show").removeClass("show");
		var li = $(element);
		var liId = li.attr("id");
		var tableId = liId.split("-")[1];
		li.addClass("active");
		$("#" + tableId).removeClass("hidden");
		$("#" + tableId).addClass("show");
	}

	getAnswerList();
	getContributeList();
	getSuppleList();
	getSearchList();
	
	function getAnswerList() {
		$.get("<c:url value='/lastestAnswerlist'/>", function(list) {
			if (list) {
				$("#answer-tbody").html();
				var answerHtml = "";
				for (var i in list) {
					var index = (parseInt(i) + 1);
					var data = list[i];
					var html = "<tr>";
					html += ("<td>" + index + "</td>");
					html += ("<td>" + data.updateDatetimeLabel + "</td>");
					html += ("<td>" + data.title + "</td>");
					html += ("<td>" + 
								"<button class='btn btn-success btn-xs' onclick='ding(" + data.id + ")'>顶</button>" + 
								"<button class='btn btn-primary btn-xs' onclick='getAnswer(" + data.id + ")'>更新</button>" + 
								"<button class='btn btn-danger btn-xs' onclick='deleteAnswer(" + data.id + ")'>删除</button>" + 
							"</td>");
					html += "</tr>";
					answerHtml += html;
				}
				$("#answer-tbody").html(answerHtml);
			}
		});
	}
	
	function getContributeList() {
		$.get("<c:url value='/fansanswerlist'/>", function(list) {
			if (list) {
				$("#contribute-tbody").html("");
				var bodyHtml = "";
				for (var i in list) {
					var index = (parseInt(i) + 1);
					var data = list[i];
					var html = "<tr>";
					html += ("<td>" + index + "</td>");
					html += ("<td>" + data.updateDatetimeLabel + "</td>");
					html += ("<td>" + data.fansName + "</td>");
					html += ("<td>" + data.title + "</td>");
					html += ("<td>" + 
								"<button class='btn btn-primary btn-xs' onclick='getFansAnswer(" + data.id + ")'>审批</button>" + 
								"<button class='btn btn-danger btn-xs' onclick='deleteFansAnswer(" + data.id + ")'>删除</button>" + 
							"</td>");
					html += "</tr>";
					bodyHtml += html;
				}
				$("#contribute-tbody").html(bodyHtml);
			}
		});
	}
	
	function getSuppleList() {
		$.get("<c:url value='/unapprovedSuppleAnswerlist'/>", function(list) {
			if (list) {
				$("#supple-tbody").html("");
				var bodyHtml = "";
				for (var i in list) {
					var index = (parseInt(i) + 1);
					var data = list[i];
					var html = "<tr>";
					html += ("<td>" + index + "</td>");
					html += ("<td>" + data.updateDatetimeLabel + "</td>");
					html += ("<td>" + data.fansName + "</td>");
					html += ("<td>" + data.parentAnswerTitle + "</td>");
					html += ("<td>" + data.answer + "</td>");
					html += ("<td>" + 
								"<button class='btn btn-success btn-xs' onclick='approveSupplement(" + data.id + ", " + data.answerId + ")'>通过</button>" + 
								"<button class='btn btn-danger btn-xs' onclick='denialSupplement(" + data.id + ")'>拒绝</button>" + 
							"</td>");
					html += "</tr>";
					bodyHtml += html;
				}
				$("#supple-tbody").html(bodyHtml);
			}
		});
	}
	
	function getSearchList() {
		$.get("<c:url value='/questionlist'/>", function(list) {
			if (list) {
				$("#search-tbody").html("");
				var bodyHtml = "";
				for (var i in list) {
					var index = (parseInt(i) + 1);
					var data = list[i];
					var html = "<tr>";
					html += ("<td>" + index + "</td>");
					html += ("<td>" + data.updateDatetimeLabel + "</td>");
					html += ("<td>" + data.question + "</td>");
					html += ("<td>" + 
								"<button class='btn btn-primary btn-xs' onclick='addSearchAnswer(" + data.id + ", \"" + data.question + "\")'>解答</button>" + 
								"<button class='btn btn-danger btn-xs' onclick='deleteSearch(" + data.id + ")'>忽略</button>" + 
							"</td>");
					html += "</tr>";
					bodyHtml += html;
				}
				$("#search-tbody").html(bodyHtml);
			}
		});
	}
	
	// --- Functions --- //
	
	var submitFunction;
	
	function doSubmit() {
		if (submitFunction) {
			var title = $("#title").val();
			if (!title) {
				alert("请输入标题");
				return;
			}
			var answer = $("#answer").val();
			if (!answer) {
				alert("请输入内容");
				return;
			}
			var result = confirm("是否确认提交？");
			if (result) {
				submitFunction();
			}
		}
	}
	
	function initModal(title, answer) {
		$("#title").val(title);
		$("#answer").val(answer);
		$("#word-modal").modal("show");
	}
	
	function addAnswer() {
		initModal("", "");
		submitFunction = function() {
			var title = $("#title").val();
			var answer = $("#answer").val();
			AjaxUtil.post("<c:url value='/addanswer'/>", {title:title, answer:answer}, function(data) {
				if (data == "success") {
					$("#word-modal").modal("hide");
					getAnswerList();
				}
			});
		};
	}
	
	function ding(id) {
		$.post("<c:url value='/ding/" + id + "'/>", null, function(data) {
			if (data == "success") {
				getAnswerList();
			}
		});
	}
	
	function getAnswer(id) {
		$.get("<c:url value='/answerdetail/" + id + "'/>", function(data) {
			if (data) {
				updateAnswer(data);
			}
		});
	}
	
	function getFansAnswer(id) {
		$.get("<c:url value='/getfansanswer/" + id + "'/>", function(data) {
			if (data) {
				updateFansAnswer(data);
			}
		});
	}
	
	function updateAnswer(data) {
		initModal(data.title, data.answer);
		submitFunction = function() {
			var title = $("#title").val();
			var answer = $("#answer").val();
			AjaxUtil.post("<c:url value='/updateAnswer'/>", {id:data.id, title:title, answer:answer}, function(data) {
				if (data == "success") {
					$("#word-modal").modal("hide");
					getAnswerList();
				}
			});
		};
	}
	
	function updateFansAnswer(data) {
		initModal(data.title, data.answer);
		submitFunction = function() {
			var title = $("#title").val();
			var answer = $("#answer").val();
			AjaxUtil.post("<c:url value='/approveFansAnswer/" + data.id + "'/>", {title:title, answer:answer, fansId:data.id}, function(data) {
				if (data == "success") {
					$("#word-modal").modal("hide");
					getContributeList();
					getAnswerList();
				}
			});
		};
	}
	
	function addSearchAnswer(id, title) {
		initModal(title, "");
		submitFunction = function() {
			var title = $("#title").val();
			var answer = $("#answer").val();
			AjaxUtil.post("<c:url value='/addSearchAnswer/" + id + "'/>", {title:title, answer:answer}, function(data) {
				if (data == "success") {
					$("#word-modal").modal("hide");
					getSearchList();
					getAnswerList();
				}
			});
		};
	}
	
	function deleteAnswer(id) {
		var result = confirm("是否确定删除这一词条？");
		if (result) {
			$.post("<c:url value='/deleteanswer/" + id + "'/>", null, function(data) {
				if (data == "success") {
					getAnswerList();
				}
			});
		}
	}
	
	function deleteFansAnswer(id) {
		var result = confirm("是否确定删除这一词条？");
		if (result) {
			$.post("<c:url value='/deletefansanswer/" + id + "'/>", null, function(data) {
				if (data == "success") {
					getContributeList();
				}
			});
		}
	}
	
	function deleteSearch(id) {
		$.post("<c:url value='/ignorequestion/" + id + "'/>", null, function(data) {
			if (data == "success") {
				getSearchList();
			}
		});
	}
	
	function approveSupplement(id, answerId) {
		var result = confirm("是否确定通过这一条？");
		if (result) {
			$.post("<c:url value='/approveSupplement/" + id + "/" + answerId + "'/>", null, function(data) {
				if (data == "success") {
					getSuppleList();
				}
			});
		}
	}
	
	function denialSupplement(id) {
		var result = confirm("是否确定删除这一条？");
		if (result) {
			$.post("<c:url value='/denialSupplement/" + id + "'/>", null, function(data) {
				if (data == "success") {
					getSuppleList();
				}
			});
		}
	}
</script>
</body>
</html>