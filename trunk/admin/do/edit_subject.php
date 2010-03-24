<?php
  class do_edit_subject{
		public function do_edit_subject($smarty){
			$subject_id = $_POST["subject_id"];
			$subject_name = $_POST["subject_name"];
			$description = $_POST["description"];
			$description = $description ? $description : "暂无描述";
			
			db_subject_update_subject($subject_id, array("subject_name"=>$subject_name, "description"=>$description));

			Header("Location:./?action=page_manage_subject&sid=$subject_id");
		}
	}
?>