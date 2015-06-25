$(window).scroll(function() {
	var contentsVisible = $("#contents-nav").visible();
	if (!contentsVisible) {
		$("#backToTopButton").css("display", "block");
		$("#contents-nav-fixed").css("display", "block");
		$("#contents-nav").css("visibility", "hidden");
	}
	else {
		$("#backToTopButton").css("display", "none");
		$("#contents-nav-fixed").css("display", "none");
		$("#contents-nav").css("visibility", "visible");
	}
	
	$(".description-boxes").each(function() {
		var elementID = $(this).attr("id");
		$("#" + elementID + "-link").removeClass("active");
	});
	
	var scrollPosition = ($('body').scrollTop()) + (10 + $("#contents-nav-fixed").height());
	
	if ((($('body').scrollTop()) + ($(window).height())) >= ($(document).height())) {
		var links = $(".description-boxes");
		var lastLink = links[links.length - 1];
		var elementID = $(lastLink).attr("id");
		
		$("#" + elementID + "-link").addClass("active");
	}
	else {
		$(".description-boxes").each(function() {
			var elementOffset = ($(this).offset().top) - 10;
			var nextElementOffset = ($(this).next().offset().top) - 10;
		
			var elementID = $(this).attr("id");
		
			if((scrollPosition >= elementOffset) && (scrollPosition <= nextElementOffset)) {
				$("#" + elementID + "-link").addClass("active");
			}
		});
	}
});