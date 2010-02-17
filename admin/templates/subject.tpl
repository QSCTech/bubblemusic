<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="templates/css/common.css" />
<link rel="stylesheet" type="text/css" href="templates/css/subject.css" />
<script language="javascript" src="templates/lib/jquery/jquery-1.3.2.js"></script>
<script type="text/javascript" src="templates/lib/uploadify/jquery.uploadify.v2.1.0.min.js"></script>
<script type="text/javascript" src="templates/lib/uploadify/swfobject.js"></script>
<script language="javascript" src="templates/js/common.js"></script>
<script language="javascript" src="templates/js/subject.js"></script>
<title>bubble管理</title>
</head>

<body>
    {include file=header.tpl title = "bubble管理 - 专题管理"}
    
    <div id="container">
    	{include file = left.tpl}
        <div id="right">
        	<div id="manage_bar">
            	<a class="prev">
                	&nbsp;上一页
                </a>
        		<button id="manage">管 理</button>
            	<a class="next">
					&nbsp;&nbsp;下一页
                </a>
            </div>
        	<div id="add_subject" class="block">
        		<h2>添加新的专题</h2>
				<p class="warn"></p>
	        	<form action="./?action=do_add_subject" method="post" enctype="multipart/form-data">
	            	<b>专题名：</b>
	            	<input type="text" name="subject_name"/>&nbsp;&nbsp;
					<b>专题图片：</b>
	                <input type="file" name="image_file"/>
	                <input type="button" class="button" value="添 加">
					<input type="submit" style="display:none;" />
	            </form>
				<img src="templates/images/close_button.png" class="close_button"/>
			</div>
        	<ul id="subject_list">
            	{foreach from=$subject item=item}
            	<li>
                	<div class="cover" id="{$item.subject_id}_subject">
                        <img class="image" src="{get_cover path=$item.image_file}" />
                        <img class="image_cover" src="templates/images/image_cover.png">
                        <a href="./?action=page_manage_subject&sid={$item.subject_id}"><img class="highlight" src="templates/images/highlight.png"></a>
                        <img class="update_cover" src="templates/images/upload_img_button.png">
                        <img class="del_button" src="templates/images/del_button.png" />
                    </div>
                    <div class="name">
                        <h3>{$item.subject_name}</h3>
                    </div>
                </li>
                {/foreach}
            </ul>
        </div>
    </div>
</body>
</html>
