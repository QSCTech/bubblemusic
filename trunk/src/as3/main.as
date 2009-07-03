/**
 * 主控制类,也是最顶层的类方法,负责统筹调用所有底层类方法
 * 
 */

	import Component.playerSongs;
	import Component.playerSongs2;
	import as3.PlayControl.playControl;
	
	import flash.events.Event;
	
	//播放控制,音乐播放由这个变量进行控制
	public var abc:playControl = new playControl();
	//播放列表的数据存储
	public var playList:Array = new Array();
	
	
	/**
	 *初始化播放列表 
	 * 
	 */	
	public function initPlayList():void{
		
		//以下列表仅用于测试
		playList.push({title:"星之所在",author:"空之轨迹",url:"def.mp3"});
		playList.push({title:"Plants VS Zombins",author:"Libitum",url:"abc.mp3"});
		this.syncPlayList(playList);
		abc.newPlay(playList[0].url,nextMusic);
	}
	
	/**
	 *同步播放列表,当播放列表改动后,同步到播放器界面上 
	 * @param playList
	 * 
	 */	
	private function syncPlayList(list:Array):void{
		for(var i:int = 0; i<list.length; i++){
			if(i%2 == 0){
				var song:playerSongs = new playerSongs;
				trace(list[i].title);
				song.text = list[i].title + " - " + list[i].author
				musicList.addChild(song);
			}
			if(i%2 == 1){
				var song2:playerSongs2 = new playerSongs2;
				song2.text = list[i].title + " - " + list[i].author;
				musicList.addChild(song2);
			}
		}
	}
	
	/**
	 * 当一首音乐播放完后,执行播放下一首音乐的操作,包括播放列表的同步
	 */
	public function nextMusic(event:Event):void{
		abc.pausePlay();
		abc.newPlay(playList[1].url,nextMusic);
	}

