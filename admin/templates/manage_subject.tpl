<link rel="stylesheet" type="text/css" href="templates/css/manage_subject.css" />
<script language="javascript" src="templates/js/manage_subject.js"></script>
<script language="javascript" src="templates/lib/ui/js/ui.draggable.js"></script>
<script language="javascript">
	{if $subject_id}
		var subject_id = {$subject_id};
		var page_all = {$page_all};
	{/if}
</script>

<div id="edit_subject" class="block">
	<h2>修改专题信息</h2>
	<p class="warn"></p>
	<form action="./?action=do_edit_subject" method="post">
    	<p>
			<b>专题名：</b>
        	<input type="text" name="subject_name" value="{$subject.subject_name}"/>&nbsp;&nbsp;
		</p>
    	<P>
			<b>描&nbsp;&nbsp述：</b><textarea name="description">{$subject.description}</textarea>
    	</P>
        <input type="button" class="button" value="修 改">
		<input type="submit" style="display:none;" />
		<input type="hidden" value="{$subject.subject_id}" name="subject_id" />
    </form>
	<img src="templates/images/close_button.png" class="close_button"/>
</div>

<div id="music_list" class="block">
	<h2>所有歌曲</h2>
	<div class="tool_bar">
		<img src="templates/images/undo.png" title="撤销" class="undo"/>
		<img src="templates/images/redo.png" title="重复" class="redo"/>
		<input type="text" class="search">
		<span class="page">页数: 1 / {$page_all}</span>
		<span>歌曲数目:{$music_num}</span>
	</div>
	<ul class="music">
		{foreach from=$music item=item key=key}
		<li class='tr_style_{$key%2}' id="{$item.music_id}_music">
			<h3>{$item.music_name}</h3>
			<span>- {$item.album_name} - {$item.artists_name}</span>
			<img src="templates/images/subject_add_music.png" title="添加这首歌到专题"/>
		</li>
    	{/foreach}
	</ul>
	<div class="scroll_bar">
		<img src="templates/images/scroll_up.png" class="scroll_up" title="上一页"/>
		<div class="bar">
			<div class="slider block" title="1 / {$page_all}"></div>
			<div class="pagetip">&nbsp;</div> 
		</div>
		<img src="templates/images/scroll_down.png" class="scroll_down" title="下一页"/>
	</div>
</div>
<div id="subject_music_list" class="block">
	<h2>"{$subject.subject_name}"的歌曲</h2>
	{if $subject_music}
		<p class='info'>
			你可以在左边框中选择要添加的歌曲。
		</p>
		<ul class="music">
    		{foreach from=$subject_music item=item key=key}
			<li class='tr_style_{$key%2}' id="{$item.music_id}_subject_music">
				<h3>{$item.music_name}</h3>
				<span>- {$item.album_name} - {$item.artists_name}</span>
				<img src="templates/images/subject_remove_music.png" title="从专题中移除该歌"/>
			</li>
        	{/foreach}
		</ul>
	{else}
		<p class='info'>
			该专题目前还木有添加任何歌曲<br />
			你可以在左边框中选择要添加的歌曲。
		</p>
	{/if}
</div>