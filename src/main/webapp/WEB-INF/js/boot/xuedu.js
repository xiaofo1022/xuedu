var searchMap = {};
var resultMap = {};
var resultCount = 0;

+function init() {
	if (baseurl == "/") {
		baseurl = "";
	}
	$.get(baseurl + "/answerlist", function(list) {
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
		$.post(baseurl + "/increasesearch/" + id, null, function(data) {});
		var answer = result.answer;
		if (result.fansAnswer) {
			var fansName = result.fansAnswer.fansName;
			answer += getContributeFromBlock(fansName);
		}
		modal.find(".modal-title").html(result.title);
		modal.find(".modal-body").html(answer);
		modal.find("#close-btn").text("我知道啦");
	} else {
		modal.find(".modal-title").html("这个这个");
		modal.find(".modal-body").html("我也不知道啦");
		modal.find("#close-btn").text("那好吧");
	}
	modal.modal("show");
}

function getContributeFromBlock(fansName) {
	return "<br/><span style='float:right;'> --- 来自:" + fansName + "的贡献</span>";
}

function clearContribute() {
	$("#fans-name").val("");
	$("#fans-title").val("");
	$("#fans-answer").val("");
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
		
		AjaxUtil.post(baseurl + "/addfansanswer", {fansName:fansName, title:title, answer:answer}, function(data) {
			alert("薛科长会尽快审批你的提议，好好干小同志！");
			$("#contribute-modal").modal("hide");
			clearContribute();
			contributing = false;
		});
	}
}