/**  
 * 心情AS部分  
 * 
 */          
	 
	import as3.Net.RPC;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
                 
	private var rpc:RPC = new RPC();
	private var index:int;
    public var moodResult:Array = new Array();
    public var callback:Function;
    
	[Bindable]
	public var text:String = "";
	[Bindable]
	public var usernameMood:String = "";
	[Bindable]
	public var userIdMood:int;
	
	/**  
	 * 初始  
	 * 
	 */ 
	public function init():void{
		rpc = new RPC();
		rpc.getComment(this.getMood,this.index,1);
	}
	

	/**  
	 * 得到歌曲id  
	 * 
	 */ 
	public function setIndex(index:int):void{
		this.index = index;
	}
	
	/**  
	 * 关闭popupmanager  
	 * 
	 */
	public function close():void{
	//	if(callBack != null){                         
	//		callBack(mood);                 
	//	}       
		PopUpManager.removePopUp(this);     
	}

	/**  
	 * 重置 
	 * 
	 */
	public function resetHandle():void{                 
		moodText.text = "";                  
	}
	
	/**  
	 * 得到下一页  
	 * 
	 */
	public function getNext():void{
		var page:int = int(pageText.text) + 1;
		
		rpc.getComment(this.getMood,this.index,page);
		pageText.text = String(page);
		moodSmall.play();
	}   
	
	/**  
	 * 得到上一页  
	 * 
	 */
	public function getPre():void{
		var page:int = int(pageText.text) - 1;
		
		rpc.getComment(this.getMood,this.index,page);
		pageText.text = String(page);
		moodSmall.play();
	}   
	
	/**  
	 * 添加心情 
	 * 
	 */
	public function addComment():void{
		if(moodText.text == "" || username.text == ""){
			Alert.show("请输入完整信息！");
		}
		else{
			rpc.addComment(this.getMood,this.index,moodText.text,userIdMood);
			resetHandle();
		}
	}                  
	public function addCredit(result:Object):void{
		callback(result.user_credit);
	}
	/**  
	 * 得到心情列表  
	 * 
	 */
	public function getMood(result:Array):void{
		rpc.getCredit(this.addCredit,userIdMood);
		this.moodResult = result;
		this.syncMoodList(moodResult);
	}
	
	/**  
	 * 初始化心情列表  
	 * 
	 */
	public function syncMoodList(list:Array):void{
		var page:int = int(pageText.text);

        if(page>9)
        	pageText.x = 378;
        else
            pageText.x = 383;
        
        if(list[8])
        	next.enabled = true;
        else 
        	next.enabled = false;
        	
        if(page>1)
        	pre.enabled = true;
        else 
        	pre.enabled = false;
        
        if(list[0]){
			t1.text = list[0].user;
			m1.toolTip = list[0].comment;
		} else { t1.text = ""; m1.toolTip = "";}
		if(list[1]){
			t2.text = list[1].user;
			m2.toolTip = list[1].comment;
		} else { t2.text = ""; m2.toolTip = "";}
		if(list[2]){
			t3.text = list[2].user;
			m3.toolTip = list[2].comment;
		} else { t3.text = ""; m3.toolTip = "";}
		if(list[3]){
			t4.text = list[3].user;
			m4.toolTip = list[3].comment;
		} else { t4.text = ""; m4.toolTip = "";}
		if(list[4]){
			t5.text = list[4].user;
			m5.toolTip = list[4].comment;
		} else { t5.text = ""; m5.toolTip = "";}
		if(list[5]){
			t6.text = list[5].user;
			m6.toolTip = list[5].comment;
		} else { t6.text = ""; m6.toolTip = "";}
		if(list[6]){
			t7.text = list[6].user;
			m7.toolTip = list[6].comment;
		} else { t7.text = ""; m7.toolTip = "";}
		if(list[7]){
			t8.text = list[7].user;
			m8.toolTip = list[7].comment;
		} else { t8.text = ""; m8.toolTip = "";}
		
		
	}