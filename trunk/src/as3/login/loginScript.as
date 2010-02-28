/**  * 登录AS部分  *   */          
	import as3.Net.RPC;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;     
	 
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
			rpc.loginCheck(onResult,txtUsername.text,txtPassword.text);                                         
		}         
	}

	public function onResult(result:Boolean):void{
		if(result == true){
			this.onclose();
		} else {
			Alert.show("用户名或密码错误");
		}
	}

	public function resetHandle():void{                 
		txtUsername.text = "";                 
		txtPassword.text = "";         
	}                  
	
	public function onclose():void{                 
		if(callBack != null){
			Alert.show("asdf");
			callBack(txtUsername.text);                 
		}                 
		PopUpManager.removePopUp(this);         
	} 