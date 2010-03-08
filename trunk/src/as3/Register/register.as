/**  * 注册AS部分  *   */          
	import as3.Net.RPC;
	import mx.controls.Alert;
	import mx.managers.PopUpManager; 
	
	public var callBack:Function;  
	public var login:Function;      
	public var islogin:Boolean = false;  
	public var rpc:RPC = new RPC();
	
	public function close():void{         
		PopUpManager.removePopUp(this);     
	}
	
	public function registerHandle():void{                 
		if(username.text == "" || password.text == "" || passwordAgain.text == "" || email.text == ""){                         
			Alert.show("请输入完整数据！");                 
		} 
		else if(password.text != passwordAgain.text){
			Alert.show("两次输入的密码不一致，请重新输入！"); 
			resetPassword();
		}              
		else{                         
			rpc.registerCheck(onResult,username.text,password.text,email.text);                                         
		}         
	}
	
	public function onResult(result:String):void{
		if(result == "注册成功"){
			if(callBack != null){
				callBack(username.text);                 
			}  
			this.onclose();
		} 
		else if(result == "用户名存在"){
			Alert.show("对不起，该用户名已存在，请更改用户名！");
		}
		else{
			Alert.show("对不起，请填写内网邮箱！");
		}
	}
	
	public function resetHandle():void{                  
		username.text == "";
		password.text == "";
		passwordAgain.text == "";
		email.text == "";       
	} 
	public function resetPassword():void{                  
		password.text == "";
		passwordAgain.text == "";     
	} 
	
	public function onclose():void{                             
		PopUpManager.removePopUp(this);         
	} 
	
	public function loginNew():void{ 
		this.onclose();
		if(login != null){
			login();                 
		}  	
	}