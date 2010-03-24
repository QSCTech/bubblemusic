<?php
class Music {
    private $root = "../source/";
    private $root4self = "../../source/";
    private $default_pic = "../source/default.jpg";
    private $default_lrc = "../source/default.lrc";
    
    private $list_num = 12; //播放列表歌曲个数
    private $page_row = 10; //搜索结果单页显示个数
    private $comment_page_row = 9; //心情单页显示个数
    private $subject_page_row = 10; //专题单页显示个数
    private $subject_music_page_row = 10; //专题歌曲单页显示个数
    
    private $db_prefix = "bubble_";
    
	public function __construct()
	{
		/*
		define('UC_CONNECT', 'mysql');
		define('UC_DBHOST', 'localhost');
		define('UC_DBUSER', 'root');
		define('UC_DBPW', '2736892');
		define('UC_DBNAME', 'ucenter');
		define('UC_DBCHARSET', 'gbk');
		define('UC_DBTABLEPRE', '`ucenter`.uc_');
		define('UC_DBCONNECT', '0');
		define('UC_KEY', '2736892');
		define('UC_API', 'http://localhost/ucenter/upload');
		define('UC_CHARSET', 'gbk');
		define('UC_IP', '');
		define('UC_APPID', '2');
		define('UC_PPP', '20');
		*/
		define('UC_CONNECT', 'mysql');
		define('UC_DBHOST', '10.76.8.41');
		define('UC_DBUSER', 'developer');
		define('UC_DBPW', '4aydEXetPRsYZymn');
		define('UC_DBNAME', 'ucenter');
		define('UC_DBCHARSET', 'utf8');
		define('UC_DBTABLEPRE', '`ucenter`.uc_');
		define('UC_DBCONNECT', '0');
		define('UC_KEY', 'bubble');
		define('UC_API', 'http://10.76.8.41/share/ucenter');
		define('UC_CHARSET', 'utf-8');
		define('UC_IP', '');
		define('UC_APPID', '2');
		define('UC_PPP', '20');
		
		require_once "../client/client.php";
	}
    /**
     * 连接数据库
     */
    private function db_connect() {
        //连接数据库
        $db = mysql_connect('localhost', 'bubble','bubble');
        mysql_set_charset("utf8", $db);
        if (!$db) {
            echo 'mysql connect error';
        }
        mysql_selectdb("bubble");
    }
    
    private function generateMusicInfo($row) {
        $dates = explode("-", $row['upload_date']);
        $yearMonth = $dates[0].'-'.$dates[1];
        $foo = array("id"=>$row["music_id"], "title"=>$row['music_name'], "author"=>$row['artists_name'], "album"=>$row["album_name"],
            //路径格式：上传年月/歌手名 - 专辑名/歌曲名.mp3(lrc)
            "url"=>$this->root.$yearMonth."/".rawurlencode($row['artists_name']." - ".$row["album_name"])."/".rawurlencode($row['music_name'].".mp3"), "lrc"=>$this->root.$yearMonth."/".rawurlencode($row['artists_name']." - ".$row["album_name"])."/".rawurlencode($row['music_name'].".lrc"), "pic"=>$this->root.$yearMonth."/".rawurlencode($row['artists_name']." - ".$row["album_name"])."/"."cover.jpg");
        
        //如果歌词不存在调用默认歌词
        if (!file_exists($this->root4self.$yearMonth."/".$row['artists_name']." - ".$row["album_name"]."/".$row['music_name'].".lrc")) {
            $foo["lrc"] = $this->default_lrc;
        }
        //如果专辑图片不存在，调用专辑图片
        if (!file_exists($this->root4self.$yearMonth."/".$row['artists_name']." - ".$row["album_name"]."/"."cover.jpg")) {
            $foo["pic"] = $this->default_pic;
        }
        
        return $foo;
    }
    
    /**
     * 返回歌曲列表
     * @param 默认为NULL，如果不为NULL，则用'||'连接上次列表歌曲ID。
     * @return {id, title, author, album, url, lrc, pic}
     */
    function getList($music_id = NULL) {
        $this->db_connect();
        
        $num = $this->list_num;
        $count = 0;
        $rows = array();
        if ($music_id) {
            $id = explode("||", $music_id);
            foreach ($id as $item) {
                //只返回12首歌曲
                if ($count < $this->list_num) {
                    $query = "SELECT * FROM {$this->db_prefix}music WHERE music_id = $item";
                    $result = mysql_query($query);
                    //跳过数据库中不存在的歌曲ID
                    if (mysql_num_rows($result)) {
                        $rows[] = mysql_fetch_array($result);
                        $count++;
                    }
                }
            }
        }
        //当只传一个ID值的时候则只返回一首歌
        //否则返回12首歌，如果不足则补全
        if (count($id) != 1 || !$music_id) {
            $num = $this->list_num - $count;
            $query = "SELECT * FROM {$this->db_prefix}music WHERE 1=1 ";
            //排除已经获取的歌曲
            if ($music_id) {
                foreach ($id as $item) {
                    $query .= " AND music_id <> $item";
                }
            }
            $query .= " ORDER BY rand() LIMIT ".$num;
            $result = mysql_query($query);
            while ($row = mysql_fetch_array($result)) {
                $rows[] = $row;
            }
        }
        
        $list = NULL;
        foreach ($rows as $item) {
            $list[] = $this->generateMusicInfo($item);
        }
        return $list;
    }
    
    /**
     * 搜索歌曲返回歌曲列表
     * @param 搜索类型，有'搜歌名'，'搜专辑'，'搜歌手'和'全部搜索'。
     * @param 搜索关键字。
     * @param 搜索显示分页的当前页数
     * @return {id, title, author, album, url, lrc, pic}
     */
    function search($key, $value, $page) {
        $this->db_connect();
        
        $query = "SELECT * FROM {$this->db_prefix}music WHERE 1 = 1";
		//搜索类型
		$type = 0;
        
        //根据歌名来搜索
        if ($key == "搜歌名") {
            $query .= " AND music_name LIKE '%{$value}%'";
			$type = 1;
        }
        //根据专辑名来搜索
        if ($key == "搜专辑") {
            $query .= " AND album_name LIKE '%{$value}%'";
			$type = 2;
        }
        //根据歌手名来搜索
        if ($key == "搜歌手") {
            $query .= " AND artists_name LIKE '%{$value}%'";
			$type = 3;
        }
        //全部
        if ($key == "全部搜索") {
            $query .= " AND music_name LIKE '%{$value}%' OR album_name LIKE '%{$value}%' OR artists_name LIKE '%{$value}%'";
			$type = 4;
		}
        //分页显示
        $page = isset($page) ? $page : 1;
        $row_start = ($page - 1) * $this->page_row;
        
        $query .= " ORDER BY music_name LIMIT $row_start, ".($this->page_row + 1);
        $result = mysql_query($query);
        
        $count = 0;
        if (mysql_num_rows($result)) {
            while ($count <= $this->page_row) {
                if ($row = mysql_fetch_array($result)) {
                    $list[] = $this->generateMusicInfo($row);
                }
                $count++;
            }
        } else {
            $list = array();
            $list[0] = array();
        }
		//插入搜索记录
		if($page <= 1 && $type){
			$date = date("Y-m-d");
			$query = "INSERT INTO {$this->db_prefix}user_search SET user_id = 0, search_keyword = \"$value\", search_result = $count, search_date=\"$date\", search_type=$type";
			mysql_query($query);
		}
        return $list;
    }
    
    /**
     * 随机获取下一首歌曲
     * @param 需要获取的歌曲数量。
     * @return {id, title, author, album, url, lrc, pic}
     */
    function getNextMusic($num = 1) {
        $this->db_connect();
        
        $query = "SELECT * FROM {$this->db_prefix}music ORDER BY rand() LIMIT $num";
        $result = mysql_query($query);
        $music = NULL;
        if (mysql_num_rows($result)) {
            $row = mysql_fetch_array($result);
            $music = $this->generateMusicInfo($row);
        }
        return $music;
    }
    
    /**
     * 添加评论
     * @param 需要添加评论的歌曲ID。
     * @param 评论的内容。
     * @param 评论的用户昵称。
     * @return {user, comment}
     */
    function addComment($music_id, $comment_detail, $user_name = NULL) {
        $this->db_connect();
        
        $query = "INSERT INTO {$this->db_prefix}comment SET music_id = $music_id, comment_detail = '$comment_detail'";
        if ($user_name) {
            $query .= ",user_id = 0, user_name = '$user_name'";
        }
        if (mysql_query($query)) {
            return $this->getComment($music_id, 1);
        }
    }
    /**
     * 获取评论
     * @param 需要获取评论的音乐ID。
     * @param 当前页码
     * @return {user, comment}
     */
    function getComment($music_id, $page = 1) {
        $this->db_connect();
        $music_id = isset($music_id) ? $music_id : 0;
        
        //分页显示
        $page = isset($page) ? $page : 1;
        $row_start = ($page - 1) * $this->comment_page_row;
        $query = "SELECT * FROM {$this->db_prefix}comment WHERE music_id = $music_id ";
        $query .= "ORDER BY comment_id DESC LIMIT $row_start, ".($this->comment_page_row + 1);
        
        $result = mysql_query($query);
        while ($row = mysql_fetch_array($result)) {
            $list[] = array("user"=>$row["user_name"], "comment"=>$row["comment_detail"]);
        }
        if (!isset($list)) {
            $list = array();
            $list[0] = array();
        }
        return $list;
    }
    /**
     * 获取专题
     * @param 当前页码
     * @return {id, name, description, image}
     */
    function getSubject($page) {
        $this->db_connect();
        //分页显示
        $page = isset($page) ? $page : 1;
        $row_start = ($page - 1) * $this->subject_page_row;
        
        $query = "SELECT * FROM {$this->db_prefix}subject LIMIT $row_start, ".($this->subject_page_row + 1);
        
        $result = mysql_query($query);
        while ($row = mysql_fetch_array($result)) {
            $list[] = array("id"=>$row["subject_id"], "name"=>$row["subject_name"], "description"=>$row["description"], "image"=>$row["image_file"]);
        }
        if (!isset($list)) {
            $list = array();
            $list[0] = array();
        }
        return $list;
    }
    /**
     * 获取专题的歌曲
     * @param 专题ID
     * @param 当前页码
     * @return {Array} {id, title, author, album, url, lrc, pic}
     */
    function getSubjectMusic($subject_id, $page = NULL) {
        $this->db_connect();
        
        $query = "SELECT * FROM {$this->db_prefix}music as m, {$this->db_prefix}subject_music as sm 
				WHERE m.music_id = sm.music_id AND sm.subject_id = '$subject_id'";
        if ($page) {
            //分页显示
            $page = isset($page) ? $page : 1;
            $row_start = ($page - 1) * $this->comment_page_row;
            $query .= " ORDER BY m.music_id DESC LIMIT $row_start, ".($this->subject_music_page_row + 1);
        }
        $result = mysql_query($query);
        while ($row = mysql_fetch_array($result)) {
            $list[] = $this->generateMusicInfo($row);
        }
        if (!isset($list)) {
            $list = array();
            $list[0] = array();
        }
        return $list;
    }
    /**
     * 用户登录
     * @param 用户名
     * @param 用户密码
     * @return 登录成功返回{user_id, user_name, user_pw} 
     * 			大于 0:返回用户 ID，表示用户登录成功
	 *			-1:用户不存在，或者被删除
	 *			-2:密码错
	 *			-3:安全提问错
     */
    function login($user_name, $user_pw) {
        $this->db_connect();
        
		list($user_id, $user_name, $user_pw, $user_pw) = uc_user_login($user_name, $user_pw);
		$user_info = array("user_id"=>$user_id, "user_name"=>$user_name, "user_pw"=>$user_pw);
		return $user_info["user_id"];
    }
	/**
	 * 用户注册
	 * @param 用户名
	 * @param 用户密码
	 * @param 用户邮箱
	 * @return 大于 0:返回用户 ID，表示用户注册成功
	 *			-1:用户名不合法
	 *			-2:包含不允许注册的词语
	 *			-3:用户名已经存在
	 *			-4:Email 格式有误
	 *			-5:Email 不允许注册
	 *			-6:该 Email 已经被注册
	 */
	function register($user_name, $user_pw, $user_em){
		return uc_user_register($user_name, $user_pw, $user_em);
	}
	/**
     * 创建播放列表
     * @param 用户ID
     * @param 播放列表名称
     * @return 播放列表ID
     */
	function createPlaylist($user_id, $playlist_name){
		$this->db_connect();
		
		$query = "INSERT INTO {$this->db_prefix}playlist SET user_id = $user_id, playlist_name = '$playlist_name'";
		if(mysql_query($query))
			return mysql_insert_id();
		return FALSE;
	}
	/**
     * 创建播放列表
     * @param 播放列表ID
     * @param 歌曲ID
     */
	function addPlaylistMusic($playlist_id, $music_id){
		$this->db_connect();
		
		$query = "INSERT INTO {$this->db_prefix}playlist_music SET music_id = $music_id, playlist_id = $playlist_id";
		if(mysql_query($query))
			return TRUE;
		return FALSE;
	}
	/**
     * 获取播放列表
     * @param 用户ID
     * @return {playlist_id, playlist_name}
     */
	function getPlaylist($user_id){
		$this->db_connect();
		
		$query = "SELECT * FROM {$this->db_prefix}playlist WHERE user_id = $user_id";
		$result = mysql_query($query);
		if(mysql_num_rows($result)){
			while($row = mysql_fetch_array($result)){
				$list[] = $row;
			}
			return $list;
		}
		return FALSE;
	}
	/**
     * 获取播放列表歌曲
     * @param 用户ID
     * @return {id, title, author, album, url, lrc, pic}
     */
	function getPlaylistMusic($playlist_id){
		$this->db_connect();
		
		$query = "SELECT * FROM {$this->db_prefix}playlist_music as pm, {$this->db_prefix}music as m 
				WHERE pm.music_id = m.music_id AND pm.playlist_id =  $playlist_id";
		$result = mysql_query($query);
		
		if(mysql_num_rows($result)){
			while($row = mysql_fetch_array($result)){
				$list[] = $this->generateMusicInfo($row);
			}
			return $list;
		}
		return FALSE;
	}
	/**
     * 获取通知
     * @return notice_content
     */
	function getNotice(){
		$this->db_connect();
		$query = "SELECT * FROM {$this->db_prefix}notice ORDER BY notice_id DESC LIMIT 1";
		$result = mysql_query($query);
		
		if(mysql_num_rows($result)){
			$row = mysql_fetch_array($result);
			return $row["notice_content"];
		}
		return FALSE;
	}
	/**
     * 添加关注歌手
     * @param 用户ID
     * @param 歌手ID
     * @return 1 添加成功
     * 			0 已经收藏该歌手 
     */
	function addUserSubscribe($user_id, $artists_id){
		$this->db_connect();
		if($this->getSubscribe($user_id, $artists_id)){
			return FALSE;
		}
		$query = "INSERT INTO {$this->db_prefix}user_subscribe SET user_id = $user_id, artists_id = $artists_id";
		if(mysql_query($query))
			return TRUE;
	}
	/**
     * 获取关注歌手
     * @param 用户ID  可以为空，不为空时获取该用户所关注的歌手
     * @param 歌手ID  可以为空，不为空时获取关注该歌手的用户
     * @return {user_id, artists_id}
     */
	function getSubscribe($user_id = NULL, $artists_id = NULL){
		$this->db_connect();
		$query = "SELECT * FROM {$this->db_prefix}user_subscribe WHERE 1 = 1";
		if($user_id){
			$query .= " AND user_id = $user_id";
		}
		if($artists_id){
			$query .= " AND artists_id = $artists_id";
		}
		
		$result = mysql_query($query);
		
		
		if(mysql_num_rows($result)){
			while($row = mysql_fetch_array($result)){
				$list[] = $row;
			}
			return $list;
		}
		return FALSE;
	}
	/**
     * 添加收藏
     * @param 用户ID
     * @param 歌曲ID
     * @return 1 添加成功
     * 			0 添加失败（已添加）
     */
	function addFavourite($user_id, $music_id)
	{
		$this->db_connect();
		
		if($this->getFavourite($user_id, $music_id)){
			return FALSE;
		}
		
		$query = "INSERT INTO {$this->db_prefix}favourite SET user_id = $user_id, music_id = $music_id";
		if(mysql_query($query))
			return TRUE;
	}
	/**
     * 获取用户收藏
     * @param 用户ID
     * @param 歌曲ID 默认为空
     * @return {id, title, author, album, url, lrc, pic}
     */
	function getFavourite($user_id, $music_id = NULL)
	{
		$this->db_connect();
		
		$query = "SELECT * FROM {$this->db_prefix}favourite as f, {$this->db_prefix}music as m WHERE f.music_id = m.music_id AND f.user_id = $user_id";
		if($music_id){
			$query .= " AND m.music_id = $music_id";
		}
		$result = mysql_query($query);
		if(mysql_num_rows($result)){
			while($row = mysql_fetch_array($result)){
				$list[] = $this->generateMusicInfo($row);
			}
			return $list;
		}
		return FALSE;
	}
}

?>
