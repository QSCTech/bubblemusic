<?php
	class page_subject{
		public function page_subject($smarty){
			$subject = db_subject_get_subject();
			
			$smarty->assign("subject",$subject);
		}
	}
?>