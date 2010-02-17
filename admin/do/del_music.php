<?php
  class do_del_music{
		public function do_del_music($smarty){
			$music = $_POST["music"];
			foreach($music as $item){
				db_music_del_music4music_id($item);
				//删除文件
				$path = $_POST["path_$item"];
				if(is_file($path.".mp3")){
					unlink($path.".mp3");
					unlink($path.".lrc");
				}
			}
			Header("Location:./?action=page_music&page={$_POST['page']}&ltype={$_POST['list_type']}&ob={$_POST['order_by']}");
		}
	}
?>