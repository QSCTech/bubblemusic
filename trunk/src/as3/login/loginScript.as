/**  * 登录AS部分  *   */          
	import mx.controls.Alert;         
	import mx.managers.PopUpManager;  //登录         
	import as3.Net.RPC;     
	 
	public var callBack:Function;                  
	public var islogin:Boolean = false;  
	public var rpc:RPC = new RPC();
	    
	public function close():void{         
		PopUpManager.removePopUp(this);     
	}          
	
	public function dropIt(event:MouseEvent):void{       
		event.currentTarget.stopDrag();     
	}           
	
	public function dragIt(event:MouseEvent):void{       
		event.currentTarget.startDrag();     
	}                   
	
	public function loginHandle():void{                 
		if(txtUsername.text == "" || txtPassword.text == ""){                         
			Alert.show("请输入完整数据！");                 
		}                 
		else{                         
			rpc.loginCheck(callBack,txtUsername.text,txtPassword.text);                                         
		}         
	}                  

	public function resetHandle():void{                 
		txtUsername.text = "";                 
		txtPassword.text = "";         
	}                  
	
	public function onclose():void{                 
		if(callBack != null){                         
			callBack(txtUsername.text);                 
		}                 
		PopUpManager.removePopUp(this);         
	} 