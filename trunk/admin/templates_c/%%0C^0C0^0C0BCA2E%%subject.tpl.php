<?php /* Smarty version 2.6.22, created on 2010-03-23 00:37:45
         compiled from subject.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'get_cover', 'subject.tpl', 34, false),)), $this); ?>
<script language="javascript" src="templates/js/subject.js"></script>
<link rel="stylesheet" type="text/css" href="templates/css/subject.css" />
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
		<p>
			<b>专题名：</b>
        	<input type="text" name="subject_name"/>&nbsp;&nbsp;
			<b>专题图片：</b>
            <input type="file" name="image_file"/>
		</p>
    	<P>
			<b>描&nbsp;&nbsp;述：</b><textarea name="description"></textarea>
    	</P>
        <input type="button" class="button" value="添 加">
		<input type="submit" style="display:none;" />
    </form>
	<img src="templates/images/close_button.png" class="close_button"/>
</div>
<ul id="subject_list">
	<?php $_from = $this->_tpl_vars['subject']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['item']):
?>
	<li>
    	<div class="cover" id="<?php echo $this->_tpl_vars['item']['subject_id']; ?>
_subject">
            <img class="image" src="<?php echo smarty_function_get_cover(array('path' => $this->_tpl_vars['item']['sid']), $this);?>
" />
            <img class="image_cover" src="templates/images/image_cover.png">
            <a href="./?action=page_manage_subject&sid=<?php echo $this->_tpl_vars['item']['subject_id']; ?>
"><img class="highlight" src="templates/images/highlight.png"></a>
            <img class="update_cover" src="templates/images/upload_img_button.png">
            <img class="del_button" src="templates/images/del_button.png" />
        </div>
        <div class="name">
            <h3><?php echo $this->_tpl_vars['item']['subject_name']; ?>
</h3>
        </div>
    </li>
    <?php endforeach; endif; unset($_from); ?>
</ul>