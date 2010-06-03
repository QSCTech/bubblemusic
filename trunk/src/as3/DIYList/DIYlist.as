	
	
	import Component.linkBtn;
	
	import as3.Net.RPC;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.controls.Text;
	import mx.managers.PopUpManager; 
    
    private var rpc:RPC = new RPC();
	public var userIndex:int;
	public var listIndex:int = -1; //用于存储目前编辑中的列表ID
	public var shareName:String;
	
	public var tagList:Array = new Array();
	public var tagIDList:Array = new Array();
	private var ListDes:Array = new Array();
	
	private var newY:int = 0;
	public var listPlay:Function;
	public var editListID:Function;
	public var completeDIY:Function;
	public var clickFunc:Function;
	public var cancelDIY:Function;
	public var isAdding:Boolean = false;
	public var isOn:Boolean = false;
	public var shareDIYlist:Function;
	
	/**
	* 获取tags初始化
	*/
	public function init():void{
		clickFunc = listPlay;
		rpc.getDIYlist(onResultGetClass,userIndex);
	}
	/**
	* 得到字符串实际长度 一个中文as“XX”
	*/
	private function getStrActualLen(str:String):int{  
		return str.replace(/[^\x00-\xff]/g,"xx").length;  
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
			tagList[i] = result[i].playlist_name;
			tagIDList[i] = result[i].playlist_id;
			ListDes[i] = result[i].playlist_description;
			var lBtn:linkBtn = new linkBtn();
			lBtn.text = tagList[i];
			lBtn.index = i;
			lBtn.toolTip = result[i].playlist_description;
			var len:int = getStrActualLen(tagList[i]) * 8 + 26;
			lBtn.width = len;
			sum = sum + len;
			if(sum>380){
				x = 10;
				y = y + 20;
				lBtn.x = 10;
				lBtn.y = y; 
				this.area.addChild(lBtn);
				sum = 10 + len;
				x = sum;
			}
			else{
				lBtn.x = x;
				lBtn.y = y;
				this.area.addChild(lBtn);
				x = sum;
			}
			lBtn.littleListShare.visible = true;
			lBtn.linkB.addEventListener(MouseEvent.CLICK,getUserClassMusic);
			lBtn.littleListShare.addEventListener(MouseEvent.CLICK,shareDIYlist);
		}
		newY = y + 20;
		this.height = newY + 40;
	}
	
	public function getUserClassMusic(event:Event):void{
		var i:int = event.currentTarget.owner.index;
		listIndex = tagIDList[i];
		clickFunc(listIndex);
	    if(clickFunc == editListID) DIYListedit(i);
	}
	/**
	* 关闭面板
	*/
	public function close():void{
		cancelDIY();
		this.currentState = 'normal';
		this.area.removeAllChildren();	
		isAdding = false;
		PopUpManager.removePopUp(this);
		isOn = false ;
		
	}
	/**
	 * 新建列表
	 */
	public function addDIYlist():void{
	  	this.currentState = 'editing';
	  	this.editLabel.text = "新建列表";
	  	listIndex = -1;
	  	this.listName.text = "";
	  	isAdding = true;
	  	editListID(listIndex);
	}
	/**
	 * 取消编辑返回原状态
	 */
	public function back():void{
	  	cancelDIY();
	  	this.currentState = "";
	  	this.area.removeAllChildren();
	  	this.init();
	 }
	/**
	 * 完成编辑 
	 */
	public function completeDIYlist():void{
		if (isAdding) completeDIY(1);
		else completeDIY(0);
	}
	/**
	 * 编辑模式
	 */
	public function editDIYlist():void{
		this.currentState = 'deleting';
	  	this.textLabel.text = "请选择要编辑的列表";
	  	clickFunc = editListID;
	  	this.area.removeAllChildren();
	  	rpc.getDIYlist(onResultGetClass,userIndex);
	}
	/**
	 * 删除模式
	 */
	public function delDIYlist():void{
	  	this.currentState = 'deleting';
	  	clickFunc = delListID;
	  	this.area.removeAllChildren();
	  	rpc.getDIYlist(onResultGetClass,userIndex);
	}
	/**
	 * 跳转到编辑模式
	 */
	public function DIYListedit(listID:int):void{
		this.currentState = "editing";
		this.editLabel.text = "编辑列表";
		this.listName.text = tagList[listID];
		this.listIntro.text = ListDes[listID];
	}
	/**
	 * 点击删除
	 */
	public function delListID(listID:int):void{
		rpc.delDIYlist(onGetDel,listID);
	}
	/**
	 * 删除回调函数
	 */
	public function onGetDel(result:Boolean):void{
		if(result) {
			Alert.show("删除列表成功");
			this.area.removeAllChildren();
			rpc.getDIYlist(onResultGetClass,userIndex);
		}
		else Alert.show("服务器忙，请重试");
	}