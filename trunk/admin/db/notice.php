<?php
    function db_notice_get_notice($page = NULL, $page_size = NULL)
	{
		global $db_prefix;
		
		$sql = "SELECT * FROM {$db_prefix}notice ORDER BY notice_id DESC";
		if($page){
			$start_row = ($page - 1) * $page_size;
			$sql .= " LIMIT $start_row, $page_size";
		}
		else if($page_size){
			$sql .= " LIMIT $page_size";
		}
		
		return db_get_rows($sql);
	}
	
	function db_notice_add_notice($head, $content)
	{
		global $db_prefix;
		
		$sql = "INSERT INTO {$db_prefix}notice";
		return db_insert($sql, array("notice_head"=>$head, "notice_content"=>$content, "date"=>date("Y-m-d")));
	}
	
	function db_notice_del_notice($notice_id)
	{
		global $db_prefix;
		
		$sql = "DELETE FROM {$db_prefix}notice WHERE notice_id = $notice_id";
		return mysql_query($sql);
	}
?>