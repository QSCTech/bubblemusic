/**  
 * 登录AS部分  
 * 
 */          
	 
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
    import mx.controls.Text;
    
    public var callBack:Function;                  
	public var islogin:Boolean = false; 
    
	[Bindable]
	public var text:String = "";
	
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