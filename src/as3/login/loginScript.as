/**  * 登录AS部分  *   */          
	import as3.Net.RPC;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;     
	
	public var callBack:Function;  
	public var register:Function;      
	public var islogin:Boolean = false;  
	public var rpc:RPC = new RPC();

	
	public function close():void{         
		PopUpManager.removePopUp(this);     
	}                         
	
	public function loginHandle():void{                 
		if(txtUsername.text == "" || txtPassword.text == ""){                         
			Alert.show("请输入完整数据！");                 
		}                 
		else{                         
			rpc.loginCheck(onResult,txtUsername.text,txtPassword.text);                                         
		}         
	}

	public function onResult(result:int):void{
		if(result > 0){
			if(callBack != null){
				callBack(txtUsername.text);                 
			}  
			this.onclose();
		} 
		else if(result == -2){
			Alert.show("密码不正确");
		}
		else{
			Alert.show("用户名不存在");
		}
	}

	public function resetHandle():void{                 
		txtUsername.text = "";                 
		txtPassword.text = "";         
	}                  
	
	public function onclose():void{                             
		PopUpManager.removePopUp(this);         
	} 
	
	public function registerNew():void{ 
		this.onclose();
		if(register != null){
			register();                 
		}  	
	}