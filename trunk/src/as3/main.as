/**
 * 主控制类,也是最顶层的类方法,负责统筹调用所有底层类方法
 * 
 */

	import Component.listDIY;
	import Component.login;
	import Component.mood;
	import Component.register;
	import Component.rssStar;
	import Component.share;
	import Component.special;
	
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
	public var userName:String = "";
	public var userId:Number = 0;
	public var isLoop:int = 0;
	public var isFinished:int = 1;
	public var isSearch:int;//isSearch=1显示搜索结果,isSearch=2显示听过的歌曲
	[Bindable]
	public var Version:String = "Bubble Music 1.0 (2010.4.1.r77) April Fool's Edition.Powered by QSCtech";
	
	/**
	 *初始化播放列表 
	 * 
	 */	
	public function initPlayList():void{
		//获取sid自动登录
		var sid:String = flash.external.ExternalInterface.call("getSid");
		rpc.autoLogin(onLogin,sid);
		//以下列表仅用于测试
		var arg:String = flash.external.ExternalInterface.call("getIndex");
		rpc.getMusicList(onGetMusicList,arg);
		
		musicControl.setNextMusic( this.nextMusic);
		now.next.addEventListener(MouseEvent.CLICK,nextMusic);
		now.playandpause.addEventListener(MouseEvent.CLICK,pauseAndPlay);
		now.volume.addEventListener(SliderEvent.CHANGE,changeVolume);
		now.resetList.addEventListener(MouseEvent.CLICK,resetList);
		now.songpos.addEventListener(MouseEvent.CLICK,setPos);
		top.searchBtn.addEventListener(MouseEvent.CLICK,searchShow);
		top.searchTarget.addEventListener(KeyboardEvent.KEY_DOWN,keyEnter);

		

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
		
	    
	    now.nowAlbum.addEventListener(MouseEvent.CLICK,albumSearch);
	    now.nowAuthor.addEventListener(MouseEvent.CLICK,authorSearch);
	    now.nowMusic.addEventListener(MouseEvent.CLICK,songSearch);
	    now.downMusic.addEventListener(MouseEvent.CLICK,downMusic);
	    now.moodMusic.addEventListener(MouseEvent.CLICK,moodMusic);
	    now.shareMusic.addEventListener(MouseEvent.CLICK,shareMusic);
	    now.specialList.addEventListener(MouseEvent.CLICK,specialList);
	    now.hideLyric.addEventListener(MouseEvent.CLICK,lyricShow);
	    now.diyList.addEventListener(MouseEvent.CLICK,diyShow);
	    now.rssPlayer.addEventListener(MouseEvent.CLICK,rssShow);
	    now.storeMusic.addEventListener(MouseEvent.CLICK,collectMusic);
	    now.loopPlay.addEventListener(MouseEvent.CLICK,setLoop);
	    top.registerBtn.addEventListener(MouseEvent.CLICK,registerShow);
	    top.loginBtn.addEventListener(MouseEvent.CLICK,loginShow);
	    
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
	    
	    now.setSilent.addEventListener(MouseEvent.CLICK,silent);
	    
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
	/*    
	    musicList.l1.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l2.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l3.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l4.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l5.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l6.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l7.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l8.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l9.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l10.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l11.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	    musicList.l12.littleMusicCollect.addEventListener(MouseEvent.CLICK,musicCollect);
	   */
	    
	    musicList.l1.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l2.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l3.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l4.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l5.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l6.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l7.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l8.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l9.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l10.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l11.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    musicList.l12.littleMusicShare.addEventListener(MouseEvent.CLICK,musicShare);
	    top.callback = resetUser;
	    top.getUserListened = getUserListened;
	    rpc.getNotes(tipsShow);
	}

	/**
	 *同步播放列表,当播放列表改动后,同步到播放器界面上 
	 * @param playList
	 * 
	 */	
	private function syncPlayList(list:Array):void{

        now.rssPlayer.label = "关注\"" + list[0].author + "\"";
        now.nowMusic.toolTip = "搜索歌曲\"" + list[0].title + "\"";
		now.nowAuthor.toolTip = "搜索歌手\"" + list[0].author + "\"";
        now.nowAlbum.toolTip = "搜索专辑\"" + list[0].album + "\"";
        
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
	}
	
	/**
	 * 当一首音乐播放完后,执行播放下一首音乐的操作,包括播放列表的同步
	 */
	public function nextMusic(event:Event):void{
		removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		rpc.getNextMusic(this.getNextMusic,1);
		musicControl.pausePlay();
	
		lrcnum = 0;
		LRC.splice(0,LRC.length);
		
		if(musicControl.pos>0.9 && userId!=0)
			rpc.addUserListen(addCredit,userId,playList[0].id);
		else
			rpc.addUserDelete(blank,userId,playList[0].id);
			
		if(isLoop == 0){
			playList.shift();
		}
			
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
		musicControl.newPlay(playList[0].url);
		resetPlaylistX();
		this.syncPlayList(playList);
		this.listEffect(1);
		isFinished = 1;
	}
	
	/**
	 * 听完一首歌自动随机获取歌曲
	 */	
	private function getNextMusic(result:Array):void{
		if(result.length > 0){
			for(var i:int = 0; i<result.length; i++){
				this.playList.push(result[i]);
			}
		}
	}
	
	/**
	 * 自动登录回调
	 */	
	 public function onLogin(result:Object):void{
		if(result.user_id > 0){  
			top.welcomeText.text = result.user_name + "，Let's Bubble~" ;
			top.credit.text = "泡泡数：" + String(result.user_credit);
			userName = result.user_name;
			userId = result.user_id;
			top.currentState = "logined";
			flash.external.ExternalInterface.call("setSid", result.sid);
		} 
		
	 }
	 
	/**
	 *当得到播放列表后,执行相应操作 
	 * @param result
	 */	
	public function onGetMusicList(result:Array):void{
		this.playList = result;
		this.syncPlayList(playList);
		this.listEffect(1);
		musicControl.newPlay(playList[0].url);
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
		
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		this.syncMusicInfo(playList[0].title, playList[0].author ,playList[0].album);
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
		var i:Number = 120 / lyric.picture.content.width;
		lyric.picture.height = lyric.picture.content.height * i;
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
			now.time.text = b + ":0" + c;
		}
		else{
			now.time.text = b + ":" + c;
		}
		
		musicControl.progressSet();
		now.songpos.setProgress(musicControl.progressPos,1);
		
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
				if(LRC[lrcnum]){
					lyric.lrc5.text = LRC[lrcnum].lrc.toString();
				}
				if(LRC[lrcnum+1]&&(lrcnum+1)<LRC.length){
					lyric.lrc6.text = LRC[lrcnum+1].lrc.toString();
				}else{lyric.lrc6.text = ""}
				if(LRC[lrcnum+2]&&(lrcnum+2)<LRC.length){
					lyric.lrc7.text = LRC[lrcnum+2].lrc.toString();
				}else{lyric.lrc7.text = ""}
				if(LRC[lrcnum+3]&&(lrcnum+3)<LRC.length){
					lyric.lrc8.text = LRC[lrcnum+3].lrc.toString();
				}else{lyric.lrc8.text = ""}
				if(LRC[lrcnum+4]&&(lrcnum+4)<LRC.length){
					lyric.lrc9.text = LRC[lrcnum+4].lrc.toString();
				}else{lyric.lrc9.text = ""}
				if(LRC[lrcnum+5]&&(lrcnum+5)<LRC.length){
					lyric.lrc10.text = LRC[lrcnum+5].lrc.toString();
				}else{lyric.lrc10.text = ""}
				
				lyric.LRCeffect.stop();
				lyric.LRCeffect.play();
			}
			else if(time<LRC[lrcnum].time){
				lrcnum-=1;
					
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
				if(LRC[lrcnum]){
					lyric.lrc5.text = LRC[lrcnum].lrc.toString();
				}
				if(LRC[lrcnum+1]&&(lrcnum+1)<LRC.length){
					lyric.lrc6.text = LRC[lrcnum+1].lrc.toString();
				}else{lyric.lrc6.text = ""}
				if(LRC[lrcnum+2]&&(lrcnum+2)<LRC.length){
					lyric.lrc7.text = LRC[lrcnum+2].lrc.toString();
				}else{lyric.lrc7.text = ""}
				if(LRC[lrcnum+3]&&(lrcnum+3)<LRC.length){
					lyric.lrc8.text = LRC[lrcnum+3].lrc.toString();
				}else{lyric.lrc8.text = ""}
				if(LRC[lrcnum+4]&&(lrcnum+4)<LRC.length){
					lyric.lrc9.text = LRC[lrcnum+4].lrc.toString();
				}else{lyric.lrc9.text = ""}
				if(LRC[lrcnum+5]&&(lrcnum+5)<LRC.length){
					lyric.lrc10.text = LRC[lrcnum+5].lrc.toString();
				}else{lyric.lrc10.text = ""}
				
				lyric.LRCeffect.stop();
				lyric.LRCeffect.play();
			}
		}else{ 
			if(time<LRC[lrcnum].time)  //之前在这里就removeADDEVENTLISTENER了，所以进度条在最后的地方都不动了。
				lrcnum-=2;             //而且运行到没有歌词的地方，再点进度条前面，歌词不会再滚动回去了。
		}							   //现在没有这些问题了~
	}

	/**
	 *播放列表项的鼠标双击事件,当双击某一项时,则播放该项 
	 * @param event 事件源
	 * 
	 */	
	public function doubleClickListItem(event:MouseEvent):void{
		var i:int = event.currentTarget.index;
		
		if(userId!=0)
			rpc.addUserDelete(blank,userId,playList[0].id);
		
		for(var j:int = 1; j<i; j++){
			playList.shift();
		}
		this.syncPlayList(playList);
		this.listEffect(1);
		event.currentTarget.moveLeft.stop();
		
		lrcnum = 0;
		LRC.splice(0,LRC.length);
		musicControl.newPlay(playList[0].url);
		rpc.getNextMusic(this.getNextMusic,i-1);
		lrcLoader.load(new URLRequest(playList[0].lrc));
		lrcLoader.addEventListener(Event.COMPLETE,lrcLoadCompleteHandler);
		resetPlaylistX(); 
	}
	/**
	 * 空函数
	 */
	private function blank():void{
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
			now.playandpause.styleName = "playBtn";
		}
		else {
			timer.addEventListener(TimerEvent.TIMER,fadeVolumeIn); 
			now.playandpause.styleName = "pauseBtn";
		}
		timer.start();
	}
	
	/**
	 * 改变音量大小
	 */
	public function changeVolume(event:Event):void{
		musicControl.changeSoundSize(now.volume.value);
		if(isSilent == 1){
			now.setSilent.styleName = "unsilentBtn";
			isSilent = 0;
		}
	}
	
	/**
	 * 自定义进度条位置
	 */
	public function setPos(event:Event):void{
		var pasPos:Number = now.songpos.contentMouseX/now.songpos.width
		if(musicControl.isPlay){
			musicControl.setPos(pasPos);
		}
		else{
			musicControl.setPos(pasPos);
			now.songpos.setProgress(pasPos,1);
			now.playandpause.styleName = "pauseBtn";
			pauseAndPlay(event);
		}
		musicControl.changeSoundSize(now.volume.value);
	}
	
	/**
	 * 按暂停后，音乐淡出
	 */
	public function fadeVolume(event:Event):void{
		musicControl.fadeSound(now.volume.value);
	}
	/**
	 * 按暂停后，音乐淡入
	 */
	public function fadeVolumeIn(event:Event):void{
		musicControl.fadeSoundIn(now.volume.value);
	}
	
	/**
	 * 静音
	 */
	public function silent(event:Event):void{
		if(isSilent == 1){
			musicControl.changeSoundSize(now.volume.value);
			now.setSilent.styleName = "unsilentBtn";
			isSilent = 0;
		}
		else{
			musicControl.changeSoundSize(0);
			now.setSilent.styleName = "silentBtn";
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
			isSearch = 1;
		}
		else
			Alert.show("请输入搜索内容！");
		//searchList.page.text = String(0);
	
	}
	/**
	 * 按回车自动搜索
	 */
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
	 * 布局搜索或者听过歌曲信息
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
	 * 获取下一页搜索或者听过歌曲结果
	 */
	private function nextSearchPage(event:Event):void{
		var page:int = int(searchList.page.text) + 1;
		if(isSearch ==1){
			rpc.getSearchList(onGetSearchList,top.searchIndex.selectedLabel,top.searchTarget.text,page);
		}
		else if(isSearch ==2){
			rpc.getUserListen(onGetSearchList,userId,page);
		}
		searchList.page.text = String(page);
		searchList.listDown.play();
	}
	/**
	 * 获取前一页搜索或者听过歌曲结果
	 */
	private function preSearchPage(event:Event):void{
		var page:int = int(searchList.page.text) - 1;
		if(isSearch ==1){
			rpc.getSearchList(onGetSearchList,top.searchIndex.selectedLabel,top.searchTarget.text,page);
		}
		else if(isSearch ==2){
			rpc.getUserListen(onGetSearchList,userId,page);
		}
		searchList.page.text = String(page);
		searchList.listUp.play();
	}
	
	/**
	 * 将搜索结果中一首歌加入歌曲列表
	 * 用于直接双击搜索结果
	 */
	private function addOneMusic(event:MouseEvent):void{
		var i:int = event.currentTarget.index;
		playList.splice(1,0,searchResult[i-1]);
		resetPlaylistX(); 
		this.syncPlayList(playList);
		this.listAddedEffect(1);
	}
	/**
	 * 将搜索结果中一首歌加入歌曲列表
	 * 用于点击小箭头按钮
	 */
	private function addOneMusicBtn(event:MouseEvent):void{
		var i:int = event.currentTarget.owner.index;
		playList.splice(1,0,searchResult[i-1]);
		resetPlaylistX();  
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
	 * 歌曲名较长，鼠标移上向左滚动
	 */
	private function textScollLeft(event:MouseEvent):void{
		if(event.currentTarget.labelText.width>270){
			event.currentTarget.moveLeft.xFrom = 0;   
            event.currentTarget.moveLeft.xTo = 0 - event.currentTarget.labelText.width + 270; 
            event.currentTarget.moveLeft.repeatCount = 1; //loop 
            event.currentTarget.moveLeft.repeatDelay = 0; //loop time 
            event.currentTarget.moveLeft.duration = (event.currentTarget.labelText.width-270)*20; //the time of scroll once 
            event.currentTarget.moveLeft.play(); 
  		}
 	}
 	/**
	 * 歌曲名较长，鼠标移开向右滚动
	 */
 	private function textScollRight(event:MouseEvent):void{
			event.currentTarget.moveLeft.xFrom = event.currentTarget.labelText.x;   
            event.currentTarget.moveLeft.xTo = 0; 
            event.currentTarget.moveLeft.repeatCount = 1; //loop 
            event.currentTarget.moveLeft.repeatDelay = 0; //loop time 
            event.currentTarget.moveLeft.duration = (event.currentTarget.labelText.width-270)*20; //the time of scroll once 
            event.currentTarget.moveLeft.play(); 
 	}
 	
	/**
	 * 加每行播放列表的三颗按钮
	 */
	private function addMusicBtn(event:MouseEvent):void {
		if(event.currentTarget.text!=""){
			var i:int = event.currentTarget.index;
			event.currentTarget.styleName = "playerOn";
			event.currentTarget.labelText.styleName = "playerSongTextOn";  //字颜色
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
		event.currentTarget.styleName = "playerCanvas";
		event.currentTarget.labelText.styleName = "playerSongText";  
		event.currentTarget.littleMusicShare.visible = false;
		event.currentTarget.littleMusicCollect.visible = false;
		event.currentTarget.littleMusicDelete.visible = false;
		event.currentTarget.tri.visible = false;
	}
	
	/**
	 * 加每行搜索结果列表的按钮 
	 */
	private function addSearchTextBtn(event:MouseEvent):void {
		if(event.currentTarget.search.text != ""){
			event.currentTarget.search.styleName = "searchTextOn";  //字颜色
			event.currentTarget.littleSearchAdd.visible = true;
		}
	}
	/**
	 * 移除每行搜索结果的按钮
	 */
	private function removeSearchTextBtn(event:MouseEvent):void {
		
		event.currentTarget.search.styleName = "searchText";  //字颜色
		event.currentTarget.littleSearchAdd.visible = false;
		
	}
	
	/**
	 * 收藏播放列表中歌曲
	 * 用于正在播放的歌曲
	 */
	private function musicCollect(event:MouseEvent):void{
		var i:int = event.currentTarget.owner.index - 1;
		if(userName != ""){
			
		}
		else{
			Alert.show("登录后才能收藏歌曲！");
		}
	}
	/**
	 * 收藏播放列表中歌曲 
	 * 用于播放列表中的歌曲
	 */
	private function collectMusic(event:MouseEvent):void{
		if(userName != ""){
			
		}
		else{
			Alert.show("登录后才能收藏歌曲！");
		}
	}
	
	/**
	 * 删除播放列表中歌曲 
	 */
	private function musicDelete(event:MouseEvent):void{
		var i:int = event.currentTarget.owner.index;
		
		rpc.addUserDelete(blank,userId,playList[i-1].id);
		
		if(i == 1){
			nextMusic(event);
		}
		else{
			rpc.getNextMusic(this.getNextMusic,1);
			playList.splice(i-1,1);
			this.syncPlayList(playList);
			this.listEffect(i);
		}
	}
	
	/**
	 * 同步当前播放歌曲信息到状态栏和浏览器标题 
	 */
	private function syncMusicInfo(music:String, author:String, album:String):void{
		now.nowMusic.label = music;
		now.nowAuthor.label = author;
		now.nowAlbum.label = album;
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
	 * 按专辑搜索
	 */
	private function albumSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜专辑",now.nowAlbum.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + now.nowAlbum.label + "\"的搜索结果";
		searchList.page.text = String(1);
		top.searchIndex.text = "搜专辑";
		top.searchTarget.text = now.nowAlbum.label;
		isSearch = 1;
	}
	/**
	 * 按歌手搜索
	 */
	private function authorSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜歌手",now.nowAuthor.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + now.nowAuthor.label + "\"的搜索结果";
		searchList.page.text = String(1);
		top.searchIndex.text = "搜歌手";
		top.searchTarget.text = now.nowAuthor.label;
		isSearch = 1;
	}
	/**
	 * 按歌名搜索
	 */
	private function songSearch(event:MouseEvent):void{
		rpc.getSearchList(onGetSearchList,"搜歌名",now.nowMusic.label,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "\"" + now.nowMusic.label + "\"的搜索结果";
		searchList.page.text = String(1);
		top.searchIndex.text = "搜歌名";
		top.searchTarget.text = now.nowMusic.label;
		isSearch = 1;
	}
	
	/**
	 * 下载音乐
	 */
	private function downMusic(event:MouseEvent):void{
		var URL:URLRequest = new URLRequest(playList[0].url);
		flash.net.navigateToURL(URL,"_blank");
		Alert.show("由于涉及版权问题，请在下载后24小时内删除歌曲，谢谢合作^^");
	}
	
	/**
	 * 向播放列表中删除歌曲，列表动画添加
	 */
	private function listEffect(from:int):void{
		var effect:Parallel = new Parallel();
		for (var i:int=from-1; i<12; i++){
			effect.addChild(musicList.listEffectArray[i]);
		}
		effect.play();
	}
	/**
	 * 向播放列表中添加歌曲，列表动画添加
	 */
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
		if(userName!=""){
			var moodWin:mood = new mood();
			moodWin.text = playList[0].title;
			moodWin.usernameMood = userName;
			moodWin.userIdMood = userId;
			moodWin.callback = addCredit;
			moodWin.setIndex(playList[0].id);
			moodWin.init();
			PopUpManager.addPopUp(moodWin,this,false);
		    PopUpManager.centerPopUp(moodWin);
		    moodWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
		    moodWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
		}
		else
			Alert.show("嗨，注册登录后就能和其他用户一起泡心情啦~");	
	}
	
	/**
	 * 分享音乐
	 * 用于正在播放的歌曲
	 */
	private function shareMusic(event:MouseEvent):void{
		var shareWin:share = new share();
		shareWin.text = "分享\"" + playList[0].title + "\"给好友吧~";
		shareWin.address = "http://10.76.8.200/bubble/bubble/#" + playList[0].id;
		shareWin.copied = tipsShow;
	    PopUpManager.addPopUp(shareWin,this,false);
	    PopUpManager.centerPopUp(shareWin);
	    shareWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
	    shareWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
	}
	/**
	 * 分享音乐
	 * 用于播放列表里的歌
	 */
	private function musicShare(event:MouseEvent):void{
		var i:int = event.currentTarget.owner.index - 1;
		var shareWin:share = new share();
		shareWin.text = "分享\"" + playList[i].title + "\"给好友吧~";
		shareWin.address = "http://10.76.8.200/bubble/bubble/#" + playList[i].id;
		shareWin.copied = tipsShow;
	    PopUpManager.addPopUp(shareWin,this,false);
	    PopUpManager.centerPopUp(shareWin);
	    shareWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
	    shareWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
	}	
	
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
		
	/**
	 * 音乐专题
	 */	
	private function specialList(event:MouseEvent):void{
		var specialWin:special = new special();
	    PopUpManager.addPopUp(specialWin,this,false);
	    PopUpManager.centerPopUp(specialWin);
	    specialWin.init();
	    specialWin.callback = onGetSpecialList;
	    specialWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
	    specialWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
	}
	public function onGetSpecialList(result:Array,specialName:String):void{
		onGetMusicList(result);
		musicControl.setNextMusic(this.nextMusic);
		var specialTips:String = "专题\""+ specialName + "\"加载成功";
		tipsShow(specialTips);
	}
	
	/**
	 * 注册
	 */	
	private function registerShow(event:MouseEvent):void{
		var registerWin:register = new register();
		registerWin.login = loginNew;
		registerWin.callBack = registerDone;
	    PopUpManager.addPopUp(registerWin,this,true);
	    PopUpManager.centerPopUp(registerWin);
	}
	/**
	 * 登录
	 */	
	private function loginShow(event:MouseEvent):void{
		var loginWin:login = new login();
		loginWin.callBack = callBack;
		loginWin.register = registerNew;
	    PopUpManager.addPopUp(loginWin,this,true);
	    PopUpManager.centerPopUp(loginWin);
	}
	
	/**
	 * 注册成功后的回调函数
	 */
	public function registerDone(result:Object):void{
		top.welcomeText.text = result.user_name + "，Let's Bubble~" ;
		top.credit.text = "泡泡数：" + String(result.user_credit);
		top.currentState = "logined";
		userName = result.user_name;
		userId = result.user_id;
		tipsShow("注册成功~");
	}
	/**
	 * 登录成功后的回调函数
	 */
	public function callBack(result:Object):void{
		top.welcomeText.text = result.user_name + "，Let's Bubble~" ;
		top.credit.text = "泡泡数：" + String(result.user_credit);
		top.currentState = "logined";
		userName = result.user_name;
		userId = result.user_id;
		tipsShow("登录成功~");
	}
	
	/**
	 * 这两个函数如果直接用前面的不行><
	 * 用于登录和注册窗口的切换
	 */	
	private function registerNew():void{
		var registerWin:register = new register();
		registerWin.login = loginNew;
		registerWin.callBack = callBack;
	    PopUpManager.addPopUp(registerWin,this,true);
	    PopUpManager.centerPopUp(registerWin);
	}
	private function loginNew():void{
		var loginWin:login = new login();
		loginWin.callBack = callBack;
		loginWin.register = registerNew;
	    PopUpManager.addPopUp(loginWin,this,true);
	    PopUpManager.centerPopUp(loginWin);
	}
	
	/**
	 * 消息提醒
	 */
	private function tipsShow(tip:String):void{
		tipText.text = tip;
		tipShow.play();
	}
	
	/**
	 * DIY播放列表
	 */
	 private function diyShow(event:MouseEvent):void{
		var diyWin:listDIY = new listDIY();
		PopUpManager.addPopUp(diyWin,this,false);
	    PopUpManager.centerPopUp(diyWin);
	    diyWin.init(userName);
	    diyWin.logNew = loginNew;
	    diyWin.regNew = registerNew;
	    diyWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
	    diyWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
	}	
	/**
	 * 关注歌手
	 */
	private function rssShow(event:MouseEvent):void{
		if(userName != ""){
			var rssWin:rssStar = new rssStar();
			PopUpManager.addPopUp(rssWin,this,false);
	    	PopUpManager.centerPopUp(rssWin);
	    	rssWin.text = "关注\"" + playList[0].author + "\"？";
	    	rssWin.text2 = "我们将在第一时间把\"" + playList[0].author + "\"的新歌推荐给您~";
	    	rssWin.addEventListener(MouseEvent.MOUSE_DOWN,dragIt);
	    	rssWin.addEventListener(MouseEvent.MOUSE_UP,dropIt);
		}
		else{
			Alert.show("嗨，注册登录后就能关注您喜欢的歌手啦~");
		}
	}
	/**
	 * 登录后点退出，重置用户名&ID变量
	 */
	private function resetUser():void{
		userName = "";
		userId = 0;
	}
	
	/**
	 * 获取用户刚刚听过的歌曲列表
	 */
	private function getUserListened():void{
		rpc.getUserListen(onGetSearchList,userId,1);
		currentState = "searchRes";
		searchList.searchTitle.text = "刚刚听过的歌曲";
		searchList.page.text = String(1);
		isSearch = 2;
	}
	
	/**
	 * 单曲循环播放、顺序播放切换
	 */
	public function setLoop(event:Event):void{
		if(isLoop == 0){
			isLoop = 1;
			now.loopPlay.label = "顺序播放";
			tipsShow("切换为单曲循环模式");
		}
		else{
			isLoop = 0;
			now.loopPlay.label = "单曲循环";
			tipsShow("切换为顺序播放模式");
		}	
	}
	
	/**
	 * 每听完一首歌，更新积分
	 */	
	private function addCredit(result:int):void{
		top.credit.text = "泡泡数：" + String(result);
	}