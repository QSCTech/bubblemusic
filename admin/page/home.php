<?php
  class page_home{
		public function page_home($smarty){
			$page = isset($_GET["page"]) ? $_GET["page"] : 1;
			$page_size = isset($_GET["page_size"]) ? $_GET["page_size"] : 15;
			
			//处理页数
			$album_num = db_album_get_album_num();
			
			$page_all = ceil($album_num / $page_size);
			$page_prev = ($page > 1) ? $page-1 : null;
			$page_next = ($page < $page_all) ? $page+1 : null;
			
			$album = db_album_get_album($page, $page_size);
			
			$smarty->assign("album",$album);
			$smarty->assign("page", $page); 
			$smarty->assign("page_next", $page_next);
			$smarty->assign("page_prev", $page_prev);
			$smarty->assign("page_all", $page_all);
			$smarty->assign("album_num", $album_num);
		}
	}
?>