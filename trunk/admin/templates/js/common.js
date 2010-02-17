/**
 * @author lang
 */
function pop_up(width, height, html){
	if ($("#pop_up").length == 0) {
		$("<div id=\"pop_up\"></div>").css({
			"width": width,
			"height": height,
			"left": ($(window).width() - width) / 2,
			"top": $(document).scrollTop() + ($(window).height() - height) / 2
		}).html(html).appendTo(document.body);
		$("#pop_up").fadeIn("slow");
		
		$("<div id=\"close_button\"></div>").css({
			"left": width - 15,
			"top": -15
		}).appendTo($("#pop_up")).click(function(){
			$("#pop_up").fadeOut("slow", function(){
				$("#pop_up").remove();
			})
		})
	}
	return $("#pop_up");
}
