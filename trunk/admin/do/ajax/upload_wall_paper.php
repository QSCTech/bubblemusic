<?php
if (!empty($_FILES)) {
	$user_id = $_POST["user_id"];
	$tempFile = $_FILES['Filedata']['tmp_name'];
	
	$sid = getSID();
	while(file_exists(PATH_PICTURE."$sid")){
		$sid = getSID();
	}
	$targetFile = PATH_PICTURE."$sid";
	move_uploaded_file($_FILES["Filedata"]["tmp_name"], $targetFile);
	//更新数据库
	//db_subject_update_subject_cover($subject_id, $targetFile);
	echo  "var json = {'src':\"$targetFile\"}";
}
?>