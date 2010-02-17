<?php
	function db_artists_get_artists(){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}artists";
		return db_get_rows($sql);
	}
	
	function db_artists_get_artists4name($name){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}artists WHERE artists_name = '$name'";
		return db_get_rows($sql);
	}
	
	function db_artists_get_artists4id($id){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}artists WHERE artists_id = $id";
		return db_get_one($sql);
	}
	
	function db_artists_add_artists($value){
		global $db_prefix;
		
		$sql = "INSERT INTO {$db_prefix}artists ";
		return db_insert($sql, $value);
	}
?>