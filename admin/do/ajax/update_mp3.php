<?php
    $music_id = $_POST["music_id"];
	$music_name = $_POST["music_name"];
	$artists_name = $_POST["artists_name"];
	$album_name = $_POST["album_name"];
	$genre = $_POST["genre"];
	
	$old_path = get_path4music_id($music_id);
	//$music = db_music_get_music4music_id($music_id);
	db_music_update_music(array("music_name"=>$music_name, "genre"=>$genre), $music_id);
	/*
	db_album_update_album(array("album_name"=>$album_name), $music["album_id"]);
	db_artists_update_artists(array("artists_name"=>$artists_name), $music["artists_id"]);
	
	$musics = db_music_get_music4album_id($music["album_id"]);
	foreach($musics as $key=>$item){
		db_music_update_music(array("album_name"=>$album_name, "artists_name"=>$artists_name), $item["music_id"]);
	}
	*/
	//重命名文件
	$new_path = get_path4music_id($music_id);
	rename($old_path["mp3"], $new_path["mp3"]);
	//修改id3
	$id3 = new id3($new_path["mp3"]);
	$id3->name = $music_name;
	$id3->genreno = $genre;
	$id3->genre = $genre_list[$genre];
	$id3->write();
?>