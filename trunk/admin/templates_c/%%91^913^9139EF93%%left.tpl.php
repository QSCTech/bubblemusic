<?php /* Smarty version 2.6.22, created on 2010-03-22 23:31:32
         compiled from left.tpl */ ?>
<div id="left">
	<div class="user_info">
		hey, <i><?php echo $this->_tpl_vars['user_name']; ?>
</i>
		<a href="./?action=do_logout">登出</a>
	</div>
	<ul>
    	<li <?php if ($this->_tpl_vars['file'] == 'home'): ?>class ="hover"<?php endif; ?>>
        	<a href="./?action=page_home">专辑管理</a>
        </li>
        <li <?php if ($this->_tpl_vars['file'] == 'music'): ?>class="hover"<?php endif; ?>>
        	<a href="./?action=page_music">音乐管理</a>
        </li>
        <li <?php if ($this->_tpl_vars['file'] == 'subject' || $this->_tpl_vars['file'] == 'manage_subject'): ?>class="hover"<?php endif; ?>>
        	<a href="./?action=page_subject">专题管理</a>
        </li>
        <li <?php if ($this->_tpl_vars['file'] == 'notice'): ?>class="hover"<?php endif; ?>>
        	<a href="./?action=page_notice">通知管理</a>
        </li>
        <li <?php if ($this->_tpl_vars['file'] == 'search_mp3'): ?>class="hover"<?php endif; ?>>
        	<a href="./?action=page_search_mp3">搜索ftp</a>
        </li>
        <li <?php if ($this->_tpl_vars['file'] == 'preference'): ?>class="hover"<?php endif; ?>>
        	<a href="./?action=page_preference">设置</a>
        </li>
    </ul>
</div>