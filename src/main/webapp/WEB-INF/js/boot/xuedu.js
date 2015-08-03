$("#answer-modal").on("hide.bs.modal", function(e) {
	$("#search-result-modal").modal("hide");
});

$("#supplement-modal").on("hide.bs.modal", function(e) {
	$("#supple-fans-name").val("");
	$("#supple-fans-answer").val("");
	$("#answer-modal").modal("hide");
});

$("#search-text").keypress(function(e) {
	if (e.keyCode == "13") {
		inputCheck();
    }
});

+function init() {
	if (baseurl == "/") {
		baseurl = "";
	}
}();

function inputCheck() {
	var search = $("#search-text").val();
	if (search) {
		AjaxUtil.post(baseurl + "/blursearch", {title:search}, function(resultList) {
			if (resultList) {
				if (resultList.length > 1) {
					showResultListModal(resultList);
				} else if (resultList.length == 1) {
					getAnswer(resultList[0].id);
				} else {
					getAnswer(0);
				}
			} else {
				getAnswer(0);
			}
		});
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
		var result = resultList[i];
		var btnHtml = getListGroupHtml(result.id, index, result.title);
		html += btnHtml;
	}
	$("#search-result-ul").html(html);
	$("#search-result-title").html("检索结果");
	$("#search-result-modal").modal("show");
}

function getListGroupHtml(id, index, title) {
	return '<button type="button" class="list-group-item" style="outline:none;" onclick="getAnswer(' + id + ')">' + index + '. ' + title + '</button>';
}

var increaseMap = {};

function getAnswer(id) {
	var modal = $("#answer-modal");
	$.get(baseurl + "/getanswer/" + id, function(result) {
		if (result) {
			if (!increaseMap[id]) {
				$.post(baseurl + "/increasesearch/" + id, null, function(data) {});
				increaseMap[id] = true;
			}
			var answer = "<div class='clearfix'>" + result.answer.replace(/\n/g, "<br/>");
			if (result.fansAnswer) {
				var fansName = result.fansAnswer.fansName;
				answer += getContributeFromBlock(fansName);
			}
			answer += "</div>";
			modal.find(".modal-title").html(result.title);
			modal.find(".modal-body").html(answer);
			getSuppleAnswer(result.supplementAnswerList);
			modal.find("#close-btn").text("真有学问");
		} else {
			var question = $("#search-text").val();
			if (question) {
				AjaxUtil.post(baseurl + "/question", {question:question}, function(data) {});
			}
			modal.find(".modal-title").html("这个...");
			modal.find(".modal-body").html("我也不知道啦");
			modal.find("#close-btn").text("那好吧");
		}
		$("#answer-modal-id").val(id);
		modal.modal("show");
	});
}

function getSuppleAnswer(list) {
	if (list) {
		var modalBody = $("#answer-modal-body");
		for (var i in list) {
			var data = list[i];
			var suppleHtml = ("<div class='supple-block clearfix'>" + data.answer + "<br/><span style='float:right;'> --- 来自:" + data.fansName + "的补充</span></div>");
			modalBody.append($(suppleHtml));
		}
	}
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
var mrxuestip = "薛科长会尽快审批你的提议，好好干小同志！";

function contributeOil() {
	if (!contributing) {
		var fansName = $("#fans-name").val();
		var title = $("#fans-title").val();
		var answer = $("#fans-answer").val();
		
		if (!fansName) {
			alert("你是谁呀");
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
			alert(mrxuestip);
			$("#contribute-modal").modal("hide");
			clearContribute();
			contributing = false;
		});
	}
}

var happyMap = {};

function happyCrazy() {
	var id = $("#answer-modal-id").val();
	if (id && !happyMap[id]) {
		$.post(baseurl + "/increasehappy/" + id, null, function(data) {});
		happyMap[id] = true;
	}
	$("#answer-modal").modal("hide");
}

function suppleSome() {
	$("#supplement-modal").modal("show");
}

var suppleing = false;

function submitSupple() {
	if (!suppleing) {
		var answerId = $("#answer-modal-id").val();
		var fansName = $("#supple-fans-name").val();
		var answer = $("#supple-fans-answer").val();
		var title = "";
		
		if (!fansName) {
			alert("你是谁呀");
			$("#supple-fans-name").focus();
			return;
		}
		if (!answer) {
			alert("你要补充什么呀");
			$("#supple-fans-answer").focus();
			return;
		}
		
		if (answerId == "0") {
			title = $("#search-text").val();
		}
		
		suppleing = true;
		
		AjaxUtil.post(baseurl + "/addsupplementanswer", {answerId:answerId, fansName:fansName, answer:answer, title:title}, function(data) {
			alert(mrxuestip);
			suppleing = false;
			$("#supplement-modal").modal("hide");
		});
	}
}
