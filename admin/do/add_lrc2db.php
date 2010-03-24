<?php
  class do_add_lrc2db{
		public function do_add_lrc2db($smarty){
			$music = db_music_get_music();
			$count = 0;
			$count2 = 0;
			foreach($music as $item){
				$path = get_path4music_id($item["music_id"]);
				if(file_exists($path["lrc"])){
					$lyric = file_get_contents($path["lrc"]);
					db_music_update_lyric($item["music_id"], $lyric);
					$count2++;
				}
				$count++;
			}
			echo $count."<br />";
			echo $count2;
		}
  }
?>