<?php
	function db_get_rows($sql)
	{
		$rows = array();
		$count = 0;
		$result = mysql_query($sql);
		if(!$result){
			exit("<b>MySql Error:</b>".$sql);
		}
		if(mysql_num_rows($result)){
			while($row = mysql_fetch_array($result)){
				foreach($row as $key=>$item){
					$row[$key] = stripslashes($item);
				}
				$rows[$count] = $row;
				$count++;
			}
		}
		else{
			return false;
		}
		return $rows;
	}
	
	function db_get_one($sql)
	{
		$rows = array();
		$result = mysql_query($sql);
		if(!$result){
			exit("<b>MySql Error:</b>".$sql);
		}
		if(mysql_num_rows($result)){
			$row = mysql_fetch_array($result);
			foreach($row as $key=>$item){
				$row[$key] = stripslashes($item);
			}
		}
		else{
			return false;
		}
		return $row;
	}
	
	function db_insert($sql, $value)
	{
		$count = 0;
		foreach($value as $key=>$item){
			$item = addslashes($item);
			if($count == 0){
				$sql .= " SET $key = \"$item\"";
			}
			else{
				$sql .= ",$key = \"$item\"";
			}
			$count++;
		}
		if(mysql_query($sql)){
			return mysql_insert_id();
		}
		return false;
	}
	
	function db_update($sql, $value, $where)
	{
		$count = 0;
		foreach($value as $key=>$item){
			$item = addslashes($item);
			if($count == 0){
				$sql .= " SET $key = \"$item\"";
			}
			else{
				$sql .= ",$key = \"$item\"";
			}
			$count++;
		}
		$count = 0;
		foreach($where as $key=>$item){
			$item = addslashes($item);
			if($count == 0){
				$sql .= " WHERE $key = \"$item\"";
			}
			else{
				$sql .= " AND $key = \"$item\"";
			}
			$count++;
		}
		if(mysql_query($sql)){
			return true;
		}
		return false;
	}