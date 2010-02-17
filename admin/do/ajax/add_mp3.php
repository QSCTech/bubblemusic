<?php
	$path = $_POST["path"];
	$lrc_path = $_POST["lrc_path"];
	$name = $_POST["name"];
	$album = $_POST["album"];
	$artists = $_POST["artists"];
	$genre = $_POST["genre"];
	
	$yearMonth = date("Y-m");
	$date = date("Y-m-d");
	
	//查询是否已有歌手
	if(!$result = db_artists_get_artists4name($artists)){
		$artists_id = db_artists_add_artists(array("artists_name"=>$artists));
	}
	else{
		$artists_id = $result[0]["artists_id"];
	}
	//查询是否是已有专辑
	if(!$result = db_album_get_album4name($album, $artists)){
		$album_id = db_album_add_album(array("album_name"=>$album, "artists_id"=>$artists_id, "artists_name"=>$artists));
	}
	else{
		$album_id = $result[0]["album_id"];
	}
	//插入歌曲
	$music_id = db_music_add_music(array("music_name"=>$name,
										"album_id"=>$album_id,
										"album_name"=>$album,
										"artists_id"=>$artists_id,
										"artists_name"=>$artists,
										"genre"=>$genre,
										"upload_date"=>$date
									));	
									
	//创建文件夹	
	//路径格式：上传年月/歌手名 - 专辑名/歌曲session值.mp3	
	if(!is_dir(DIR_TARGET.$yearMonth)){
		//按上传年月建立文件夹
		mkdir(DIR_TARGET.$yearMonth);
		mkdir(DIR_TARGET.$yearMonth."/$artists - $album");
	}
	if(!is_dir(DIR_TARGET.$yearMonth."/$artists - $album")){
		//按专辑名建立文件夹
		mkdir(DIR_TARGET.$yearMonth."/$artists - $album");
	}
	$path_target = DIR_TARGET.$yearMonth."/$artists - $album";
	
	//移动音乐
	rename($path, "$path_target/$name.mp3");
	//移动歌词文件
	if(file_exists($lrc_path)){
		//获取歌词
		$lyric = file_get_contents($lrc_path);
		//转换歌词编码
		$lyric = is_utf8($lyric) ? $lyric : mb_convert_encoding($lyric,"UTF-8","GBK");
		//写入文件
		file_put_contents("$path_target/$name.lrc", $lyric);
		unlink($lrc_path);
	}
	//移动专辑图片
	if(!file_exists("{$path_target}/cover.jpg")){
		copy_cover(DIR_UPLOAD_TEMP, "$album.jpg", "{$path_target}/cover.jpg");
	}
?>