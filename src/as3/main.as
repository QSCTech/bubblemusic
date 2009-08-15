/**
 * 主控制类,也是最顶层的类方法,负责统筹调用所有底层类方法
 * 
 */

	import Component.playerSongs;
	import Component.playerSongs2;
	
	import as3.Lyric.LRCDecoder;
	import as3.Net.RPC;
	import as3.PlayControl.playControl;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	//播放控制,音乐播放由这个变量进行控制
	public var musicControl:playControl = new playControl();
	//播放列表的数据存储
	public var playList:Array = new Array();
	//远程数据调用
	public var rpc:RPC = new RPC();
	
	public var lrcLoader:URLLoader = new URLLoader();
	public var LRC:Array = new Array();
	public var lrcnum:int;
	
	[Bindable]
	public var Version:String = "Bubble jay 8.15.r9";
	
	/**
	 *初始化播放列表 
	 * 
	 */	
	public function initPlayList():void{
		
		//以下列表仅用于测试
		rpc.getMusicList(onGetMusicList);
		//playList.push({title:"星之所在",author:"空之轨迹",url:"def.mp3"});
		//playList.push({title:"Plants VS Zombins",author:"Libitum",url:"abc.mp3"});
		//this.syncPlayList(playList);
		//abc.newPlay(playList[0].url,nextMusic);
	}
	
	/**
	 *同步播放列表,当播放列表改动后,同步到播放器界面上 
	 * @param playList
	 * 
	 */	
	private function syncPlayList(list:Array):void{
		var i:int = 0;
		if(musicList.numChildren>1){
			musicList.removeAllChildren();
		}
		
		for(i = 0; i<list.length; i++){
			if(i%2 == 0){
				var song:playerSongs = new playerSongs;
				trace(list[i].title);
				song.text = list[i].title + " - " + list[i].author;
				song.index = i;
				song.doubleClickEnabled = true;
				song.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
				musicList.addChild(song);
			}
			if(i%2 == 1){
				var song2:playerSongs2 = new playerSongs2;
				song2.text = list[i].title + " - " + list[i].author;
				song2.index = i;
				song2.doubleClickEnabled = true;
				song2.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
				musicList.addChild(song2);
			}
		}
	}
	
	/**
	 * 当一首音乐播放完后,执行播放下一首音乐的操作,包括播放列表的同步
	 */
	public function nextMusic(event:Event):void{
		lrcnum = 0;
		LRC.splice(0);
		musicControl.pausePlay();
		playList.shift();
		musicList.removeChildAt(1);
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
	}
	
	/**
	 *当得到播放列表后,执行相应操作 
	 * @param result
	 * 
	 */	
	public function onGetMusicList(result:Array):void{
		this.playList = result;
		this.syncPlayList(playList);
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
	}
	
	
	/**
	 * 当歌词加载完成，开始对歌词进行处理
	 */
	private function lrcLoadCompleteHandler(event:Event):void{
		var str:String = event.target.data;
		LRC = LRCDecoder.decoder(str);
		musicControl.newPlay(playList[0].url,nextMusic);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	/**
	 * 歌词的动态转换
	 */
	private function onEnterFrame(event:Event):void{
		var time:Number = musicControl.channel.position;
		if(lrcnum<LRC.length-1){
			if(time>LRC[lrcnum+1].time){
				lrcnum+=1;
					
				if(LRC[lrcnum-5]){
					lyric.lrc0.text = LRC[lrcnum-5].lrc.toString();
				}
				if(LRC[lrcnum-4]){
					lyric.lrc1.text = LRC[lrcnum-4].lrc.toString();
				}
				if(LRC[lrcnum-3]){
					lyric.lrc2.text = LRC[lrcnum-3].lrc.toString();
				}
				if(LRC[lrcnum-2]){
					lyric.lrc3.text = LRC[lrcnum-2].lrc.toString();
				}
				if(LRC[lrcnum-1]){
					lyric.lrc4.text = LRC[lrcnum-1].lrc.toString();
				}
				
				lyric.lrc5.text = LRC[lrcnum].lrc.toString();
				
				if(LRC[lrcnum+1]){
					lyric.lrc6.text = LRC[lrcnum+1].lrc.toString();
				}
				if(LRC[lrcnum+2]){
					lyric.lrc7.text = LRC[lrcnum+2].lrc.toString();
				}
				if(LRC[lrcnum+3]){
					lyric.lrc8.text = LRC[lrcnum+3].lrc.toString();
				}
				if(LRC[lrcnum+4]){
					lyric.lrc9.text = LRC[lrcnum+4].lrc.toString();
				}
				if(LRC[lrcnum+5]){
					lyric.lrc10.text = LRC[lrcnum+5].lrc.toString();
				}
				
				lyric.LRCeffect.stop();
				lyric.LRCeffect.play();
			}
		}else{
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
	}
	
	/**
	 *播放列表项的鼠标双击事件,当双击某一项时,则播放该项 
	 * @param event 事件源
	 * 
	 */	
	public function doubleClickListItem(event:MouseEvent):void{
		var i:int = event.currentTarget.index;
		for(var j:int = 0; j<i; j++){
			playList.shift();
		}
		this.syncPlayList(playList);
		
		musicControl.newPlay(playList[0].url,nextMusic);
	}

