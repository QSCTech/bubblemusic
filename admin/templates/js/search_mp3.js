/**
 * @author lang
 */
$(document).ready(function(){
	$("#mp3_list img.button").bind("click",add_mp3)
})

function add_mp3(){
	var button = this;
		
	var data = {request : "add_mp3"};
	var li = $(button).parents("li")
	li.find("input").each(function(){
		eval("data."+this.name + '="' + this.value + '"');
	})
	data.genre = li.find("select").val();
	
	//ajax请求
	$.post("ajax.php", data, function(json){
		button.src = "templates/images/done.png";
		if (json) {
			eval(json);
		}
	});
	button.src = "templates/images/loading_big.gif";
	$(button).unbind("click");
}

