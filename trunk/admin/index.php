<?php
	require "config.inc.php";
	
	require "client/client.php";
	
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
	//用户操作
	if(!isset($_COOKIE["bubble_sid"]) && $file != "login"){
		Header("Location:./?action=page_login");
	}
	else if($file != "login"){
		session_start();
		session_id($_COOKIE['bubble_sid']);
		$user_id = $_SESSION["user_id"];
		//更新cookie
		setcookie("bubble_sid", session_id(), time()+COOKIE_TIME);
	}
	//获取用户信息
	list($user_id, $user_name, $user_email) = uc_get_user($user_id, 1);
	//本地数据库
	//前面ucenter也要链接数据库，就放在后面了
	require "db/db.inc.php";
	
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
		//用户信息
		$smarty->assign("user_id", $user_id);
		$smarty->assign("user_name", $user_name);
		$smarty->assign("user_email", $user_email);
		
		$smarty->display("common.tpl");
	}