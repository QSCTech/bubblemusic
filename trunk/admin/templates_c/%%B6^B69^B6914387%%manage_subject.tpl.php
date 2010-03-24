<?php /* Smarty version 2.6.22, created on 2010-02-21 01:10:55
         compiled from manage_subject.tpl */ ?>
<link rel="stylesheet" type="text/css" href="templates/css/manage_subject.css" />
<script language="javascript" src="templates/js/manage_subject.js"></script>
<script language="javascript" src="templates/lib/ui/js/ui.draggable.js"></script>
<script language="javascript">
	<?php if ($this->_tpl_vars['subject_id']): ?>
		var subject_id = <?php echo $this->_tpl_vars['subject_id']; ?>
;
		var page_all = <?php echo $this->_tpl_vars['page_all']; ?>
;
	<?php endif; ?>
</script>

<div id="edit_subject" class="block">
	<h2>修改专题信息</h2>
	<p class="warn"></p>
	<form action="./?action=do_edit_subject" method="post">
    	<p>
			<b>专题名：</b>
        	<input type="text" name="subject_name" value="<?php echo $this->_tpl_vars['subject']['subject_name']; ?>
"/>&nbsp;&nbsp;
		</p>
    	<P>
			<b>描&nbsp;&nbsp述：</b><textarea name="description"><?php echo $this->_tpl_vars['subject']['description']; ?>
</textarea>
    	</P>
        <input type="button" class="button" value="修 改">
		<input type="submit" style="display:none;" />
		<input type="hidden" value="<?php echo $this->_tpl_vars['subject']['subject_id']; ?>
" name="subject_id" />
    </form>
	<img src="templates/images/close_button.png" class="close_button"/>
</div>

<div id="music_list" class="block">
	<h2>所有歌曲</h2>
	<div class="tool_bar">
		<img src="templates/images/undo.png" title="撤销" class="undo"/>
		<img src="templates/images/redo.png" title="重复" class="redo"/>
		<input type="text" class="search">
		<span class="page">页数: 1 / <?php echo $this->_tpl_vars['page_all']; ?>
</span>
		<span>歌曲数目:<?php echo $this->_tpl_vars['music_num']; ?>
</span>
	</div>
	<ul class="music">
		<?php $_from = $this->_tpl_vars['music']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
		<li class='tr_style_<?php echo $this->_tpl_vars['key']%2; ?>
' id="<?php echo $this->_tpl_vars['item']['music_id']; ?>
_music">
			<h3><?php echo $this->_tpl_vars['item']['music_name']; ?>
</h3>
			<span>- <?php echo $this->_tpl_vars['item']['album_name']; ?>
 - <?php echo $this->_tpl_vars['item']['artists_name']; ?>
</span>
			<img src="templates/images/subject_add_music.png" title="添加这首歌到专题"/>
		</li>
    	<?php endforeach; endif; unset($_from); ?>
	</ul>
	<div class="scroll_bar">
		<img src="templates/images/scroll_up.png" class="scroll_up" title="上一页"/>
		<div class="bar">
			<div class="slider block" title="1 / <?php echo $this->_tpl_vars['page_all']; ?>
"></div>
			<div class="pagetip">&nbsp;</div> 
		</div>
		<img src="templates/images/scroll_down.png" class="scroll_down" title="下一页"/>
	</div>
</div>
<div id="subject_music_list" class="block">
	<h2>"<?php echo $this->_tpl_vars['subject']['subject_name']; ?>
"的歌曲</h2>
	<?php if ($this->_tpl_vars['subject_music']): ?>
		<p class='info'>
			你可以在左边框中选择要添加的歌曲。
		</p>
		<ul class="music">
    		<?php $_from = $this->_tpl_vars['subject_music']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
			<li class='tr_style_<?php echo $this->_tpl_vars['key']%2; ?>
' id="<?php echo $this->_tpl_vars['item']['music_id']; ?>
_subject_music">
				<h3><?php echo $this->_tpl_vars['item']['music_name']; ?>
</h3>
				<span>- <?php echo $this->_tpl_vars['item']['album_name']; ?>
 - <?php echo $this->_tpl_vars['item']['artists_name']; ?>
</span>
				<img src="templates/images/subject_remove_music.png" title="从专题中移除该歌"/>
			</li>
        	<?php endforeach; endif; unset($_from); ?>
		</ul>
	<?php else: ?>
		<p class='info'>
			该专题目前还木有添加任何歌曲<br />
			你可以在左边框中选择要添加的歌曲。
		</p>
	<?php endif; ?>
</div>