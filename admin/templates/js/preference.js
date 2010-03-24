/**
 * @author lang
 */
$(document).ready(function(){
		$("#banner_opacity, #left_opacity").slider({
			orientation: 'horizontal',
			range: "min",
			max: 100,
			value: 70,
			slide: preview,
			change: preview
		});
		
		$("#wall_paper").uploadify({
			"uploader" : "templates/lib/uploadify/uploadify.swf",
			'script' : "ajax.php",
			'auto' : true,
			'scriptData' : {
				'request' : 'upload_wall_paper',
				'user_id' : 0	
			},
			'cancelImg' : 'templates/lib/uploadify/cancel.png',
			'onComplete' : function(event, queueID, fileObj, response, data){
				eval(response);
				$("document.body").attr("style","background-image:url("+json.src+")");
			}
		})
})
function preview(){
	var banner_opacity = $("#banner_opacity").slider("value");
	var left_opacity = $("#left_opacity").slider("value");
	
	$("#banner").css("opacity",banner_opacity/100);
	$("#left").css("opacity",left_opacity/100);
	//IE下
	$("#banner").css("filter","alpha(opacity="+banner_opacity+")");
	$("#left").css("filter","alpha(opacity="+left_opacity+")");
}
