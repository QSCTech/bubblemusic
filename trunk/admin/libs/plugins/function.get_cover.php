<?php
   	function smarty_function_get_cover($params)
	{
		if(isset($params["album_id"])){
			$album_id = $params["album_id"];
			$album = db_album_get_album4id($album_id);
			$album_name = $album["album_name"];
			$artists_name = $album["artists_name"];
			$upload_date = db_get_upload_date4album_id($album_id);
			if($upload_date){
				foreach($upload_date as $item)
				{
					$dates = explode("-", $item[0]);
					$yearMonth = $dates[0] . '-' . $dates[1];
					
					if(is_file("../source/$yearMonth/$artists_name - $album_name/cover.jpg")){
						return "../source/$yearMonth/$artists_name - $album_name/cover.jpg";
					}
				}
			}
			return "templates/images/no_cover.jpg";
		}
		else{
			if(is_file($params["path"])){
				return $params["path"];
			}
			else{
				return "templates/images/no_cover.jpg";
			}
		}
	}
?>