<script language="javascript" src="templates/js/home.js"></script>
<link rel="stylesheet" type="text/css" href="templates/css/home.css" />
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