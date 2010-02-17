<?php
	require "config.php";
	
	require "db/db.inc.php";
	//smarty模板
	require "libs/Smarty.class.php";
	$smarty = new Smarty;
	$smarty->compile_check = true;
	$smarty->debugging = $debug;
	//实用类
	require "util/id3.php";
	require "util/util.php";
	
	$action = isset($_GET["action"]) ? explode("_", $_GET["action"],2) : array("page","home");
	$type = $action[0];
	$file = $action[1];
	
	if(file_exists("$type/$file.php")){
		include "$type/$file.php";
	}
	else{
		exit("file not exit");
	}
	$class = $type."_".$file;
	$module = new $class($smarty);
	
	if($type == "page"){
		$smarty->assign("file", $file);
		//文件存放路径
		$smarty->assign("source", SOURCE);
		$smarty->display("$file.tpl");
	}
	
?>