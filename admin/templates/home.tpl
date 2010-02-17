<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="templates/css/common.css" />
<link rel="stylesheet" type="text/css" href="templates/css/home.css" />
<script language="javascript" src="templates/lib/jquery/jquery-1.3.2.js"></script>
<script type="text/javascript" src="templates/lib/uploadify/jquery.uploadify.v2.1.0.min.js"></script>
<script type="text/javascript" src="templates/lib/uploadify/swfobject.js"></script>
<script language="javascript" src="templates/js/common.js"></script>
<script language="javascript" src="templates/js/home.js"></script>
<title>bubble管理</title>
</head>

<body>
    {include file=header.tpl title = "bubble管理 - 专辑管理"}
    
    <div id="container">
    	{include file = left.tpl}
        <div id="right">
        	<div id="manage_bar">
            	<a class="prev" {if $page_prev}href='./?action=page_home&page={$page_prev}'{else}style='color:#999;'{/if}>
                	&nbsp;上一页
                </a>
        		<button id="manage">管 理</button>
            	<a class="next" {if $page_next}href='./?action=page_home&page={$page_next}'{else}style='color:#999;'{/if}>
					&nbsp;&nbsp;下一页
                </a>
            </div>
        	<ul id="album_list">
            	{foreach from=$album item=item}
            	<li>
                	<div class="cover" id="{$item.album_id}_album">
                        <img class="image" src="{get_cover album_id=$item.album_id}" />
                        <img class="image_cover" src="templates/images/image_cover.png">
                        <a href="./?action=page_music&ltype=list&aid={$item.album_id}"><img class="highlight" src="templates/images/highlight.png"></a>
                        <img class="update_cover" src="templates/images/upload_img_button.png">
                        <img class="del_button" src="templates/images/del_button.png" />
                    </div>
                    <div class="name">
                        <h3>{$item.album_name}</h3>
                        <h4>{$item.artists_name}</h4>
                    </div>
                </li>
                {/foreach}
            </ul>
        </div>
    </div>
</body>
</html>
