<?php
	class page_search_mp3{
		public $songs;
		
		public function page_search_mp3(&$smarty){
			global $genre_list;
			
			$this->search(DIR_UPLOAD_TEMP);
			$subjects = db_subject_get_subject();
			
			$smarty->assign("songs", $this->songs);
			$smarty->assign("subjects", $subjects);
			$smarty->assign("genres", $genre_list);	
		}
		
		public function search($dir){
			global $songs;
			
			if (!is_dir($dir)) {
		        return;
		    }
		    if ($dh = opendir($dir)) {
		        while (($file = readdir($dh)) !== false) {
		            if ($file[0] === '.') {
		                continue;
		            }
		            $path = $dir . '/' . $file;
					if (is_dir($path)) {
		                $this->search($path);
		            }
					else{
			            if (substr($file, -4, 4) == '.mp3') {
							//Mp3 ID3的读取
							$id3 = new id3($path);
							//编码转换
							$name = is_utf8($id3->name) ? $id3->name : mb_convert_encoding($id3->name,"UTF-8","GBK");
							$album = is_utf8($id3->album) ? $id3->album : mb_convert_encoding($id3->album,"UTF-8","GBK");
							$artists = is_utf8($id3->artists) ? $id3->artists : mb_convert_encoding($id3->artists,"UTF-8","GBK");
							$name = addslashes($name);
							$album = addslashes($album);
							$artists = addslashes($artists);
							
			            	$path = substr($path, 0, -4);
							$lrc_path = "{$path}.lrc";
							if(!file_exists($lrc_path)){
								$lrc_path = NULL;
							}
							
							$this->songs[] = array("path"=>$path.".mp3", 
											"lrc_path"=>$lrc_path, 
											"name"=>$name, "album"=>$album, 
											"artists"=>$artists, 
											"genre"=>$id3->genre, 
											'genre_id'=>$id3->genreno);
						}
					}
		        }
		        closedir($dh);
		    }
		}
	}
?>