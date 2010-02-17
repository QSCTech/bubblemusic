<?php
  class do_add_subject{
		public function do_add_subject($smarty){
			$subject_name = $_POST["subject_name"];
			
			if($_FILES["image_file"]["name"]){
				$sid = getSID();
				while(file_exists(PATH_PICTURE."$sid")){
					$sid = getSID();
				}
				move_uploaded_file($_FILES["image_file"]["tmp_name"], PATH_PICTURE."$sid");
				
				$subject_id = db_subject_add_subject(array("subject_name"=>$subject_name, "image_file"=>PATH_PICTURE."$sid"));
			}
			else{
				$subject_id = db_subject_add_subject(array("subject_name"=>$subject_name));
			}
			Header("Location:./?action=page_subject&sid=$subject_id");
		}
	}
?>