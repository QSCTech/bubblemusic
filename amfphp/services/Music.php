<?php
	class Music{
		private $root = "../source/";
		private $root4self = "../../source/";
		private $default_pic = "../source/default.jpg";
		private $default_lrc = "../source/default.lrc";
		
		private $list_num = 12;
		private $page_row = 10;
		private $comment_page_row = 9;
		
		private $db_prefix = "bubble_";
		
		private function db_connect()
		{
			//连接数据库
			$db = mysql_connect('localhost','bubble','bubble');
			mysql_set_charset("utf8",$db);
			if(!$db){
				echo 'mysql connect error';
			}
			mysql_selectdb("bubble");
		}
		
		function getList($music_id = NULL){	
			$this->db_connect();
			
			$num = $this->list_num;
			$count = 0;
			$rows = array();
			if($music_id){
				$id = explode("||", $music_id);
				foreach($id as $item){
					//只返回12首歌曲
					if($count < $this->list_num){
						$query = "SELECT * FROM {$this->db_prefix}music WHERE music_id = $item";
						$result = mysql_query($query);
						//跳过数据库中不存在的歌曲ID
						if(mysql_num_rows($result)){
							$rows[] = mysql_fetch_array($result);
							$count++;
						}
					}
				}
			}
			//当只传一个ID值的时候则只返回一首歌
			//否则返回12首歌，如果不足则补全
			if(count($id)!=1 || !$music_id){
				$num = $this->list_num - $count;
				$query = "SELECT * FROM {$this->db_prefix}music WHERE 1=1 ";
				//排除已经获取的歌曲
				if($music_id){
					foreach($id as $item){
						$query .= " AND music_id <> $item";
					}
				}
				$query .= " ORDER BY rand() LIMIT " . $num;
				$result = mysql_query($query);
				while($row = mysql_fetch_array($result)){
					$rows[] = $row;
				}
			}
			
			$list = NULL;
			foreach($rows as $item){
				$dates = explode("-", $item['upload_date']);
				$yearMonth = $dates[0] . '-' . $dates[1];
				$foo = $this->generateMusicInfo($item);
				
				$list[] = $foo;
			}
			return $list;
		}
		
		function search($key, $value, $page){
			$this->db_connect();
			
			$query = "SELECT * FROM {$this->db_prefix}music WHERE 1 = 1";
			
			//根据歌名来搜索
			if($key == "搜歌名")
			{
				$query .= " AND music_name LIKE '%{$value}%'"; 
			}
			//根据专辑名来搜索
			if($key == "搜专辑")
			{
				$query .= " AND album_name LIKE '%{$value}%'"; 
			}
			//根据歌手名来搜索
			if($key == "搜歌手")
			{
				$query .= " AND artists_name LIKE '%{$value}%'"; 
			}
			//全部
			if($key == "全部搜索")
			{
				$query .= " AND music_name LIKE '%{$value}%' OR album_name LIKE '%{$value}%' OR artists_name LIKE '%{$value}%'";
			}
			//分页显示
			$page = isset($page)?$page : 1;
			$row_start = ($page - 1) * $this->page_row;
			
			$query .= " ORDER BY music_name LIMIT $row_start, " . ($this->page_row+1);
			$result = mysql_query($query);
			
			if(mysql_num_rows($result)){
				$count = 0;
				while($count <= $this->page_row){
					if($row = mysql_fetch_array($result)){
						$dates = explode("-", $row['upload_date']);
						$yearMonth = $dates[0] . '-' . $dates[1];
						$foo = $this->generateMusicInfo($row);
						$list[] = $foo;
					}
					$count++;
				}
			}
			else{
				$list = array();
				$list[0] = array();
			}
			return $list;
		}
		
		function getNextMusic($num = 1){
			$this->db_connect();
			
			$query = "SELECT * FROM {$this->db_prefix}music ORDER BY rand() LIMIT $num";
			$result = mysql_query($query);
			$music = NULL;
			if(mysql_num_rows($result)){
				$row = mysql_fetch_array($result);
				$music = $this->generateMusicInfo($row);
			}
			return $music;
		}
		
		function addComment($music_id, $comment_detail, $user_name = NULL, $user_id = NULL){
			$this->db_connect();
			
			$query = "INSERT INTO {$this->db_prefix}comment SET music_id = $music_id, comment_detail = '$comment_detail'";
			if($user_name){
				if(!$user_id) $user_id = 0;
				$query .= ",user_id = $user_id, user_name = '$user_name'";
			}
			if(mysql_query($query)){
				return $this->getComment($music_id, 1);
			}
		}
		
		function getComment($music_id, $page = 1){
			$this->db_connect();
			$music_id = isset($music_id) ? $music_id : 0;
			
			//分页显示
			$page = isset($page)?$page : 1;
			$row_start = ($page - 1) * $this->comment_page_row;
			$query = "SELECT * FROM {$this->db_prefix}comment WHERE music_id = $music_id ";
			$query .="ORDER BY comment_id DESC LIMIT $row_start, " . ($this->comment_page_row+1);
			
			$result = mysql_query($query);
			while($row = mysql_fetch_array($result)){
				$list[] = array("user"=>$row["user_name"],
								"comment"=>$row["comment_detail"]);
			}
			if(!isset($list)){
				$list = array();
				$list[0] = array();
			}
			return $list;
		}
		
		function getSubject(){
			$this->db_connect();
			
			$query = "SELECT * FROM {$this->db_prefix}subject "
		}
		
		function generateMusicInfo($row){
			$foo = array("id" => $row["music_id"],
						"title" => $row['music_name'], 
						"author"=>$row['artists_name'],  
						"album"=>$row["album_name"],
						//路径格式：上传年月/歌手名 - 专辑名/歌曲名.mp3(lrc)	
						"url"=>$this->root . $yearMonth . "/" . rawurlencode($row['artists_name'] . " - " . $row["album_name"]) . "/" . rawurlencode($row['music_name'].".mp3"), 
						"lrc"=>$this->root . $yearMonth . "/" . rawurlencode($row['artists_name'] . " - " . $row["album_name"]) . "/" . rawurlencode($row['music_name'].".lrc"), 
						"pic"=>$this->root . $yearMonth . "/" . rawurlencode($row['artists_name'] . " - " . $row["album_name"]) . "/" . "cover.jpg");
			
			//如果歌词不存在调用默认歌词
			if(!file_exists($this->root4self . $yearMonth . "/" . $item['artists_name'] . " - " . $item["album_name"] . "/" .$item['music_name'].".lrc")){
				$foo["lrc"] = $this->default_lrc;
			}
			//如果专辑图片不存在，调用专辑图片
			if(!file_exists($this->root4self . $yearMonth . "/" . $item['artists_name'] . " - " . $item["album_name"] . "/" . "cover.jpg")){
				$foo["pic"] = $this->default_pic;
			}
		}
	}
?>