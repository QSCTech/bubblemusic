/**
 * @author lang
 */
//全局变量
var music_list_ori;		//最初的歌曲列表信息
var page = 1;				//页码
var page_size = 20;			//每页的大小
//page_all和subject_id在html文件中定义
var stack_undo = Array();	//操作堆栈，用来撤销
var stack_redo = Array();	//操作堆栈，用来重做

$(document).ready(function(){
    prepare();
    $(".close_button").click(function(){
        $(this).parent("div.block").remove();
    })
    $("#edit_subject input[type=button]").click(function(){
        if (!$("#edit_subject input[name=subject_name]").val()) {
            $("#edit_subject p.warn").html("还没有填入专题名啊。。。。")
        }
        else {
            $("#edit_subject input[type=submit]").click();
        }
    })
	//工具栏
	//保存最初的歌曲列表信息
	music_list_ori = $("#music_list ul").html();
    $(".tool_bar input.search").keyup(search);
	$(".tool_bar .undo").click(undo);
	$(".tool_bar .redo").click(redo);
	//滚动条
	$(".scroll_bar .scroll_up").click(get_prev_page);
	$(".scroll_bar .scroll_down").click(get_next_page);
	var slider = $(".scroll_bar .bar .slider");
	var bar = $(".scroll_bar .bar");
	slider.height(bar.height()/page_all);
	
	slider.draggable({
		grid: [20,bar.height()/page_all],
		axis: 'y',
		containment: 'parent',
		start: function() {
			
		},
		drag: function() {
			var top = slider.offset().top - bar.offset().top
			
			if (top >= 0 && top + slider.height() <= bar.height()) {
				//计算页数
				page = Math.ceil((top + slider.height()*0.3)/ slider.height());
				slider.attr("title", page+" / "+page_all);
				$(".tool_bar .page").html(page+" / "+page_all);
			}
		},
		stop: function() {
			get_page();
		}
	});
})

function prepare(){
    $("ul.music li").hover(function(){
        $(this)
        $(this).find("img").attr("style", "display:block");
    }, function(){
        $(this).find("img").attr("style", "display:none");
    })
    
    $("#music_list li img").click(add_music2subject);
    $("#subject_music_list li img").click(remove_subject_music);
	/*
	var slider = $(".scroll_bar .bar .slider");
	slider.css({
		"margin-top": slider.height() * (page-1) + "px"
	});
	*/
}

function add_music2subject(){
    var image = this;
    var data = {
        request: "subject",
        operation: "add",
		music_id : parseInt($(image).parent("li").attr("id")),
		subject_id : subject_id
    };
    //若专题列表已存在该歌曲就不添加
	if ($("#" + data.music_id + "_subject_music").length) {
		music_name = $(image).parent("li").find("h3").text();
		$("#subject_music_list .info").html("列表中已存在歌曲\""+music_name+"\"");
	}
	else {
		$.post("ajax.php", data, function(){
			if (!$("#subject_music_list ul").length) {
				$("#subject_music_list .info").after("<ul class=\"music\"></ul>");
			}
			//将该歌曲复制到专题歌曲列表当中
			var li_clone = $(image).parent("li").clone();
			li_clone.appendTo($("#subject_music_list ul"));
			li_clone.attr("id",data.music_id+"_subject_music")
			li_clone.find("img").attr("style", "display:none");
			li_clone.find("img").attr("src", "templates/images/subject_remove_music.png");
			prepare();
			
			music_name = $(image).parent("li").find("h3").text();
			$("#subject_music_list .info").html("已成功添加\""+music_name+"\"");
		})
		//压入堆栈
		stack_undo.push({
			operation:"add",
			id:data.music_id
		})
	}
}

function remove_subject_music(){
    var image = this;
    var data = {
        request: "subject",
        operation: "remove",
		music_id : parseInt($(image).parent("li").attr("id")),
		subject_id : subject_id
    };
    
    $.post("ajax.php", data, function(){
        music_name = $(image).parent("li").find("h3").text();
        $("#subject_music_list .info").html("已成功移除" + music_name);
        $(image).parent("li").remove();
    });
	//压入堆栈
	stack_undo.push({
		operation:"remove",
		id:data.music_id
	})
}

function get_next_page(){
	if(page < page_all){
	    var data = {
	        request: "subject",
	        operation: "get_music",
			page:page + 1,
			page_size:page_size
	    };
		page++;
		$.post("ajax.php", data, function(html){
            $("#music_list ul").html(html);
			$(".tool_bar .page").html(page+" / "+page_all);
            prepare();
			music_list_ori = $("#music_list ul").html();
		});
	}
}

function get_prev_page(){
	if(page > 1){
	    var data = {
	        request: "subject",
	        operation: "get_music",
			page:page - 1,
			page_size:page_size
	    };
		page--;
		$.post("ajax.php", data, function(html){
            $("#music_list ul").html(html);
			$(".tool_bar .page").html(page+" / "+page_all);
            prepare();
			music_list_ori = $("#music_list ul").html();
		});
	}
}

function get_page(){
    var data = {
        request: "subject",
        operation: "get_music",
		page:page,
		page_size:page_size
    };
	$.post("ajax.php", data, function(html){
        $("#music_list ul").html(html);
		$(".tool_bar .page").html(page+" / "+page_all);
        prepare();
		music_list_ori = $("#music_list ul").html();
	});
}

function search(){
	if ($(this).val()) {
        var data = {
            request: "subject",
            operation: "search",
			key:$(this).val()
        };
        $.post("ajax.php", data, function(html){
            $("#music_list ul").html(html);
            prepare();
        })
    }
	else{
		$("#music_list ul").html(music_list_ori);
        prepare();
	}
}

function undo(){
	if(stack_undo.length){
		data = stack_undo.pop();
		switch(data.operation){
			case "add":
				$("#"+data.id+"_subject_music").find("img").click();
				break;
			case "remove":
				$("#"+data.id+"_music").find("img").click();
				break;
		}
		stack_undo.pop();//前面add和remove操作中有不需要的push操作
		
		stack_redo.push({
			operation:data.operation,
			id:data.id
		})
	}
}

function redo(){
	if(stack_redo.length){
		data = stack_redo.pop();
		switch(data.operation){
			case "add":
				$("#"+data.id+"_music").find("img").click();
				break;
			case "remove":
				$("#"+data.id+"_subject_music").find("img").click();
				break;
		}
	}
}