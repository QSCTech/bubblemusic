/**
 * 登录AS部分
 * 
 */

	import Component.top;
	import Component.login;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;  //登录
    
   // public function initLoginListener():void{
	//	loginSub.addEventListener(MouseEvent.CLICK,loginHandle);
	//	loginReset.addEventListener(MouseEvent.CLICK,resetHandle);
	//	loginCancel.addEventListener(MouseEvent.CLICK,close);
	//}

	public var islogin:Boolean = false;

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
			if(txtUsername.text == "rosejay" && txtPassword.text == "bubble"){
				Alert.show("登录成功！");
				islogin = true;
			}
			else{
				Alert.show("用户名或密码错误！");
			}
		}
	}
	
	public function resetHandle():void{
		txtUsername.text = "";
		txtPassword.text = "";
	}
	
	
	
	
	