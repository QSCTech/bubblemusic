<?php
    $db = mysql_connect($db_host, $db_user, $db_pw);
	if(!$db){
		echo 'mysql connect error';
	}
	
	mysql_selectdb($db_name);
	
	require "db/common.php";
	require "db/album.php";
	require "db/artists.php";
	require "db/music.php";
	require "db/subject.php";
?>