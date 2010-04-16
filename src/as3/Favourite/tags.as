/**  
 * tag & singer
 * AS部分  
 * 
 */ 
	import Component.linkBtn;
	
	import as3.Net.RPC;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.controls.Spacer;
	import mx.controls.Text;
	import mx.managers.PopUpManager; 
                 
	private var rpc:RPC = new RPC();
	public var userIndex:int;
	
	private var tagList:Array = new Array();
	private var tagIDList:Array = new Array();
	private var singerList:Array = new Array();
	private var singerIDList:Array = new Array();
	
	private var newY:int = 0;
	public var tagID:Function;
	public var singerID:Function;
	
	/**
	* 关闭面板
	*/
	public function close():void{
		PopUpManager.removePopUp(this);
	}
	/**
	* 得到字符串实际长度 一个中文as“XX”
	*/
	private function getStrActualLen(str:String):int{  
		return str.replace(/[^\x00-\xff]/g,"xx").length;  
	}
	
	/**
	* 获取tags初始化
	*/
	public function init():void{
		rpc.getUserFavTag(onResultGetClass,userIndex);
	}
	/**
	* tags布局函数
	*/
	public function onResultGetClass(result:Array):void{
		var x:Number = 10;
		var y:Number = 30;
		var sum:Number = 10;
		if(result.length == 0){
			var txt:Text = new Text();
			txt.text = "您可以通过收藏歌曲添加tags~"
			txt.x = x;
			txt.y = y;
			this.addChild(txt);
		}
		for(var i:int = 0;i<result.length;i++){
			tagList[i] = result[i].tag_name;
			tagIDList[i] = result[i].tag_id;
			var lBtn:linkBtn = new linkBtn();
			lBtn.text = tagList[i];
			lBtn.index = i;
			lBtn.addEventListener(MouseEvent.CLICK,getUserClassMusic);
			var len:int = getStrActualLen(tagList[i]) * 8;
			lBtn.width = len;
			sum = sum + len;
			if(sum>380){
				x = 10;
				y = y + 20;
				lBtn.x = 10;
				lBtn.y = y; 
				this.addChild(lBtn);
				sum = 10 + len;
				x = sum;
			}
			else{
				lBtn.x = x;
				lBtn.y = y;
				this.addChild(lBtn);
				x = sum;
			}
		}
		newY = y + 20;
		addSingerTop();
	}
	/**
	* singersTop布局
	* 获取singers初始化
	*/
	public function addSingerTop():void{
		singerTop.y = newY;
		newY = newY + 20;
		rpc.getUserFavArtists(onResultGetSinger,userIndex);
	}
	/**
	* singers布局函数
	*/
	public function onResultGetSinger(result:Array):void{
		var x:Number = 10;
		var y:Number = newY;
		var sum:Number = 10;
		if(result.length == 0){
			var txt:Text = new Text();
			txt.text = "您可以通过收藏歌曲添加收藏的歌手~"
			txt.x = x;
			txt.y = y;
			this.addChild(txt);
		}
		for(var i:int = 0;i<result.length;i++){
			singerList[i] = result[i].artists_name;
			singerIDList[i] = result[i].artists_id;
			var lBtn:linkBtn = new linkBtn();
			lBtn.text = singerList[i];
			lBtn.index = i;
			lBtn.addEventListener(MouseEvent.CLICK,getUserSingerMusic);
			var len:int = getStrActualLen(singerList[i]) * 8;
			lBtn.width = len;
			sum = sum + len;
			if(sum>380){
				x = 10;
				y = y + 20;
				lBtn.x = 10;
				lBtn.y = y; 
				this.addChild(lBtn);
				sum = 10 + len;
				x = sum;
			}
			else{
				lBtn.x = x;
				lBtn.y = y;
				this.addChild(lBtn);
				x = sum;
			}
		}
		
		newY = y + 20;
		var space:Spacer = new Spacer();
		space.y = newY;
		space.x = 10;
		space.height = 10;
		this.addChild(space);
	}
	
	/**
	* 获取用户某tag的歌曲
	* tagID函数回调到main中
	*/
	public function getUserClassMusic(event:Event):void{
		var i:int = event.currentTarget.index;
		tagID(tagIDList[i]);
	}

	/**
	* 获取用户某singer的歌曲
	* singerID函数回调到main中
	*/
	public function getUserSingerMusic(event:Event):void{
		var i:int = event.currentTarget.index;
		singerID(singerIDList[i]);
	}
	