<link rel="stylesheet" type="text/css" href="templates/css/notice.css" />
<script language="javascript" src="templates/js/notice.js"></script>
<div id="add_notice" class="block">
	<h2>添加通知</h2>
	<p class="warn"></p>
	<form action="./?action=do_add_notice" method="post">
    	<p>
			<b>标&nbsp;&nbsp题：</b>
        	<input type="text" name="notice_head" value=""/>&nbsp;&nbsp;
		</p>
    	<P>
			<b>内&nbsp;&nbsp容：</b><textarea name="notice_content"></textarea>
    	</P>
        <input type="button" class="button" value="添 加">
		<input type="submit" style="display:none;" />
    </form>
	<img src="templates/images/close_button.png" class="close_button"/>
</div>
<ul id="notice_list">
	{foreach from=$notice item=item key=key}
	<li class="block">
        <h2><b>{$item.notice_head}</b> - {$item.date}</h2>
		<p>
			{$item.notice_content}
		</p>
    </li>
	{/foreach}
</ul>