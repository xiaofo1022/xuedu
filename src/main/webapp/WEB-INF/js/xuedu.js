$("#search-text").focus(function(e) {
	$("span.top").css("width", "100%");
	$("span.left").css("height", "100%");
	$("span.bottom").css("width", "100%");
	$(".search-dropdown").css("height", "auto");
});

$("#search-text").blur(function(e) {
	$("span.top").css("width", "0");
	$("span.left").css("height", "0");
	$("span.bottom").css("width", "0");
	setTimeout(function() {
		$(".search-dropdown").css("height", "0px");
	}, 500);
});

function showResult(isDontKnow) {
	if (isDontKnow) {
		$("#back-btn").html("< 算了");
		$("#contribute-btn").removeClass("hide");
	} else {
		$("#contribute-btn").addClass("hide");
		$("#back-btn").html("< 知道了吧");
	}
	
	$("#answer").css("display", "block");

	$(".main").css("z-index", "9");
	$(".main").removeClass("main-zoom-out");
	$(".main").addClass("main-zoom");
	
	$(".result").css("z-index", "99");
	$(".result").removeClass("result-hide");
	$(".result").addClass("result-show");
}

function showContribute() {
	$("#contribute").removeClass("hidden");
	$("#contribute").removeClass("hide-contribute");
	$("#contribute").addClass("show-contribute");
}

function hideContribute() {
	$("#contribute").removeClass("show-contribute");
	$("#contribute").addClass("hide-contribute");
}

function show50Latest() {
	$("#all-lastest").removeClass("hidden");
	$("#all-lastest").removeClass("hide-contribute");
	$("#all-lastest").addClass("show-contribute");
}

function hide50Latest() {
	$("#all-lastest").removeClass("show-contribute");
	$("#all-lastest").addClass("hide-contribute");
}

function show50Hotest() {
	$("#all-hotest").removeClass("hidden");
	$("#all-hotest").removeClass("hide-contribute");
	$("#all-hotest").addClass("show-contribute");
}

function hide50Hotest() {
	$("#all-hotest").removeClass("show-contribute");
	$("#all-hotest").addClass("hide-contribute");
}

function sayOneMore() {
	$("#fans-title").val($("#search-text").val());
	showContribute();
	showMain();
}

function showMain() {
	$(".ans-block").css("display", "none");

	$(".main").css("z-index", "99");
	$(".main").removeClass("main-zoom");
	$(".main").addClass("main-zoom-out");
	
	$(".result").css("z-index", "9");
	$(".result").removeClass("result-show");
	$(".result").addClass("result-hide");
}