s<?php 
if (!empty($_FILES)) {
	$tempFile = $_FILES['Filedata']['tmp_name'];
	
	$album_id = $_POST["album_id"];
	$album = db_album_get_album4id($album_id);
	$album_name = $album["album_name"];
	$artists_name = $album["artists_name"];
	$upload_date = db_get_upload_date4album_id($album_id);
	if($upload_date){
		foreach($upload_date as $item)
		{
			$dates = explode("-", $item[0]);
			$yearMonth = $dates[0] . '-' . $dates[1];
			
			if(is_file($targetFile = SOURCE."$yearMonth/$artists_name - $album_name/cover.jpg")){
				unlink($targetFile); 	
			}
			move_uploaded_file($tempFile,$targetFile);
			$json = "var json = {'src':\"$targetFile\"}";
			echo $json;
		}
	}
}
?>