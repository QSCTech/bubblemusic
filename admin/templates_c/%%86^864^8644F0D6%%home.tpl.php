<?php /* Smarty version 2.6.22, created on 2010-02-20 13:41:57
         compiled from home.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'get_cover', 'home.tpl', 16, false),)), $this); ?>
<script language="javascript" src="templates/js/home.js"></script>
<link rel="stylesheet" type="text/css" href="templates/css/home.css" />
<div id="manage_bar">
	<a class="prev" <?php if ($this->_tpl_vars['page_prev']): ?>href='./?action=page_home&page=<?php echo $this->_tpl_vars['page_prev']; ?>
'<?php else: ?>style='color:#999;'<?php endif; ?>>
    	&nbsp;上一页
    </a>
	<button id="manage">管 理</button>
	<a class="next" <?php if ($this->_tpl_vars['page_next']): ?>href='./?action=page_home&page=<?php echo $this->_tpl_vars['page_next']; ?>
'<?php else: ?>style='color:#999;'<?php endif; ?>>
		&nbsp;&nbsp;下一页
    </a>
</div>
<ul id="album_list">
	<?php $_from = $this->_tpl_vars['album']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['item']):
?>
	<li>
    	<div class="cover" id="<?php echo $this->_tpl_vars['item']['album_id']; ?>
_album">
            <img class="image" src="<?php echo smarty_function_get_cover(array('album_id' => $this->_tpl_vars['item']['album_id']), $this);?>
" />
            <img class="image_cover" src="templates/images/image_cover.png">
            <a href="./?action=page_music&ltype=list&aid=<?php echo $this->_tpl_vars['item']['album_id']; ?>
"><img class="highlight" src="templates/images/highlight.png"></a>
            <img class="update_cover" src="templates/images/upload_img_button.png">
            <img class="del_button" src="templates/images/del_button.png" />
        </div>
        <div class="name">
            <h3><?php echo $this->_tpl_vars['item']['album_name']; ?>
</h3>
            <h4><?php echo $this->_tpl_vars['item']['artists_name']; ?>
</h4>
        </div>
    </li>
    <?php endforeach; endif; unset($_from); ?>
</ul>