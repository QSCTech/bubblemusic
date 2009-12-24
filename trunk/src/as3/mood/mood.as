/**  
 * 登录AS部分  
 * 
 */          
	 
	import as3.Net.RPC;
	
	import mx.managers.PopUpManager;
    
    public var callBack:Function;                  
	public var islogin:Boolean = false; 
	private var rpc:RPC;
	private var index:String;
    
	[Bindable]
	public var text:String = "";
	
	public function init():void{
		rpc = new RPC();
		rpc.getComment(this.getMood,this.index);
	}
	public function setIndex(index:String):void{
		this.index = index;
	}
	
	public function close():void{         
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
/*	
	public function onclose():void{                 
		if(callBack != null){                         
			callBack(txtUsername.text);                 
		}                 
		PopUpManager.removePopUp(this);         
	} */
	
	private function getMood(result:Array):void{
		
	}