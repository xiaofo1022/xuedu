var searchMap = {};
var resultMap = {};
var resultCount = 0;

$("#answer-modal").on("hide.bs.modal", function(e) {
	$("#search-result-modal").modal("hide");
});

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
		var resultList = [];
		var keyValue;
		var searchValue;
		for (var key in searchMap) {
			keyValue = key.toLowerCase();
			searchValue = search.toLowerCase();
			if (keyValue.indexOf(searchValue) >= 0) {
				resultList.push(searchMap[key]);
			}
		}
		if (resultList.length > 1) {
			showResultListModal(resultList);
		} else if (resultList.length == 1) {
			getAnswer(resultList[0]);
		} else {
			getAnswer(0);
		}
	}
}

function showFansContributeModal(fansName) {
	AjaxUtil.post(baseurl + "/answerlistByFans", {fansName:fansName}, function(list) {
		if (list) {
			$("#search-result-ul").html("");
			var html = "";
			for (var i in list) {
				var index = parseInt(i) + 1;
				var result = list[i];
				var btnHtml = getListGroupHtml(result.id, index, result.title);
				html += btnHtml;
			}
			$("#search-result-ul").html(html);
			$("#search-result-title").html("TA的贡献");
			$("#search-result-modal").modal("show");
		}
	});
}

function showResultListModal(resultList) {
	$("#search-result-ul").html("");
	var html = "";
	for (var i in resultList) {
		var index = parseInt(i) + 1;
		var id = resultList[i];
		var result = resultMap[id];
		var btnHtml = getListGroupHtml(id, index, result.title);
		html += btnHtml;
	}
	$("#search-result-ul").html(html);
	$("#search-result-title").html("检索结果");
	$("#search-result-modal").modal("show");
}

function getListGroupHtml(id, index, title) {
	return '<button type="button" class="list-group-item" style="outline:none;" onclick="getAnswer(' + id + ')">' + index + '. ' + title + '</button>';
}

function getAnswer(id) {
	var result = resultMap[id];
	var modal = $("#answer-modal");
	if (result) {
		$.post(baseurl + "/increasesearch/" + id, null, function(data) {});
		var answer = result.answer.replace(/\n/g, "<br/>");
		if (result.fansAnswer) {
			var fansName = result.fansAnswer.fansName;
			answer += getContributeFromBlock(fansName);
		}
		modal.find(".modal-title").html(result.title);
		modal.find(".modal-body").html(answer);
		modal.find("#close-btn").text("真有学问");
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