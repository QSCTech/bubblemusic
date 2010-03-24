<?php
  class page_notice{
		public function page_notice(&$smarty){
			$notice = db_notice_get_notice("", 10);
			$smarty->assign("notice", $notice);
		}
  }
?>