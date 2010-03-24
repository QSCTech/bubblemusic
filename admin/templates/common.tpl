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
    {include file=header.tpl title = "bubble管理"}
	{if $file != "login"}
    <div id="container">
    	{include file = left.tpl}
        <div id="right">
        	{include file ="$file.tpl"}
        </div>
    </div>
	{else}
    	{include file ="$file.tpl"}
	{/if}
</body>
</html>
