<?php /* Smarty version 2.6.22, created on 2010-03-12 08:48:10
         compiled from notice.tpl */ ?>
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
	<?php $_from = $this->_tpl_vars['notice']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
	<li class="block">
        <h2><b><?php echo $this->_tpl_vars['item']['notice_head']; ?>
</b> - <?php echo $this->_tpl_vars['item']['date']; ?>
</h2>
		<p>
			<?php echo $this->_tpl_vars['item']['notice_content']; ?>

		</p>
    </li>
	<?php endforeach; endif; unset($_from); ?>
</ul>