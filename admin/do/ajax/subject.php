<?php
	switch($_POST["operation"]){
		case "add":
			$music_id = $_POST["music_id"];
			$subject_id = $_POST["subject_id"];
			db_subject_add_music2subject($music_id, $subject_id);
			break;
		case "remove":
			$music_id = $_POST["music_id"];
			$subject_id = $_POST["subject_id"];
			db_subject_remove_subject_music($subject_id, $music_id);
			break;
		case "search":
			$key = $_POST["key"];
			exit(search_music($key));
			break;
		case "get_music":
			$page = $_POST["page"];
			$page_size = $_POST["page_size"];
			exit(get_music($page, $page_size));
			break;
		case "upload":
			$subject_id = $_POST["subject_id"];
			exit(upload($subject_id, $_FILES));
			break;
		case "delete":
			$subject_id = $_POST["subject_id"];
			delete($subject_id);
	}
	
	function search_music($key){
		$max_num = 20;
		
		$music_num = db_music_search_music_num($key);
		$music = db_music_search_music($key,0,$max_num);
		
		$html = "";
		if($music){
			foreach($music as $key => $item){
				$html .= generate_html($item);
			}
			if($music_num > $max_num){
				$html .= "<li><p class='info'>共有{$music_num}个搜索结果</p></li>";
			}
		}
		else{
			$html = "<li><p class='info'>没有你要的音乐啊</p></li>";
		}
		
		return $html;
	}
	
	function get_music($page, $page_size)
	{
		$music = db_music_get_music($page, $page_size);
		$html = "";
		if($music){
			foreach($music as $key => $item){
				$html .= generate_html($item, $key);
			}
		}
		
		return $html;
	}
	
	function generate_html($music, $key = NULL)
	{
		$style = $key%2;
		$music_id = $music['music_id'];
		$music_name = $music['music_name'];
		$album_name = $music['album_name'];
		$artists_name = $music['artists_name'];
		
		return "<li class='tr_style_{$style}' id='{$music_id}_music'>
						<h3>{$music_name}</h3>
						<span>- {$album_name} - {$artists_name}</span>
						<img src='templates/images/subject_add_music.png' title='添加这首歌到专题'/>
				</li>";
	}
	
	function upload($subject_id, $_FILES){
		if (!empty($_FILES)) {
			$tempFile = $_FILES['Filedata']['tmp_name'];
			
			$sid = getSID();
			while(file_exists(PATH_PICTURE."$sid")){
				$sid = getSID();
			}
			$targetFile = PATH_PICTURE."$sid";
			move_uploaded_file($_FILES["Filedata"]["tmp_name"], $targetFile);
			//更新数据库
			db_subject_update_subject_cover($subject_id, $targetFile);
			
			return  "var json = {'src':\"$targetFile\"}";
		}
	}
	
	function delete($subject_id){
		db_subject_del_subject($subject_id);
		db_subject_remove_subject_music($subject_id);
	}
?>