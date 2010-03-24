<?php
class do_login{
	public function do_login($smarty){
	    $user_name = $_POST["user_name"];
		$user_pw = $_POST["user_pw"];
		list($user_id) = uc_user_login($user_name, $user_pw);
		if($user_id > 0){
			session_start();
			$_SESSION["user_id"] = $user_id; 
			setcookie("bubble_sid", session_id(), time()+COOKIE_TIME);
			Header("Location:./?action=page_home");
		}
		else{
			Header("Location:./?action=page_login");
		}
	}
}
?>