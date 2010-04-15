/** * 收藏AS部分 * */
    import Component.ClassVBox;
    
    import as3.Net.RPC;
    
    import flash.events.MouseEvent;
    
    import mx.controls.Alert;
    import mx.managers.PopUpManager;  
   
    public var callBack:Function;
    public var userIndex:int;
    public var musicIndex:int;
    [Bindable]
    public var musicName:String;

	public var rpc:RPC = new RPC();
	[Bindable]
	private var classList:Array = new Array();  //保存用户tags
	private var Vboxes:Array = new Array();  //保存当前歌曲tags数组
	private var tagNum:int = 0;
	public var stored:Function;
	
	/**
	* 关闭面板
	*/
	public function close():void{
		PopUpManager.removePopUp(this);
	}
	
	/**
	* 判断歌曲是否被收藏过
	*/
	public function checkFavMusic(musicID:int, userID:int):void{
		rpc.checkUserFav(onCheckFavResult,musicID,userID);
	}
	/**
	* 判断歌曲是否被收藏过返回函数
	*/
	public function onCheckFavResult(result:Array):void{
		if(result[0]!=""){
			isStored.text = "您已收藏过该歌曲,可以修改或添加保存的tags~";
			for(var count:int = 1; count < result.length; count++){
				var vbox:ClassVBox = new ClassVBox();
				vbox.text = result[count];
				tags.addChild(vbox);
				vbox.addEventListener(MouseEvent.ROLL_OVER,showBtn);
				vbox.addEventListener(MouseEvent.ROLL_OUT,hideBtn);
				vbox.littleClassDelete.addEventListener(MouseEvent.CLICK,deleteClass);
				Vboxes[tagNum] = result[count];
				tagNum++;
				vbox.index = tagNum;
			}
		}
		else{
			isStored.text = "为歌曲添加0-3个tag，以便于您管理您收藏的音乐~";
		}
	}
	
	/**
	* 得到用户已有的tags
	*/
	public function getFavouriteClass(userID:int):void{
		rpc.getUserFavTag(onResultGetClass,userID);
	}
	/**
	* 得到用户已有的tags返回函数，布局在combox下
	*/
	public function onResultGetClass(result:Array):void{
		var count:int;
		for(count=0;count<result.length;count++){
			classList[count]=result[count].playlist_name;
		}
	}

	/**
	* 添加tag
	*/
	public function addClass():void{
		if(txtClassName.text != "" && tagNum < 3){
			var count:int = 0;
			for(count = 0;count<=tagNum;count++)
				if(txtClassName.text == Vboxes[count]){
					Alert.show("此tag已添加~");
					txtClassName.selectedIndex = -1;
					break;
				}	
				
			if(count > tagNum){
				var vbox:ClassVBox = new ClassVBox();
				vbox.text = txtClassName.text;
				tags.addChild(vbox);
				vbox.addEventListener(MouseEvent.ROLL_OVER,showBtn);
				vbox.addEventListener(MouseEvent.ROLL_OUT,hideBtn);
				vbox.littleClassDelete.addEventListener(MouseEvent.CLICK,deleteClass);
				Vboxes[tagNum] = txtClassName.text;
				tagNum++;
				vbox.index = tagNum;
				txtClassName.selectedIndex = -1;
			}	
		}
		else if(txtClassName.text == "")
			Alert.show("请输入tag后再添加~");  
		else 
			Alert.show("对不起，最多只能对同一首歌添加3个tag");  
	}
	
	/**
	* 删除tag
	*/
	public function deleteClass(event:MouseEvent):void{
		tags.removeChild(event.currentTarget.parent);
		var i:int = event.currentTarget.parent.index - 1;
		for(i; i<tagNum;i++)
			Vboxes[i] = Vboxes[i+1];
		tagNum--;
 	}
 	
	/**
	* 显示删除按钮
	*/
 	private function showBtn(event:MouseEvent):void{
 		event.currentTarget.littleClassDelete.visible = true;
 	}
 	/**
	* 隐藏删除按钮
	*/
 	private function hideBtn(event:MouseEvent):void{
 		event.currentTarget.littleClassDelete.visible = false;
 	}
 	
 	/**
	* 添加用户收藏歌曲
	*/
	public function addFavouriteHandle():void{
		var tags:String = "";
		for(var i:int = 0;i<Vboxes.length-1;i++){
			tags += Vboxes[i] + ",";
		}
		tags = tags + Vboxes[i];
		rpc.addUserFav(onAddFavResult,musicIndex,userIndex,tags);
	}
	/**
	* 添加用户收藏歌曲返回函数
	*/
	public function onAddFavResult(result:Boolean):void{
		if (result){
			stored("收藏成功^^");
   	    	this.close();
		}
		else Alert.show("对不起><正在泡音乐的人太多了,请重试^^");
	}
	
