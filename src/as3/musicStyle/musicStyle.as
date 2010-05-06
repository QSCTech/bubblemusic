/** 
 * 
 * 风格电台AS部分 
 */
    import Component.colorProgress;
    import Component.colorlbtn;
    
    import as3.Net.RPC;
    
    import flash.events.MouseEvent;
    
    import mx.controls.Alert;
    import mx.controls.Spacer;
    import mx.controls.Text;
    import mx.managers.PopUpManager; 
	    
    private var rpc:RPC = new RPC();
    [Bindable]
	public var index:int;
	public var userId:int;
	private var styleList:Array = new Array();
	private var stylePerList:Array = new Array();
	private var styleIdList:Array = new Array();
 	public var done:Function;   
    /**
	* 关闭面板
	*/
    public function close():void{
    	for(var i:int = 0;i<stylePerList.length;i++){
    		if(stylePerList[i]!=0)
    			break;
    	}
    	if(i==stylePerList.length){
    		for(i = 0;i<stylePerList.length;i++){
    			stylePerList[i] = 0.6;
    		}
    	}
    	
    	var styleText:String;
    
    	styleText = String(styleIdList[0]) + ":" + String(stylePerList[0]);	
    	for(i = 1;i<stylePerList.length;i++){
    		styleText += "," + String(styleIdList[i]) + ":" + String(stylePerList[i]);
    	}
    	rpc.updateUserStyle(onReturn, userId, styleText);
	}
	
	public function onReturn(result:Boolean):void{
		if(result){
			done();
			PopUpManager.removePopUp(this);
		}
		else
			Alert.show(">请重试<");
	}
	
	/**  
	 * 初始  
	 * 
	 */ 
	public function init():void{
		rpc = new RPC();
		rpc.getStyle(onGetStyle,userId);
	}
	
	public function onGetStyle(result:Array):void{
		var y:Number = 30;
		for(var i:int = 0;i<result.length;i++){
			styleList[i] = result[i].style_name;
			styleIdList[i] = result[i].style_id;
			stylePerList[i] = result[i].style_per;
			
			var lBtn:colorlbtn = new colorlbtn();
			lBtn.text = styleList[i];
			lBtn.index = i;
			lBtn.x = 15;
			lBtn.y = y; 
			lBtn.addEventListener(MouseEvent.CLICK,getStyleMusic);
			this.addChild(lBtn);
			
			var pro:colorProgress = new colorProgress();
			pro.index = i;
			pro.x = 80;
			pro.y = y; 
			pro.addEventListener(MouseEvent.CLICK,resetPer);
			this.addChild(pro);
			pro.percent.setProgress(stylePerList[i],1);
			
			y += 25;
		}
		var tip:Text = new Text();
		tip.text = "Bubble将按此比例为您推荐歌曲^^"
		tip.x = 10;
		tip.y = y;
		tip.styleName = "redText"
		this.addChild(tip);
		
		var spa:Spacer = new Spacer();
		spa.height = 5;
		spa.y = y + 25;
		this.addChild(spa);
	}
	
	public function resetPer(event:MouseEvent):void{
		var i:int = event.currentTarget.index;
		var pos:Number = event.currentTarget.percent.contentMouseX/event.currentTarget.percent.width;
		
		if(pos>=0 && pos<0.05)
			pos = 0;
		else{
			var value:int = pos * 10 / 2;
			pos = value/5 + 0.2;
		}
		
		event.currentTarget.percent.setProgress(pos,1);
		stylePerList[i] = pos;
	}
	public function getStyleMusic(event:MouseEvent):void{
		
	}