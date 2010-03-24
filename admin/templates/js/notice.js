/**
 * @author lang
 */
$(document).ready(function(){
	//添加专题模块
    $(".close_button").click(function(){
        $(this).parent("div.block").remove();
    })
    $("#add_notice input[type=button]").click(function(){
        if (!$("#add_notice input[name=notice_head]").val()) {
            $("#add_notice p.warn").html("还没有填入标题啊。。。。")
        }
        else if (!$("#add_notice textarea[name=notice_content]").val()) {
            $("#add_notice p.warn").html("还没有填入内容啊。。。。")
        }	
        else {
            $("#add_notice input[type=submit]").click();
        }
    })
})
