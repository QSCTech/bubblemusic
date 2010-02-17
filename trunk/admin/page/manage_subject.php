<?php
	class page_manage_subject{
		public function page_manage_subject($smarty){
			$subject_id = isset($_GET["sid"]) ? $_GET["sid"] : 0;
			
			$subject = db_subject_get_subject4subject_id($subject_id);
			
			$page_size = 20;
			$music_num = db_music_get_music_num();
			$page_all = ceil($music_num / $page_size);
			$music = db_music_get_music(1, $page_size);
			
			$subject_music = db_subject_get_music4subject_id($subject_id);
			
			$smarty->assign("subject",$subject);
			$smarty->assign("subject_id",$subject_id);
			$smarty->assign("music",$music);
			$smarty->assign("music_num", $music_num);
			$smarty->assign("page_all",$page_all);
			$smarty->assign("subject_music",$subject_music);
		}
	}
?>