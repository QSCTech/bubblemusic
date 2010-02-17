<?php
	function db_album_get_album_num()
	{
		global $db_prefix;	
		
		$sql = "SELECT count(album_id) FROM {$db_prefix}album";
		$row = db_get_one($sql);
		return $row[0];
	}
	
	function db_album_get_album($page = NULL, $page_size = NULL){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}album ORDER BY album_id DESC";
		if($page){
			$start_row = ($page - 1) * $page_size;
			$sql .= " LIMIT $start_row, $page_size";
		}
		else if($page_size){
			$sql .= " LIMIT $page_size";
		}
		
		return db_get_rows($sql);
	}
	
	function db_album_get_album4name($album_name = null, $artists_name = null){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}album WHERE 1 = 1 ";
		if($album_name){
			$sql .= " AND album_name = '$album_name'";
		}
		if($artists_name){
			$sql .= " AND artists_name = '$artists_name'";
		}
		return db_get_rows($sql);
	}
	
	function db_album_get_album4id($album_id = null, $artists_id = null){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}album WHERE 1 = 1";
		if($album_id){
			$sql .= " AND album_id = $album_id";
		}
		if($artists_id){
			$sql .= " AND artists_id = $artists_id";
		}
		return db_get_one($sql);
	}
	
	function db_album_add_album($value){
		global $db_prefix;
		
		$sql = "INSERT INTO {$db_prefix}album ";
		return db_insert($sql, $value);
	}
	
	function db_album_del_album($album_id){
		global $db_prefix;
		
		$sql = "DELETE FROM {$db_prefix}album WHERE album_id = $album_id";
		
		return mysql_query($sql);
	}
?>