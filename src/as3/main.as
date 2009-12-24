/**
 * 主控制类,也是最顶层的类方法,负责统筹调用所有底层类方法
 * 
 */

	import Component.mood;
	import Component.share;
	
	import as3.Lyric.LRCDecoder;
	import as3.Net.RPC;
	import as3.PlayControl.playControl;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.effects.Parallel;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.SliderEvent;
	import mx.managers.PopUpManager;        
            
            
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
	public var isSilent:int = 0;
	public var isMood:int = 0;
	public var isShare:int = 0;
	
	[Bindable]
	public var Version:String = "Bubble jay 0.5 (12.24.r48) Christmas Edition.Powered by QSCtech";
	
	/**
	 *初始化播放列表 
	 * 
	 */	
	public function initPlayList():void{
		
		//以下列表仅用于测试
		var arg:String = flash.external.ExternalInterface.call("getIndex");
		rpc.getMusicList(onGetMusicList,arg);

		musicControl.setNextMusic( this.nextMusic);
		playerTop.next.addEventListener(MouseEvent.CLICK,nextMusic);
		playerTop.playandpause.addEventListener(MouseEvent.CLICK,pauseAndPlay);
		playerTop.volume.addEventListener(SliderEvent.CHANGE,changeVolume);
		playerTop.resetList.addEventListener(MouseEvent.CLICK,resetList);
		
		top.searchBtn.addEventListener(MouseEvent.CLICK,searchShow);
		top.searchTarget.addEventListener(KeyboardEvent.KEY_DOWN,keyEnter);

		playerTop.albumPlayerShift.play();

		//歌曲列表按钮显示
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
		//双击歌曲播放
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
		
	    
	    bottom.nowAlbum.addEventListener(MouseEvent.CLICK,albumSearch);
	    bottom.nowAuthor.addEventListener(MouseEvent.CLICK,authorSearch);
	    bottom.nowMusic.addEventListener(MouseEvent.CLICK,songSearch);
	    bottom.downMusic.addEventListener(MouseEvent.CLICK,downMusic);
	    bottom.moodMusic.addEventListener(MouseEvent.CLICK,moodMusic);
	    bottom.shareMusic.addEventListener(MouseEvent.CLICK,shareMusic);
	    //歌曲名滚动
	    musicList.l1.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l2.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l3.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l4.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l5.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l6.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l7.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l8.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l9.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l10.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l11.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    musicList.l12.addEventListener(MouseEvent.MOUSE_OVER,textScollLeft);
	    //歌曲名滚动
	    musicList.l1.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l2.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l3.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l4.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l5.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l6.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l7.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l8.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l9.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l10.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l11.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    musicList.l12.addEventListener(MouseEvent.MOUSE_OUT,textScollRight);
	    
	    playerTop.setSilent.addEventListener(MouseEvent.CLICK,silent);
	    
	    lyric.picture.addEventListener(Event.COMPLETE,picLoadComplete);
	    //删除歌曲
	    musicList.l1.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l2.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l3.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l4.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l5.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l6.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l7.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l8.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l9.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l10.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l11.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
	    musicList.l12.littleMusicDelete.addEventListener(MouseEvent.CLICK,musicDelete);
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
        
        resetPlaylistX();     
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
		
	//	if(isMood){
	//		moodUpdate();
	//	}
	//	if(isShare){
	//		shareUpdate();
	//	}
	}
	
	/**
	 * 当一首音乐播放完后,执行播放下一首音乐的操作,包括播放列表的同步
	 */
	public function nextMusic(event:Event):void{
		musicControl.pausePlay();
		lrcnum = 0;
		LRC.splice(0,LRC.length);
		playList.shift();
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
		resetPlaylistX();     //////////////////////////////////////
		this.syncPlayList(playList);
		this.listEffect(1);
	}
	
	private function getNextMusic(result:Object):void{
		this.playList.push(result);
	}
	
	
	/**
	 *当得到播放列表后,执行相应操作 
	 * @param result
	 * 
	 */	
	public function onGetMusicList(result:Array):void{
		this.playList = result;
		this.syncPlayList(playList);
		this.listEffect(1);
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
	}
	
	
	
	/**
	 * 当歌词加载完成，开始对歌词进行处理
	 */
	private function lrcLoadCompleteHandler(event:Event):void{
		var str:String = event.target.data;
		lyric.picture.source = playList[0].pic;
		
		lyric.lrc0.text = "";
		lyric.lrc1.text = "";
		lyric.lrc2.text = "";
		lyric.lrc3.text = "";
		lyric.lrc4.text = "";
		lyric.lrc5.text = "";
		lyric.lrc6.text = "";
		lyric.lrc7.text = "";
		lyric.lrc8.text = "";
		lyric.lrc9.text = "";
		lyric.lrc10.text = "";
		LRC = LRCDecoder.decoder(str);
		musicControl.newPlay(playList[0].url);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		this.syncMusicInfo(playList[0].title, playList[0].author ,playList[0].album);
		rpc.getNextMusic(this.getNextMusic);
	}
	
	private function resetPlaylistX():void{
		musicList.l1.labelText.x = 0;
		musicList.l2.labelText.x = 0;
		musicList.l3.labelText.x = 0;
		musicList.l4.labelText.x = 0;
		musicList.l5.labelText.x = 0;
		musicList.l6.labelText.x = 0;
		musicList.l7.labelText.x = 0;
		musicList.l8.labelText.x = 0;
		musicList.l9.labelText.x = 0;
		musicList.l10.labelText.x = 0;
		musicList.l11.labelText.x = 0;
		musicList.l12.labelText.x = 0;
	}
	
	
	
	/**
	 * 处理倒影的显示
	 */
	private function picLoadComplete(event:Event):void{
		var timer:Timer = new Timer(3000,1);
		timer.addEventListener(TimerEvent.TIMER, reflectorPicture);
		timer.start();
	}
	private function reflectorPicture(event:Event):void{
		lyric.reflectorPic.clearCachedBitmaps();
		lyric.reflectorPic.invalidateDisplayList();
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
			//	if(lyric.lrc5.width>272)
			//		lyric.LRCeffect.addEventListener(EffectEvent.EFFECT_END,scrollLyric);
				
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
/*
	private function scrollLyric():void{
		lyric.LRCon.xFrom = 0;
		lyric.LRCon.xTo = 0 - lyric.lrc5.width + 272; 
		lyric.LRCon.repeatCount = 1; //loop 
        lyric.LRCon.repeatDelay = 0; //loop time
		lyric.LRCon.duration = (lyric.lrc5.width-272)*20;
		lyric.LRCon.play();
	}
*/
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
		this.listEffect(i-1);
		event.currentTarget.moveLeft.stop();
		
		lrcnum = 0;
		LRC.splice(0,LRC.length);
		musicControl.pausePlay();
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
		resetPlaylistX();     //////////////////////////////////////
	}
	
	/**
	 * 播放&暂停按钮
	 */
	public function pauseAndPlay(event:Event):void{
		var timer:Timer;
		timer = new Timer(100,20);
		if(musicControl.isPlay){
			timer.addEventListener(TimerEvent.TIMER,fadeVolume); 
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,musicControl.fadePause);
			playerTop.playandpause.styleName = "buttomPlay";
		}
		else {
			timer.addEventListener(TimerEvent.TIMER,fadeVolumeIn); 
			playerTop.playandpause.styleName = "buttomPause";
		}
		timer.start();
	}
	
	/**
	 * 改变音量大小
	 */
	public function changeVolume(event:Event):void{
		musicControl.changeSoundSize(playerTop.volume.value);
		if(isSilent == 1){
			playerTop.setSilent.styleName = "silent1";
			isSilent = 0;
		}
	}
	
	/**
	 * 按暂停后，音乐淡出——！！没有用。。。
	 */
	public function fadeVolume(event:Event):void{
		musicControl.fadeSound(playerTop.volume.value);
	}
	public function fadeVolumeIn(event:Event):void{
		musicControl.fadeSoundIn(playerTop.volume.value);
	}
	
	/**
	 * 静音
	 */
	public function silent(event:Event):void{
		if(isSilent == 1){
			musicControl.changeSoundSize(playerTop.volume.value);
			playerTop.setSilent.styleName = "silent1";
			isSilent = 0;
		}
		else{
			musicControl.changeSoundSize(0);
			playerTop.setSilent.styleName = "silent2";
			isSilent = 1;
		}
	}
	
	/**
	 * 重置播放列表
	 */
	public function resetList(event:Event):void{
		rpc.getMusicList(onGetMusicList,"0");
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
			searchList.page.text = String(1);
			searchList.searchTitle.text = "\"" + top.searchTarget.text + "\"的搜索结果";
		}
		else
			Alert.show("请输入搜索内容！");
		//searchList.page.text = String(0);
	
	}
	private function keyEnter(event:KeyboardEvent):void{
		if(event.keyCode == 13){
			this.searchShow(event);
		}
		
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
		var page:int = int(searchList.page.text);
        
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
			searchList.s1.search.text = list[0].title + " - " + list[0].author + " - " + list[0].album;
		} else { searchList.s1.search.text = "对不起，没有您想搜索的歌曲！"; }
		if(list[1]){
			searchList.s2.search.text = list[1].title + " - " + list[1].author + " - " + list[1].album;
		} else { searchList.s2.search.text = ""; }
		if(list[2]){
			searchList.s3.search.text = list[2].title + " - " + list[2].author + " - " + list[2].album;
		} else { searchList.s3.search.text = ""; }
		if(list[3]){
			searchList.s4.search.text = list[3].title + " - " + list[3].author + " - " + list[3].album;
		} else { searchList.s4.search.text = ""; }
		if(list[4]){
			searchList.s5.search.text = list[4].title + " - " + list[4].author + " - " + list[4].album;
		} else { searchList.s5.search.text = ""; }
		if(list[5]){
			searchList.s6.search.text = list[5].title + " - " + list[5].author + " - " + list[5].album;
		} else { searchList.s6.search.text = ""; }
		if(list[6]){
			searchList.s7.search.text = list[6].title + " - " + list[6].author + " - " + list[6].album;
		} else { searchList.s7.search.text = ""; }
		if(list[7]){
			searchList.s8.search.text = list[7].title + " - " + list[7].author + " - " + list[7].album;
		} else { searchList.s8.search.text = ""; }
		if(list[8]){
			searchList.s9.search.text = list[8].title + " - " + list[8].author + " - " + list[8].album;
		} else { searchList.s9.search.text = ""; }
		if(list[9]){
			searchList.s10.search.text = list[9].title + " - " + list[9].author + " - " + list[9].album;
		} else { searchList.s10.search.text = ""; }
	}
	
	/**
	 * 获取下一页搜索结果
	 */
	private function nextSearchPage(event:Event):void{
		var page:int = int(searchList.page.text) + 1;
		
		rpc.getSearchList(onGetSearchList,top.searchIndex.selectedLabel,top.searchTarget.text,page);
		searchList.page.text = String(page);
		searchList.listDown.play();
	}
	
	/**
	 * 获取前一页搜索结果
	 */
	private function preSearchPage(event:Event):void{
		var page:int = int(searchList.page.text) - 1;
		
		rpc.getSearchList(onGetSearchList,top.searchIndex.selectedLabel,top.searchTarget.text,page);
		searchList.page.text = String(page);
		searchList.listUp.play();
	}
	
	/**
	 * 将搜索结果中一首歌加入歌曲列表
	 */
	private function addOneMusic(event:MouseEvent):void{
		
		var i:int = event.currentTarget.index;
		playList.splice(1,0,searchResult[i-1]);
		
	//	musicControl.setNextMusic( this.nextMusic);
		resetPlaylistX();     //////////////////////////////////////
		
		this.syncPlayList(playList);
		this.listAddedEffect(1);
	}
	
	private function addOneMusicBtn(event:MouseEvent):void{
		var i:int = event.currentTarget.owner.index;
		
		playList.splice(1,0,searchResult[i-1]);
		
	//	musicControl.setNextMusic( this.nextMusic);
		resetPlaylistX();     //////////////////////////////////////
		
		this.syncPlayList(playList);
		this.listAddedEffect(1);
	}
	
	/**
	 * 将搜索结果中当前页歌全部加入歌曲列表
	 */
	private function addAllMusic(event:MouseEvent):void{
		var i:int = 0;
		while(searchResult[i] && i<10){
			playList.splice(1+i,0,searchResult[i]);
			i++;
		}
		resetPlaylistX();     //////////////////////////////////////
		this.syncPlayList(playList);
		this.listAddedEffect(i);
	}
	
	/**
	 * 加每行播放列表的三颗按钮
	 */
	private function addMusicBtn(event:MouseEvent):void {
		if(event.currentTarget.text!=""){
			var i:int = event.currentTarget.index;
			
			event.currentTarget.styleName = "player4"; //背景色
			event.currentTarget.labelText.styleName = "musicListRoOver";  //字颜色
			
			
			
			event.currentTarget.littleMusicShare.visible = true;
			event.currentTarget.littleMusicCollect.visible = true;
			event.currentTarget.littleMusicDelete.visible = true;
			event.currentTarget.tri.visible = true;
		}		
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
		event.currentTarget.littleMusicShare.visible = false;
		event.currentTarget.littleMusicCollect.visible = false;
		event.currentTarget.littleMusicDelete.visible = false;
		event.currentTarget.tri.visible = false;

	}
	
	/**
	 * 歌曲名较长，鼠标移上向左滚动
	 */
	private function textScollLeft(event:MouseEvent):void{
		if(event.currentTarget.labelText.width>230){
			event.currentTarget.moveLeft.xFrom = 0;   
            event.currentTarget.moveLeft.xTo = 0 - event.currentTarget.labelText.width + 230; 
            event.currentTarget.moveLeft.repeatCount = 1; //loop 
            event.currentTarget.moveLeft.repeatDelay = 0; //loop time 
            event.currentTarget.moveLeft.duration = (event.currentTarget.labelText.width-230)*20; //the time of scroll once 
            event.currentTarget.moveLeft.play(); 
  		}
 	}
 	
 	/**
	 * 歌曲名较长，鼠标移开向右滚动
	 */
 	private function textScollRight(event:MouseEvent):void{
 		
	//	if(event.currentTarget.labelText.width>230){
			event.currentTarget.moveLeft.xFrom = event.currentTarget.labelText.x;   
            event.currentTarget.moveLeft.xTo = 0; 
            event.currentTarget.moveLeft.repeatCount = 1; //loop 
            event.currentTarget.moveLeft.repeatDelay = 0; //loop time 
            event.currentTarget.moveLeft.duration = (event.currentTarget.labelText.width-230)*20; //the time of scroll once 
            event.currentTarget.moveLeft.play(); 
  	//	}
  		
 	}
	
	/**
	 * 加每行搜索结果列表的三颗按钮 
	 */
	private function addSearchTextBtn(event:MouseEvent):void {
		if(event.currentTarget.search.text != ""){
			event.currentTarget.search.styleName = "musicListRoOver";  //字颜色
			event.currentTarget.littleSearchAdd.visible = true;
		}
	}
	
	/**
	 * 移除每行搜索结果的三颗按钮
	 */
	private function removeSearchTextBtn(event:MouseEvent):void {
		
		event.currentTarget.search.styleName = "followRes";  //字颜色
		event.currentTarget.littleSearchAdd.visible = false;
		
	}
	
	/**
	 * 删除播放列表中歌曲 
	 */
	private function musicDelete(event:MouseEvent):void{
		var i:int = event.currentTarget.owner.index;
		
		if(i == 1){
			nextMusic(event);
		}
		else{
			rpc.getNextMusic(this.getNextMusic);
			playList.splice(i-1,1);
			this.syncPlayList(playList);
			this.listEffect(i);
		}
		
		
	}
	
	
	/**
	 * 同步当前播放歌曲信息到底部状态栏和浏览器标题 
	 */
	private function syncMusicInfo(music:String, author:String, album:String):void{
		bottom.nowMusic.label = music;
		bottom.nowAuthor.label = author;
		bottom.nowAlbum.label = album;
		flash.external.ExternalInterface.call("setTitle", music, author, album);
		var num:int = playList.length > 12 ? 12 : playList.length;
		var list:String = "";
		for(var i:int=0; i<num; i++){
			if(i == 0)
				list += playList[i].id;
			else
				list += "||" + playList[i].id;
		}
		if (list != ""){
			flash.external.ExternalInterface.call("setCookie", list);
		}
	}
	
	/**
	 * 底部状态栏按专辑搜索
	 */
	private function albumSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜专辑",bottom.nowAlbum.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + bottom.nowAlbum.label + "\"的搜索结果";
		searchList.page.text = String(0);
	}
	
	/**
	 * 底部状态栏按歌手搜索
	 */
	private function authorSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜歌手",bottom.nowAuthor.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + bottom.nowAuthor.label + "\"的搜索结果";
		searchList.page.text = String(0);
	}
	
	/**
	 * 底部状态栏按歌名搜索
	 */
	private function songSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜歌名",bottom.nowMusic.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + bottom.nowMusic.label + "\"的搜索结果";
		searchList.page.text = String(0);
	}
	/**
	 * 下载音乐
	 */
	private function downMusic(event:MouseEvent):void{
		var URL:URLRequest = new URLRequest(playList[0].url);
		flash.net.navigateToURL(URL,"_blank");
	}
	
	private function listEffect(from:int):void{
		var effect:Parallel = new Parallel();
		for (var i:int=from-1; i<12; i++){
			effect.addChild(musicList.listEffectArray[i]);
		}
		effect.play();
	}
	private function listAddedEffect(from:int):void{
		var effect:Parallel = new Parallel();
		
		for (var i:int=from+1; i<12; i++){
			effect.addChild(musicList.listAddedEffect[i]);
		}
		effect.play();
		
	}
	
	/**
	 * 音乐心情
	 */
	private function moodMusic(event:MouseEvent):void{
		var moodWin:mood = new mood();
		moodWin.text = playList[0].title;
		moodWin.setIndex(playList[0].id);
		moodWin.init();
		PopUpManager.addPopUp(moodWin,this,false);
	    PopUpManager.centerPopUp(moodWin);
	//    moodWin.callBack = callBack;
	    isMood = 1;
	    moodWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
	    moodWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
	}
	
	/**
	 * 分享音乐
	 */
	private function shareMusic(event:MouseEvent):void{
		var shareWin:share = new share();
		shareWin.text = playList[0].title;
		shareWin.address = "http://10.76.8.200/bubble/bubble/#" + playList[0].id;
	    PopUpManager.addPopUp(shareWin,this,false);
	    PopUpManager.centerPopUp(shareWin);
	 //   shareWin.callBack = callBack;
	    isShare = 1;
	    shareWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
	    shareWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
	}
/*	
	private function moodUpdate():void{
		var moodWin:mood = new mood();
		moodWin.text = playList[0].title;
		moodWin.setIndex(playList[0].id);
		moodWin.init();
		
	}
	private function shareUpdate():void{
		var shareWin:share = new share();
		shareWin.text = playList[0].title;
		shareWin.address = "http://10.76.8.200/bubble/bubble/#" + playList[0].id;
	}
	
	public function callBack(s:String):void{
		if(s == "mood")
			isMood = 0;
		if(s == "share")
			isShare = 0;	
	}
*/	
	/**
	 * 弹出窗口的处理
	 */
	public function close():void{         
		PopUpManager.removePopUp(this);     
	}          
	public function dropIt(event:MouseEvent):void{       
		event.currentTarget.stopDrag();     
	}           
	public function dragIt(event:MouseEvent):void{       
		event.currentTarget.startDrag();     
	}
