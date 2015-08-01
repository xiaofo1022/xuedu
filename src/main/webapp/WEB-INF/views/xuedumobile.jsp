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
			<button class="btn btn-primary" style="outline:none;" type="button" onclick="inputCheck()">薛人一度</button>
		</span>
	</div>
</div>

<div class="contribute-block">
	<button type="button" class="btn btn-primary" style="outline:none;" data-toggle="modal" data-target="#contribute-modal">我为迪吧献石油</button>
</div>

<div id="accordion" class="panel-group answer-panel" role="tablist" aria-multiselectable="true">
	<div class="panel panel-default">
  		<div class="panel-heading" role="tab" id="headingOne">
			<h4 class="panel-title">
				<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          			随便二十条
        		</a>
      		</h4>
    	</div>
    	<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      		<div class="panel-body">
      			<ul class="list-group answer-list">
					<c:forEach items="${shuffleAnswerList}" var="answer" varStatus="status">
						<c:if test="${status.index < 20}">
							<button type="button" class="list-group-item" style="outline:none;" onclick="getAnswer(${answer.id})">${status.index + 1}. ${answer.title}</button>
						</c:if>
					</c:forEach>
				</ul>
      		</div>
    	</div>
	</div>
  
	<div class="panel panel-default">
		<div class="panel-heading" role="tab" id="headingTwo">
      		<h4 class="panel-title">
        		<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          			最新二十条
        		</a>
      		</h4>
    	</div>
    	<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      		<div class="panel-body">
      			<ul class="list-group answer-list">
					<c:forEach items="${answerList}" var="answer" varStatus="status">
						<c:if test="${status.index < 20}">
							<button type="button" class="list-group-item" style="outline:none;" onclick="getAnswer(${answer.id})">${status.index + 1}. ${answer.title}</button>
						</c:if>
					</c:forEach>
				</ul>
      		</div>
    	</div>
  	</div>
  	
 	<div class="panel panel-default">
		<div class="panel-heading" role="tab" id="headingThree">
      		<h4 class="panel-title">
        		<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          			最热二十条
        		</a>
      		</h4>
    	</div>
		<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      		<div class="panel-body">
      			<ul class="list-group answer-list">
					<c:forEach items="${hotestAnswerList}" var="answer" varStatus="status">
						<c:if test="${status.index < 20}">
							<button type="button" class="list-group-item" style="outline:none;" onclick="getAnswer(${answer.id})">${status.index + 1}. ${answer.title}</button>
						</c:if>
					</c:forEach>
				</ul>
      		</div>
    	</div>
	</div>
</div>

<div class="footer">
	Powered By <a href="http://weibo.com/p/1005052006466631" target="_blank">小佛儿</a> | 浙ICP备15023861号 | ©2015
</div>

<!-- Modals -->
<div id="answer-modal" class="modal fade" style="text-align:left;z-index:1199;">
	<div class="modal-dialog">
		<div class="modal-content">
	        <div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        	<h4 class="modal-title"></h4>
	      	</div>
	      	<div class="modal-body clearfix">
	      	</div>
	      	<div class="modal-footer">
	        	<button id="close-btn" type="button" class="btn btn-default" style="outline:none;" data-dismiss="modal"></button>
	      	</div>
	    </div>
	</div>
</div>

<div id="contribute-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        		<h4 class="modal-title" id="exampleModalLabel">我为迪吧献石油</h4>
      		</div>
	      	<div class="modal-body">
          		<div class="form-group">
            		<input id="fans-name" placeholder="我是谁？" type="text" class="form-control" maxlength="100">
          		</div>
          		<div class="form-group">
            		<input id="fans-title" placeholder="我要说？" type="text" class="form-control" maxlength="100">
          		</div>
          		<div class="form-group">
            		<textarea id="fans-answer" placeholder="是什么？" class="form-control" rows="4" maxlength="1000"></textarea>
          		</div>
	      	</div>
	      	<div class="modal-footer">
	        	<button type="button" class="btn btn-default" style="outline:none;" data-dismiss="modal">关闭</button>
	        	<button type="button" class="btn btn-primary" style="outline:none;" onclick="contributeOil()">提交</button>
	      	</div>
    	</div>
  	</div>
</div>

<div id="search-result-modal" class="modal fade" style="z-index:1099;">
	<div class="modal-dialog">
		<div class="modal-content">
	        <div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        	<h4 class="modal-title">检索结果</h4>
	      	</div>
	      	<div class="modal-body clearfix">
	      		<ul id="search-result-ul" class="list-group answer-list">
				</ul>
	      	</div>
	      	<div class="modal-footer">
	        	<button id="close-btn" type="button" class="btn btn-default" style="outline:none;" data-dismiss="modal">关闭</button>
	      	</div>
	    </div>
	</div>
</div>
<!-- Modals -->

<script>
	var baseurl = "<c:url value='/'/>";
</script>
<script src="<c:url value='js/boot/xuedu.js'/>"></script>
</body>
</html>