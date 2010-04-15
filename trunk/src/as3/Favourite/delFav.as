/** 
 * 
 * 删除收藏AS部分 
 */
    import as3.Net.RPC;
    import mx.managers.PopUpManager;
    import mx.controls.Alert;
    
    public var userIndex:int;
    public var musicIndex:int;
    [Bindable]
    public var musicName:String;
    public var callback:Function;
    public var rpc:RPC = new RPC();
    
    /**
	* 关闭面板
	*/
    public function close():void{
		PopUpManager.removePopUp(this);
	}
	
	/**
	* 确定删除
	*/
	public function delFavHandle():void{
		rpc.delUserFav(onDelFavResult,musicIndex,userIndex);
	}
	/**
	* 确定删除返回函数
	*/
	public function onDelFavResult(result:Boolean):void{
		if(result){
			callback("删除成功^^");
   	    	this.close();
		}
		else 
			Alert.show("对不起><正在泡音乐的人太多了,请重试^^");
	}
     
     
     