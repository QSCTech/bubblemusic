<?php
  class do_add_notice{
		public function do_add_notice($smarty){
			$notice_head = $_POST["notice_head"];
			$notice_content = $_POST["notice_content"];
			
			db_notice_add_notice($notice_head, $notice_content);
			
			Header("Location:./?action=page_notice");
		}
	}
?>