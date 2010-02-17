/**
 * @author lang
 */
$(document).ready(function(){
	$("#album_list .cover").hover(function(){
		$(this).find(".update_cover").fadeIn("fast");
		},
		function(){
		$(this).find(".update_cover").fadeOut("fast");	
	})
	//图片显示错误,二重保护= =
	$("#album_list .cover .image").error(function(){
		$(this).attr("src", "templates/images/no_cover.jpg")
	})
	//上传专辑图片
	$(".update_cover").click(function(){
		album_id = parseInt($(this).parents(".cover").attr("id"));
		pop_up(500,100,"<h2>上传专辑图片</h2><input type='file' name='upload' id='upload' />");
		$("#upload").uploadify({
			"uploader" : "templates/lib/uploadify/uploadify.swf",
			'script' : "ajax.php",
			'auto' : true,
			'scriptData' : {'request' : 'upload_cover',
							"album_id" : album_id},
			'cancelImg' : 'templates/lib/uploadify/cancel.png',
			'onComplete' : function(event, queueID, fileObj, response, data){
				eval(response);
				$("#"+album_id+"_album img.image").attr("src",json.src);
				$("#close_button").click();
			}
		})
	})
	//切换管理状态，管理状态可以删除专辑
	$("#manage").attr("mStatus", 0);	//0为非管理状态
	$("#manage").click(function(){
		if($("#manage").attr("mStatus") == 0){
			start_manage();
		}
		else{
			end_manage();
		}
	})
	$(".del_button").click(function(){
		album_id = parseInt($(this).parents(".cover").attr("id"));
		pop_up(400, 80, "<h2>是否删除该专辑</h2><button onclick='del_step2("+album_id+");'>确定</button>");
	})
})

function start_manage()
{
	$(".cover .del_button").fadeIn("normal",function(){
		$("#manage").attr("mStatus", 1)
	});
	$("#manage").html("取 消");
}
function end_manage()
{
	$(".cover .del_button").fadeOut("normal",function(){
		$("#manage").attr("mStatus", 0)
	});
	$("#manage").html("管 理");
}

function del_step2(album_id)
{
	$("#pop_up").remove();
	pop_up(400, 80, "<h2>是否删除同时该专辑中的歌曲</h2><button onclick='do_del("+album_id+",1);'>要</button><button onclick='do_del("+album_id+",0);'>不要</button>");
}

function do_del(album_id, del_music)
{
	var data = {request : "del_album"};
	data.album_id = album_id;
	data.del_music = del_music;
	$.post("ajax.php", data, function(){
		$("#close_button").click();
		album = $("#"+album_id+"_album").parent("li");
		album.html(null);
		album.animate({
				width : 0
			},
			{
				duration:300,
				complete:function(){
					album.remove();
				}
			});
	})
}
