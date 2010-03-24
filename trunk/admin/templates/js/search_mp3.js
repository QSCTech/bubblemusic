/**
 * @author lang
 */
$(document).ready(function(){
	$("#mp3_list img.do_add").bind("click",add_mp3)
})

function add_mp3(){
	var do_add = this;
		
	var data = {request : "add_mp3"};
	var li = $(do_add).parents("li")
	li.find("input").each(function(){
		eval("data."+this.name + '="' + this.value + '"');
	})
	li.find("select").each(function(){
		eval("data."+this.name + '="' + this.value + '"');
	})
	
	//ajax请求
	$.post("ajax.php", data, function(json){
		try{
			eval(json);
			if(!json.result){
				do_add.src = "templates/images/error.png";
			}else{
				do_add.src = "templates/images/done.png";
			}
		}
		catch(e){
			do_add.src = "templates/images/error.png";
		}
	});
	do_add.src = "templates/images/loading_big.gif";
	$(do_add).unbind("click");
}

