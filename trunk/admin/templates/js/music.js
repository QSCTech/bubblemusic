/**
 * @author lang
 */
$(document).ready(function(){
	$("#music_list tbody tr").hover(function(){
			$(this).addClass("hover");
			
		},
		function(){
			$(this).removeClass("hover");
		}
	)
	$("#music_list tbody tr .music_name").click(function(){
		
		pop_up(600,430,"<img src='templates/images/loading_big.gif' class='loading'/>");
		//ajax请求
		var data = {request : "get_music_detail"};
		music_id = data.music_id = parseInt($(this).parents("tr").attr("id"));
		
		$.post("ajax.php", data, function(html){
			$("#pop_up .loading").replaceWith(html);
			
			$("#upload").uploadify({
				"uploader" : "templates/lib/uploadify/uploadify.swf",
				'script' : "ajax.php",
				'auto' : true,
				'scriptData' : {'request' : 'upload_lrc',
							"music_id" : music_id},
				'cancelImg' : 'templates/lib/uploadify/cancel.png',
				'onComplete' : function(event, queueID, fileObj, response, data){
					eval(response);
					$("#pop_up .lrc_path").html(json.lrc_path);
				}
			})
			$(".update").click(function(){
				var do_add = this;
				
				var data = {request : "update_mp3"};
				var pop_up = $(do_add).parents("#pop_up")
				pop_up.find("input").each(function(){
					eval("data."+this.name + '="' + this.value + '"');
				})
				pop_up.find("select").each(function(){
					eval("data."+this.name + '="' + this.value + '"');
				})
				
				//ajax请求
				$.post("ajax.php", data, function(html){
					window.location.reload();
				});
			})
		});
	})
	
	$("#music_list .delete").click(function(){
		pop_up(400, 100, "<h2>是否删除选中的歌</h2><button onclick='do_del();'>确定</button>");
	})
	$("#music_list .choose_all input").click(function(){
		if(this.checked == true){
			$("#music_list input[type=checkbox]").attr("checked",true);
		}
		else{
			$("#music_list input[type=checkbox]").attr("checked",false);
		}
	})
})

function do_del(){
	$("input[type=submit]").click();
}
