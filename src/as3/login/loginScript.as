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

	public function onResult(result:Object):void{
		if(result.user_id > 0){
			if(callBack != null){
				callBack(result);                 

			}  
			this.close();
			flash.external.ExternalInterface.call("setUid", result.user_id);
		} 
		else if(result.user_id == -2){
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
	
	public function registerNew():void{ 
		this.close();
		if(register != null){
			register();                 
		}  	
	}