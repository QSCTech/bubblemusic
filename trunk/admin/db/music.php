<?php
	function db_music_get_music_num($album_id = NULL, $artists_id = NULL)
	{
		global $db_prefix;	
		
		$sql = "SELECT count(music_id) FROM {$db_prefix}music WHERE 1=1 ";
		if($album_id){
			$sql .= " AND album_id = $album_id";
		}
		if($artists_id){
			$sql .= " AND artists_id = $artists_id";
		}
		$row = db_get_one($sql);
		return $row[0];
	}
	
	function db_music_get_music($page = NULL, $page_size = NULL, $order_by = NULL){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music";
		//列表排列方式
		$order_by = $order_by ? $order_by : "music_id DESC";
		$sql .= " ORDER BY $order_by";
		
		if($page){
			$start_row = ($page - 1) * $page_size;
			$sql .= " LIMIT $start_row, $page_size";
		}
		else if($page_size){
			$sql .= " LIMIT $page_size";
		}
		
		return db_get_rows($sql);
	}
	
	function db_music_search_music_num($keyword)
	{
		global $db_prefix;	
		
		$sql = "SELECT count(music_id) FROM {$db_prefix}music WHERE music_name LIKE \"%$keyword%\" ";
		
		$row = db_get_one($sql);
		return $row[0];
	}
	
	function db_music_search_music($keyword, $page = NULL, $page_size = NULL, $order_by = NULL)
	{
		global $db_prefix;	
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE music_name LIKE \"%$keyword%\" ";
		
		//列表排列方式
		$order_by = $order_by ? $order_by : "music_id DESC";
		$sql .= " ORDER BY $order_by";
		
		if($page){
			$start_row = ($page - 1) * $page_size;
			$sql .= " LIMIT $start_row, $page_size";
		}
		else if($page_size){
			$sql .= " LIMIT $page_size";
		}
		return db_get_rows($sql);
	}
	
	function db_music_get_music4music_name($name){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE music_name = \"$name\"";
		return db_get_rows($sql);
	}
	
	function db_music_get_music4music_id($id){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE music_id = $id";
		return db_get_one($sql);
	}
	
	function db_music_get_music4album_name($name){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE album_name = \"$name\"";
		return db_get_rows($sql);
	}
	
	function db_music_get_music4album_id($id){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE album_id = $id";
		return db_get_rows($sql);
	}
	
	function db_music_get_music4artists_name($name){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE artists_name = \"$name\"";
		return db_get_rows($sql);
	}
	
	function db_music_get_music4artists_id($id){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE artists_id = $id";
		return db_get_rows($sql);
	}
	
	function db_music_get_music4genre($gid){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music WHERE genre = $gid";
		return db_get_rows($sql);
	}
	
	function db_get_upload_date4album_id($id){
		global $db_prefix;
		
		$sql = "SELECT upload_date FROM {$db_prefix}music WHERE album_id = $id GROUP BY upload_date";
		
		return db_get_rows($sql);
	}
	
	function db_music_add_music($value){
		global $db_prefix;
		
		$sql = "INSERT INTO {$db_prefix}music ";
		return db_insert($sql, $value);
	}
	
	function db_music_del_music4music_id($music_id){
		global $db_prefix;
		
		$sql = "DELETE FROM {$db_prefix}music WHERE music_id = $music_id";
		
		return mysql_query($sql);
	}
	
	function db_music_del_music4album_id($album_id){
		global $db_prefix;
		
		$sql = "DELETE FROM {$db_prefix}music WHERE album_id = $album_id";
		
		return mysql_query($sql);
	}
	
	function db_music_update_music($value, $music_id)
	{
		global $db_prefix;
		
		$sql = "UPDATE {$db_prefix}music ";
		return db_update($sql, $value, array("music_id"=>$music_id));
	}
	
	function db_music_update_lyric($music_id, $lyric){
		global $db_prefix;
		
		$lyric = addslashes($lyric);
		$sql = "INSERT INTO  {$db_prefix}lyric";
		$lyric_id = db_insert($sql, array("lyric"=>$lyric));
		
		$sql = "UPDATE {$db_prefix}music";
		return db_update($sql, array("lyric_id"=>$lyric_id), array("music_id"=>$music_id));
	}