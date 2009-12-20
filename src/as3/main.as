/**
 * 主控制类,也是最顶层的类方法,负责统筹调用所有底层类方法
 * 
 */

	import as3.Lyric.LRCDecoder;
	import as3.Net.RPC;
	import as3.PlayControl.playControl;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.events.SliderEvent;
	
	
            
            
            
	//播放控制,音乐播放由这个变量进行控制
	public static var musicControl:playControl = new playControl();
	//播放列表的数据存储
	public var playList:Array = new Array();
	//远程数据调用
	public var searchResult:Array = new Array();
	//远程数据调用
	public var rpc:RPC = new RPC();
	
	public var lrcLoader:URLLoader = new URLLoader();
	public var LRC:Array = new Array();
	public var lrcnum:int;
	public var timer:Timer;
	
	[Bindable]
	public var Version:String = "Bubble jay 10.9.r24";
	
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
		musicControl.setNextMusic( this.nextMusic);
		playerTop.next.addEventListener(MouseEvent.CLICK,nextMusic);
		playerTop.playandpause.addEventListener(MouseEvent.CLICK,pauseAndPlay);
		playerTop.volume.addEventListener(SliderEvent.CHANGE,changeVolume);
		playerTop.resetList.addEventListener(MouseEvent.CLICK,resetList);
		
		top.searchBtn.addEventListener(MouseEvent.CLICK,searchShow);

		bottom.lyricBtn.addEventListener(MouseEvent.CLICK,lyricShow);
		
		
		
		
		//那么多监听事件。。。能不能合并？。。。循环？。。。
		musicList.l1.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l1.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l2.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l2.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l3.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l3.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l4.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l4.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l5.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l5.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l6.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l6.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l7.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l7.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l8.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l8.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l9.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l9.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l10.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l10.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l11.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l11.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		musicList.l12.addEventListener(MouseEvent.ROLL_OVER,addMusicBtn);
		musicList.l12.addEventListener(MouseEvent.ROLL_OUT,removeMusicBtn);
		
		musicList.l1.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l2.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l3.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l4.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l5.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l6.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l7.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l8.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l9.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l10.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l11.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		musicList.l12.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickListItem);
		/*
		searchList.s1.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s1.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s2.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s2.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s3.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s3.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s4.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s4.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s5.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s5.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s6.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s6.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s7.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s7.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s8.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s8.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s9.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s9.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		searchList.s10.addEventListener(MouseEvent.ROLL_OVER,addSearchTextBtn);
		searchList.s10.addEventListener(MouseEvent.ROLL_OUT,removeSearchTextBtn);
		
	    searchList.nextBtn.addEventListener(MouseEvent.CLICK,nextSearchPage);
	    searchList.preBtn.addEventListener(MouseEvent.CLICK,preSearchPage);
	    */
	    
	    bottom.nowAlbum.addEventListener(MouseEvent.CLICK,albumSearch);
	    bottom.nowAuthor.addEventListener(MouseEvent.CLICK,authorSearch);
	    bottom.nowMusic.addEventListener(MouseEvent.CLICK,songSearch);
	}
	
	
	/**
	 *同步播放列表,当播放列表改动后,同步到播放器界面上 
	 * @param playList
	 * 
	 */	
	private function syncPlayList(list:Array):void{
		
		playerTop.songLabel.text = list[0].title;
		playerTop.playerLabel.text = list[0].author;
        playerTop.albumLabel.text = list[0].album;
        
		if(list[0]){
			musicList.l1.text = list[0].title + " - " + list[0].author;
		} else { musicList.l1.text = ""; }
		if(list[1]){
			musicList.l2.text = list[1].title + " - " + list[1].author;
		} else { musicList.l2.text = ""; }
		if(list[2]){
			musicList.l3.text = list[2].title + " - " + list[2].author;
		} else { musicList.l3.text = ""; }
		if(list[3]){
			musicList.l4.text = list[3].title + " - " + list[3].author;
		} else { musicList.l4.text = ""; }
		if(list[4]){
			musicList.l5.text = list[4].title + " - " + list[4].author;
		} else { musicList.l5.text = ""; }
		if(list[5]){
			musicList.l6.text = list[5].title + " - " + list[5].author;
		} else { musicList.l6.text = ""; }
		if(list[6]){
			musicList.l7.text = list[6].title + " - " + list[6].author;
		} else { musicList.l7.text = ""; }
		if(list[7]){
			musicList.l8.text = list[7].title + " - " + list[7].author;
		} else { musicList.l8.text = ""; }
		if(list[8]){
			musicList.l9.text = list[8].title + " - " + list[8].author;
		} else { musicList.l9.text = ""; }
		if(list[9]){
			musicList.l10.text = list[9].title + " - " + list[9].author;
		} else { musicList.l10.text = ""; }
		if(list[10]){
			musicList.l11.text = list[10].title + " - " + list[10].author;
		} else { musicList.l11.text = ""; }
		if(list[11]){
			musicList.l12.text = list[11].title + " - " + list[11].author;
		} else { musicList.l12.text = ""; }
	}
	
	/**
	 * 当一首音乐播放完后,执行播放下一首音乐的操作,包括播放列表的同步
	 */
	public function nextMusic(event:Event):void{
		lrcnum = 0;
		LRC.splice(0,LRC.length);
		musicControl.pausePlay();
		playList.shift();
		this.syncPlayList(playList);
		musicList.listEffect.play();
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
		lyric.picture.source = playList[0].pic;
		lyric.reflectorPic.target = lyric.picture;
		LRC = LRCDecoder.decoder(str);
		musicControl.newPlay(playList[0].url);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		this.syncMusicInfo(playList[0].title, playList[0].author ,playList[0].author);
	}
	
	/**
	 * 歌词的动态转换
	 */
	private function onEnterFrame(event:Event):void{
		var time:Number = musicControl.channel.position;
		var a:int = time/1000;
		var b:int = 0;
		var c:int;
		if(a/60>0){
			b=a/60;
			c=a%60;
		}
		if(c<10){
			playerTop.time.text = b + ":0" + c;
		}
		else{
			playerTop.time.text = b + ":" + c;
		}
		
		musicControl.progressSet();
		playerTop.songpos.setProgress(musicControl.progressPos,1);
		
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
		for(var j:int = 1; j<i; j++){
			playList.shift();
		}
		this.syncPlayList(playList);
		musicList.listEffect.play();
		lrcnum = 0;
		LRC.splice(0,LRC.length);
		musicControl.pausePlay();
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
	}
	
	
	/**
	 * 播放&暂停按钮
	 */
	public function pauseAndPlay(event:Event):void{
		if(musicControl.isPlay){
			timer = new Timer(100,20);
			timer.addEventListener(TimerEvent.TIMER,fadeVolume); 
			timer.start();
			musicControl.fadeSound();
			musicControl.pausePlay();
			playerTop.playandpause.styleName = "buttomPlay";
			
		} else {
			musicControl.pursuePlay();
			playerTop.playandpause.styleName = "buttomPause";
		}
	}
	
	/**
	 * 改变音量大小
	 */
	public function changeVolume(event:Event):void{
		musicControl.changeSoundSize(playerTop.volume.value);
	}
	
	/**
	 * 按暂停后，音乐淡出——！！没有用。。。
	 */
	public function fadeVolume(event:Event):void{
		musicControl.fadeSound();
	}
	
	/**
	 * 重置播放列表
	 */
	public function resetList(event:Event):void{
		rpc.getMusicList(onGetMusicList);
		musicControl.setNextMusic(this.nextMusic);
	}
	
	/**
	 * 显示歌词组件
	 */
	public function lyricShow(event:Event):void{
		currentState = "lyricState";
		//top.currentState = "logined";
	}
	
	/**
	 * 显示搜索结果
	 */
	public function searchShow(event:Event):void{
		
		if(top.searchTarget.text!=""){
			rpc.getSearchList(onGetSearchList,top.searchIndex.selectedLabel,top.searchTarget.text,1);
			currentState = "searchRes";
			searchList.searchTitle.text = "\"" + top.searchTarget.text + "\"的搜索结果";
		}		
		else
			Alert.show("请输入搜索内容！");
			
		searchList.page.text = String(0);
	
	}

	/**
	 * 得到搜索结果
	 */
	public function onGetSearchList(result:Array):void{
		this.searchResult = result;
		this.syncSearchList(searchResult);
	}
	
	/**
	 * 布局搜索信息
	 */
	private function syncSearchList(list:Array):void{
		var page:int = int(searchList.page.text) + 1;
		
        searchList.page.text = String(page);
        
        if(page>9)
        	searchList.page.x = 356;
        else
            searchList.page.x = 361;
        
        if(list[10])
        	searchList.nextBtn.enabled = true;
        else 
        	searchList.nextBtn.enabled = false;
        	
        if(page>1)
        	searchList.preBtn.enabled = true;
        else 
        	searchList.preBtn.enabled = false;
        	
		if(list[0]){
			searchList.s1.search.text = list[0].title + " - " + list[0].author;
		} else { searchList.s1.search.text = "对不起，没有您想搜索的歌曲！"; }
		if(list[1]){
			searchList.s2.search.text = list[1].title + " - " + list[1].author;
		} else { searchList.s2.search.text = ""; }
		if(list[2]){
			searchList.s3.search.text = list[2].title + " - " + list[2].author;
		} else { searchList.s3.search.text = ""; }
		if(list[3]){
			searchList.s4.search.text = list[3].title + " - " + list[3].author;
		} else { searchList.s4.search.text = ""; }
		if(list[4]){
			searchList.s5.search.text = list[4].title + " - " + list[4].author;
		} else { searchList.s5.search.text = ""; }
		if(list[5]){
			searchList.s6.search.text = list[5].title + " - " + list[5].author;
		} else { searchList.s6.search.text = ""; }
		if(list[6]){
			searchList.s7.search.text = list[6].title + " - " + list[6].author;
		} else { searchList.s7.search.text = ""; }
		if(list[7]){
			searchList.s8.search.text = list[7].title + " - " + list[7].author;
		} else { searchList.s8.search.text = ""; }
		if(list[8]){
			searchList.s9.search.text = list[8].title + " - " + list[8].author;
		} else { searchList.s9.search.text = ""; }
		if(list[9]){
			searchList.s10.search.text = list[9].title + " - " + list[9].author;
		} else { searchList.s10.search.text = ""; }
	}
	
	/**
	 * 获取下一页搜索结果
	 */
	private function nextSearchPage(event:Event):void{
		var page:int = int(searchList.page.text) + 1;
		
		rpc.getSearchList(onGetSearchList,top.searchIndex.selectedLabel,top.searchTarget.text,page);
		searchList.listDown.play();
	}
	
	/**
	 * 获取前一页搜索结果
	 */
	private function preSearchPage(event:Event):void{
		var page:int = int(searchList.page.text) - 1;
		
		rpc.getSearchList(onGetSearchList,top.searchIndex.selectedLabel,top.searchTarget.text,page);
	}
	
	
	
	
	/**
	 * 加每行播放列表的三颗按钮
	 */
	private function addMusicBtn(event:MouseEvent):void {
		var i:int = event.currentTarget.index;
		
		event.currentTarget.styleName = "player4"; //背景色
		event.currentTarget.labelText.styleName = "musicListRoOver";  //字颜色
		event.currentTarget.littleMusicPlay.visible = true;
		event.currentTarget.littleMusicCollect.visible = true;
		event.currentTarget.littleMusicDelete.visible = true;
		event.currentTarget.tri.visible = true;
	}
	
	/**
	 * 移除每行播放列表的三颗按钮
	 */
	private function removeMusicBtn(event:MouseEvent):void {
		var i:int = event.currentTarget.index;
		
		if(i==1)
			event.currentTarget.styleName = "player3"; //背景色
		else if(i%2 && i!=1)
			event.currentTarget.styleName = "player1";
		else
			event.currentTarget.styleName = "player2";

		event.currentTarget.labelText.styleName = "musicListText";  
		event.currentTarget.littleMusicPlay.visible = false;
		event.currentTarget.littleMusicCollect.visible = false;
		event.currentTarget.littleMusicDelete.visible = false;
		event.currentTarget.tri.visible = false;
	}
	
	/**
	 * 加每行搜索结果列表的三颗按钮  没有用。。。
	 */
	private function addSearchTextBtn(event:MouseEvent):void {
		event.currentTarget.search.styleName = "musicListRoOver";  //字颜色
		event.currentTarget.littleSearchPlay.visible = true;
		event.currentTarget.littleSearchCollect.visible = true;
		event.currentTarget.littleSearchDelete.visible = true;
	}
	
	/**
	 * 移除每行搜索结果的三颗按钮  没有用。。。
	 */
	private function removeSearchTextBtn(event:MouseEvent):void {
		searchList.s1.search.styleName = "followRes";  //字颜色
		event.currentTarget.littleSearchPlay.visible = false;
		event.currentTarget.littleSearchCollect.visible = false;
		event.currentTarget.littleSearchDelete.visible = false;
	}
	
	/**
	 * 同步当前播放歌曲信息到底部状态栏和浏览器标题 
	 */
	private function syncMusicInfo(music:String, author:String, album:String):void{
		bottom.nowMusic.label = music;
		bottom.nowAuthor.label = author;
		bottom.nowAlbum.label = album;
		flash.external.ExternalInterface.call("setTitle", music, author, album);
	}
	
	private function albumSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜专辑",bottom.nowAlbum.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + bottom.nowAlbum.label + "\"的搜索结果";
		searchList.page.text = String(0);
	}
	
	private function authorSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜歌手",bottom.nowAuthor.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + bottom.nowAuthor.label + "\"的搜索结果";
		searchList.page.text = String(0);
	}
	
	private function songSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜歌名",bottom.nowMusic.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + bottom.nowMusic.label + "\"的搜索结果";
		searchList.page.text = String(0);
	}
	
	