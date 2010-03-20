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
		else if(email.text.substr(-10)!="zju.edu.cn"){
			Alert.show("请填写内网邮箱，谢谢合作!"); 
			resetEmail();
		}             
		else{                         
			rpc.registerCheck(onResult,username.text,password.text,email.text);                                         
		}         
	}
	
	public function onResult(result:int):void{
		if(result > 0){
			if(callBack != null){
				callBack(username.text);                 
			}  
			this.onclose();
		} 
		else if(result == -3){
			Alert.show("对不起，该用户名已存在，请注册其他用户名");
			resetHandle();
		}
		else if(result == -5){
			Alert.show("对不起，该email不允许被注册");
		}
		else if(result == -6){
			Alert.show("对不起，该email已被注册");
		}
		else{
			Alert.show(""+result);
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
	public function resetEmail():void{
		email.text == "";  
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