<?php
	require "config.php";
	
	require "db/db.inc.php";
	//实用类
	require "util/id3.php";
	require "util/util.php";
	if(isset($_POST["request"])){
		$request = $_POST["request"];
	}
	
	else{
		$request = $_GET["request"];
	}
	if(file_exists("do/ajax/$request.php")){
		include "do/ajax/$request.php";
	}
?>