/**  
 * 登录AS部分  
 * 
 */          
	 
	import as3.Net.RPC;
	
	import mx.managers.PopUpManager;
    import mx.controls.Alert;
                 
	private var rpc:RPC;
	private var index:int;
    public var moodResult:Array = new Array();
    public var callBack:Function;
    
	[Bindable]
	public var text:String = "";
	
	public function init():void{
		rpc = new RPC();
		rpc.getComment(this.getMood,this.index,1);
	}
	public function setIndex(index:int):void{
		this.index = index;
	}
	
	public function close():void{
	//	if(callBack != null){                         
	//		callBack(mood);                 
	//	}       
		PopUpManager.removePopUp(this);     
	}
	
	public function dropIt(event:MouseEvent):void{       
		event.currentTarget.stopDrag();     
	}           
	
	public function dragIt(event:MouseEvent):void{       
		event.currentTarget.startDrag();     
	}                                    
	
	public function resetHandle():void{                 
		moodText.text = "";                 
		username.text = "";         
	}
	
	public function getNext():void{
		var page:int = int(pageText.text) + 1;
		
		rpc.getComment(this.getMood,this.index,page);
		pageText.text = String(page);
		moodNext.play();
	}   
	
	public function getPre():void{
		var page:int = int(pageText.text) - 1;
		
		rpc.getComment(this.getMood,this.index,page);
		pageText.text = String(page);
		moodPre.play();
	}   
	
	public function addComment():void{
		if(moodText.text == "" || username.text == ""){
			Alert.show("请输入完整信息！");
		}
		else{
			rpc.addComment(this.getMood,this.index,moodText.text,username.text);
			moodText.text = "";                 
			username.text = "";  
		}
	}                  
	
	public function getMood(result:Array):void{
		this.moodResult = result;
		this.syncMoodList(moodResult);
	}
	
	public function syncMoodList(list:Array):void{
		var page:int = int(pageText.text);
        
        
        if(page>9)
        	pageText.x = 363;
        else
            pageText.x = 368;
        
        if(list[9])
        	next.enabled = true;
        else 
        	next.enabled = false;
        	
        if(page>1)
        	pre.enabled = true;
        else 
        	pre.enabled = false;
        	
		if(list[0]){
			m1.username.text = list[0].user;
			m1.comment.text = list[0].comment;
		} else { m1.username.text = ""; m1.comment.text = "";}
		if(list[1]){
			m2.username.text = list[1].user;
			m2.comment.text = list[1].comment;
		} else { m2.username.text = ""; m2.comment.text = "";}
		if(list[2]){
			m3.username.text = list[2].user;
			m3.comment.text = list[2].comment;
		} else { m3.username.text = ""; m3.comment.text = "";}
		if(list[3]){
			m4.username.text = list[3].user;
			m4.comment.text = list[3].comment;
		} else { m4.username.text = ""; m4.comment.text = "";}
		if(list[4]){
			m5.username.text = list[4].user;
			m5.comment.text = list[4].comment;
		} else { m5.username.text = ""; m5.comment.text = "";}
		if(list[5]){
			m6.username.text = list[5].user;
			m6.comment.text = list[5].comment;
		} else { m6.username.text = ""; m6.comment.text = "";}
		if(list[6]){
			m7.username.text = list[6].user;
			m7.comment.text = list[6].comment;
		} else { m7.username.text = ""; m7.comment.text = "";}
		if(list[7]){
			m8.username.text = list[7].user;
			m8.comment.text = list[7].comment;
		} else { m8.username.text = ""; m8.comment.text = "";}
		if(list[8]){
			m9.username.text = list[8].user;
			m9.comment.text = list[8].comment;
		} else { m9.username.text = ""; m9.comment.text = "";}
	}