/**  
 * 专题AS部分  
 * 
 */          
	 
	import as3.Net.RPC;
	
	import mx.managers.PopUpManager;
    import mx.controls.Alert;
                 
	private var rpc:RPC;
    public var specialResult:Array = new Array();

   
	/**  
	 * 初始  
	 * 
	 */ 
	public function init():void{
		rpc = new RPC();
		rpc.getSpecial(this.getSpecial,1);
		
	}
	
	/**  
	 * 关闭popupmanager  
	 * 
	 */
	public function close():void{  
		PopUpManager.removePopUp(this);     
	}

	/**  
	 * 得到下一页  
	 * 
	 */
	public function getNext():void{
		var page:int = int(pageText.text) + 1;
		
		rpc.getSpecial(this.getSpecial,page);
		pageText.text = String(page);
		specialNext.play();
	}   
	
	/**  
	 * 得到上一页  
	 * 
	 */
	public function getPre():void{
		var page:int = int(pageText.text) - 1;
		
		rpc.getSpecial(this.getSpecial,page);
		pageText.text = String(page);
		specialPre.play();
	}   
	
	/**  
	 * 得到专题列表  
	 * 
	 */
	public function getSpecial(result:Array):void{
		this.specialResult = result;
		this.syncSpecialList(specialResult);
	}
	
	/**  
	 * 初始化专题列表  
	 * 
	 */
	public function syncSpecialList(list:Array):void{
		var page:int = int(pageText.text);

        if(page>9)
        	pageText.x = 101;
        else
            pageText.x = 106;
        
        if(list[8])
        	next.enabled = true;
        else 
        	next.enabled = false;
        	
        if(page>1)
        	pre.enabled = true;
        else 
        	pre.enabled = false;
        
        if(list[0]){
			s1.label = list[0].name;
			s1.toolTip = list[0].description;
		} else { s1.label = ""; s1.toolTip = "";}
		if(list[1]){
			s2.label = list[0].name;
			s2.toolTip = list[1].description;
		} else { s2.label = ""; s2.toolTip = "";}
		if(list[2]){
			s3.label = list[0].name;
			s3.toolTip = list[2].description;
		} else { s3.label = ""; s3.toolTip = "";}
		if(list[3]){
			s4.label = list[0].name;
			s4.toolTip = list[3].description;
		} else { s4.label = ""; s4.toolTip = "";}
		if(list[4]){
			s5.label = list[0].name;
			s5.toolTip = list[4].description;
		} else { s5.label = ""; s5.toolTip = "";}
		if(list[5]){
			s6.label = list[0].name;
			s6.toolTip = list[5].description;
		} else { s6.label = ""; s6.toolTip = "";}
		if(list[6]){
			s7.label = list[0].name;
			s7.toolTip = list[6].description;
		} else { s7.label = ""; s7.toolTip = "";}
		if(list[7]){
			s8.label = list[0].name;
			s8.toolTip = list[7].description;
		} else { s8.label = ""; s8.toolTip = "";}
		
		
	}