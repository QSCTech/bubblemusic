<?php
  class page_music{
		public function page_music(&$smarty){
			global $genre_list;
			
			$album_id = isset($_GET["aid"]) ? $_GET["aid"] : NULL;
			$order_by = isset($_GET["ob"]) ? $_GET["ob"] : NULL;
			$key = isset($_GET["key"]) ? $_GET["key"] : NULL;
			$page = isset($_GET["page"]) ? $_GET["page"] : 1;
			$page_size = isset($_GET["page_size"]) ? $_GET["page_size"] : 30;
			
			$orders = array("music_name", "artists_name", "album_name", "genre");
			//排列顺序
			if($order_by){
				$count = 0;
				foreach($orders as $item){
					if($order_by == $item)
						$count++;
				}
				if($count == 0){
					$order_by = NULL;
				}
			}
			
			//处理页数
			$music_num = db_music_get_music_num($album_id);
			if($key){
				$music_num = db_music_search_music_num($key);
			}
			$page_all = ceil($music_num / $page_size);
			$page_prev = ($page > 1) ? $page-1 : 1;
			$page_next = ($page < $page_all) ? $page+1 : $page_all;
			
			//专辑
			if($album_id){
				$music = db_music_get_music4album_id($album_id);
			}
			//搜索
			else if($key){
				$music = db_music_search_music($key,$page, $page_size, $order_by);
			}
			//所有
			else{
				$music = db_music_get_music($page, $page_size, $order_by);
			}
			
			$smarty->assign("music",$music);
			$smarty->assign("aid",$album_id);
			$smarty->assign("keyword",$key);
			$smarty->assign("ob", $order_by);
			$smarty->assign("genres", $genre_list);
			
			$smarty->assign("page", $page); 
			$smarty->assign("page_next", $page_next);
			$smarty->assign("page_prev", $page_prev);
			$smarty->assign("page_all", $page_all);
			$smarty->assign("music_num", $music_num);
		}
	}
?>