<?php
$album_id= $_POST["album_id"];

db_album_del_album($album_id);
if($_POST["del_music"]){
	$music = db_music_get_music4album_id($album_id);
	if($music){
		foreach($music as $item){
			$yearMonth = $yearMonths[] = substr($item["upload_date"], 0, 7);
			$music_name = $item["music_name"];
			$album_name = $item["album_name"];
			$artists_name = $item["artists_name"];
			//删除文件
			$path = SOURCE."$yearMonth/$artists_name - $album_name/$music_name";
			if(is_file($file = $path.".mp3")){
				unlink($file);
				unlink($path.".lrc");
			}
			db_music_del_music4music_id($item["music_id"]);
		}
	}
	
	//删除文件夹
	//考虑同个专辑肯能在不同月份上传
	if(isset($yearMonths)){
		foreach($yearMonths as $item)
		{
			$dir = SOURCE."$item/$artists_name - $album_name";
			//删除专辑图片
			if(is_file($dir."/cover.jpg")){
				unlink($dir."/cover.jpg");
			}
			if(is_dir($dir)){
				rmdir($dir);
			}
		}
	}
}
?>