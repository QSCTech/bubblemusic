<?php
class do_logout{
	public function do_logout($smarty){
		setcookie("bubble_sid");
		
		Header("Location:./?action=page_login");
	}
}
?>