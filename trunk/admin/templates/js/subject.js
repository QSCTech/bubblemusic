/**
 * @author lang
 */
$(document).ready(function(){
	//添加专题模块
    $(".close_button").click(function(){
        $(this).parent("div.block").remove();
    })
    $("#add_subject input[type=button]").click(function(){
        if (!$("#add_subject input[name=subject_name]").val()) {
            $("#add_subject p.warn").html("还没有填入专题名啊。。。。")
        }
        else {
            $("#add_subject input[type=submit]").click();
        }
    })
	
	/**
	 * 取自home.js
	 */
	$("#subject_list .cover").hover(function(){
		$(this).find(".update_cover").fadeIn("fast");
		},
		function(){
		$(this).find(".update_cover").fadeOut("fast");	
	})
	
	$(".update_cover").click(function(){
		subject_id = parseInt($(this).parents(".cover").attr("id"));
		pop_up(500,100,"<h2>上传专辑图片</h2><input type='file' name='upload' id='upload' />");
		$("#upload").uploadify({
			"uploader" : "templates/lib/uploadify/uploadify.swf",
			'script' : "ajax.php",
			'auto' : true,
			'scriptData' : {'request' : 'subject',
							"subject_id" : subject_id,
							"operation": "upload"},
			'cancelImg' : 'templates/lib/uploadify/cancel.png',
			'onComplete' : function(event, queueID, fileObj, response, data){
				eval(response);
				$("#"+subject_id+"_subject img.image").attr("src",json.src);
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
		subject_id = parseInt($(this).parents(".cover").attr("id"));
		pop_up(400, 80, "<h2>是否删除该专辑</h2><button onclick='do_del("+subject_id+");'>确定</button>");
	})
})

function start_manage()
{
	$(".cover .del_button").fadeIn("fast",function(){
		$("#manage").attr("mStatus", 1)
	});
	$("#manage").html("取 消");
}
function end_manage()
{
	$(".cover .del_button").fadeOut("fast",function(){
		$("#manage").attr("mStatus", 0)
	});
	$("#manage").html("管 理");
}
function do_del(subject_id)
{
    var data = {
        request: "subject",
		operation: "delete",
		subject_id: subject_id
    };
	$.post("ajax.php", data, function(){
		$("#close_button").click();
		subject = $("#"+subject_id+"_subject").parent("li");
		subject.html(null);
		subject.animate({
				width : 0
			},
			{
				duration:300,
				complete:function(){
					subject.remove();
				}
			});
	})
}
