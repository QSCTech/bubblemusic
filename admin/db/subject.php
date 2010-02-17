 <?php
	function db_subject_get_subject_num()
	{
		global $db_prefix;	
		
		$sql = "SELECT count(music_id) FROM {$db_prefix}subject";
		$row = db_get_one($sql);
		return $row[0];
	}
	
	function db_subject_get_subject($page = NULL, $page_size = NULL){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}subject";
		$sql .= " ORDER BY subject_id DESC";
		if($page){
			$start_row = ($page - 1) * $page_size;
			$sql .= " LIMIT $start_row, $page_size";
		}
		else if($page_size){
			$sql .= " LIMIT $page_size";
		}
		
		return db_get_rows($sql);
	}
	
	function db_subject_get_subject4subject_name($subject_name = null){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}subject WHERE 1 = 1 ";
		if($subject_name){
			$sql .= " AND subject_name = '$subject_name'";
		}
		$sql .= "ORDER BY subject_id DESC";
		return db_get_rows($sql);
	}
	
	function db_subject_get_subject4subject_id($subject_id = null){
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}subject WHERE 1 = 1";
		if($subject_id){
			$sql .= " AND subject_id = $subject_id";
		}
		return db_get_one($sql);
	}
	
	function db_subject_get_music_num4subject_id($subject_id)
	{
		global $db_prefix;
		
		$sql = "SELECT count(*) FROM {$db_prefix}subject_music WHERE subject_id = $subject_id";
		$row =  db_get_one($sql);
		return $row[0];
	}
	
	function db_subject_get_music4subject_id($subject_id)
	{
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}music as m, {$db_prefix}subject_music as sm 
				WHERE m.music_id = sm.music_id AND sm.subject_id = $subject_id";
		
		return db_get_rows($sql);
	}
	
	function db_subject_add_subject($value)
	{
		global $db_prefix;
		
		$sql = "INSERT INTO {$db_prefix}subject ";
		return db_insert($sql, $value);
	}
	
	function db_subject_update_subject_cover($subject_id, $image_file)
	{
		global $db_prefix;
		
		$sql = "UPDATE {$db_prefix}subject";
		return db_update($sql, array("image_file"=>$image_file), array("subject_id"=>$subject_id));
	}
	
	function db_subject_del_subject($subject_id)
	{
		global $db_prefix;
		
		$sql = "DELETE FROM {$db_prefix}subject WHERE subject_id = $subject_id";
		return mysql_query($sql);
	}
	
	function db_subject_add_music2subject($music_id, $subject_id)
	{
		global $db_prefix;
		
		$sql = "INSERT INTO {$db_prefix}subject_music ";
		return db_insert($sql, array("music_id"=>$music_id, "subject_id"=>$subject_id));
	}
	
	function db_subject_remove_subject_music($subject_id, $music_id = NULL)
	{
		global $db_prefix;
		
		$sql = "DELETE FROM {$db_prefix}subject_music WHERE subject_id = $subject_id ";
		if($music_id){
			$sql .= " AND music_id = $music_id";
		}
		return mysql_query($sql);
	}
?>