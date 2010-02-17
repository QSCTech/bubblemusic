<?php
if (!empty($_FILES)) {
	$tempFile = $_FILES['Filedata']['tmp_name'];
	
	$music_id = $_POST["music_id"];
	$path = get_path4music_id($music_id);
	
	if(is_file($path["lrc"])){
		unlink($path["lrc"]);
	}
	move_uploaded_file($tempFile, $path["lrc"]);
	echo "var json={lrc_path:'{$path['lrc']}'}";
}
?>