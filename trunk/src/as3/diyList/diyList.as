/**  
 * DIYList AS部分 
 *     
 */          
	import as3.Net.RPC;
	
	import mx.containers.HBox;
	import mx.controls.LinkButton;
	import mx.managers.PopUpManager; 
	
	public var rpc:RPC = new RPC();
	public var callBack:Function;
	public var regNew:Function;
	public var logNew:Function;
	public var allDiyResult:Array = new Array();
	
	public function init(user:String):void{
		rpc = new RPC();
		rpc.getAllList(this.getAll,user);	
	}
	
	public function close():void{         
		PopUpManager.removePopUp(this);     
	}
	
	/**  
	 * 得到所有DIY列表  
	 * 
	 */
	public function getAll(result:Array):void{
		this.allDiyResult = result;
		this.syncAllDiy(allDiyResult);
	}
	
	/**  
	 * 初始化所有DIY列表  
	 * 
	 */
	public function syncAllDiy(list:Array):void{
		var len:int = list.length;
		var i:int = 0;
		var wid:Number;
		var linkButton:LinkButton = new LinkButton();
		if(len == 0){
			this.currentState = "unlogined";
		}
		var hbox:HBox = new HBox();
		hbox.width = 360;
		allBox.addChild(hbox);
		for(i=0;i<len;i++){
			linkButton = new LinkButton();
			linkButton.label = list[i].name;
			linkButton.id = "d"+ String(i+1);
			linkButton.toolTip = list[i].id;
			wid = hbox.width;
			if(wid>360){
				hbox = new HBox();
				hbox.width = 360;
				allBox.addChild(hbox);
			}
			hbox.addChild(linkButton); 
		}
		
	}
	
	public function loginNew():void{ 
		this.close();
		if(logNew != null){
			logNew();                 
		}  	
	}
	public function registerNew():void{ 
		this.close();
		if(regNew != null){
			regNew();                 
		}  	
	}