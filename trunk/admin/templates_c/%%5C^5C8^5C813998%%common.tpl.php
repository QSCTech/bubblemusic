<?php /* Smarty version 2.6.22, created on 2010-03-20 05:46:21
         compiled from common.tpl */ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="templates/css/common.css" />
<script language="javascript" src="templates/lib/jquery/jquery-1.3.2.js"></script>
<!-- jquery ui库 -->
<script type="text/javascript" src="templates/lib/ui/js/ui.core.js"></script>
<link type="text/css" rel="stylesheet" href="templates/lib/ui/themes/base/ui.all.css" />
<!-- jquery uplodify库 -->
<script type="text/javascript" src="templates/lib/uploadify/jquery.uploadify.v2.1.0.min.js"></script>
<script type="text/javascript" src="templates/lib/uploadify/swfobject.js"></script>
<script language="javascript" src="templates/js/common.js"></script>
<title>bubble管理</title>
</head>

<body>
    <?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array('title' => "bubble管理")));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
	<?php if ($this->_tpl_vars['file'] != 'login'): ?>
    <div id="container">
    	<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "left.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
        <div id="right">
        	<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => ($this->_tpl_vars['file']).".tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
        </div>
    </div>
	<?php else: ?>
    	<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => ($this->_tpl_vars['file']).".tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
	<?php endif; ?>
</body>
</html>