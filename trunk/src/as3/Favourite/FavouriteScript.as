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
    public var music:Object = null;
    public var rpc:RPC = new RPC();
    [Bindable]
    private var ClassList:Array = new Array();
    private var classIndex:int = -1; 
    private var Vboxes:Array = new Array();
    private var musicList:Array = new Array();
    private var tagNum:int = 0;

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
		rpc.checkFavMusic(onCheckFavResult,musicID,userID);
	}
	public function onCheckFavResult(result:Array):void{
		if(result[0]==0){
			isStored.text = "可以为歌曲添加0-3个tag，以便于您管理您收藏的音乐吧~";
		}
		else{
			Alert.show("此tag已添加~");
			isStored.text = "您已收藏过该歌曲,可以修改或添加保存的tags~";
			for(var count:int = 1; result[count]!=""; count++){
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
	}
	
	/**
	* 得到用户已有的tags
	*/
	public function getFavouriteClass(userID:int):void{
		rpc.getFavouriteClass(onResultGetClass,userID);
	}
	public function onResultGetClass(result:Array):void{
		clr();
		ClassList.splice(0);
		var count:int;
		for(count=0;count<result.length;count++){
			ClassList[count]=result[count].playlist_name;
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
		rpc.addFavMusic(onAddFavResult,musicIndex,userIndex,Vboxes);
	}
	/**
	* 添加用户收藏歌曲回调函数
	*/
	public function onAddFavResult(result:Boolean):void{
		if (result){
			Alert.show("收藏歌曲成功");
   	    	this.close();
		}
		else Alert.show("对不起><正在泡音乐的人太多了,请重试^^");
	}
	
////////////////////////////////// 	
	
   
    public function delFavouriteClass(classID:int):void{
   	  rpc.delFavouriteClass(onResultDelClass,classID);
   	}
   /**
   * 选择分类
   */
    public function chooseClass(event:MouseEvent):void{
    	classIndex = event.currentTarget.index;
    	for each(var box:ClassVBox in Vboxes ) box.currentState = "unchoosed"
    	event.currentTarget.currentState = "choosed";
    }
   /**
   * 展开分类中的歌曲
   */
    public function showMusicList(event:MouseEvent):void{
    	classIndex = event.currentTarget.index;
    	this.currentState = "musicList" ;
    	clr();
    	getClassMusic(ClassList[classIndex]["playlist_id"]);
    }
    
  
   /**
   * 返回分类列表
   */
   public function returnToClasslist():void{
   	  this.currentState = "classList";
   	  clr();

   }
   
   
	
	public function addFavourite(classID:int,musicID:int):void{
		
	}
   
   
	
	public function onResultAddClass(result:int):void{
		if (result) {
			Alert.show("添加分类成功");
			this.getFavouriteClass(userIndex);
		}
		else Alert.show("对不起><服务器超负荷运作中,请重试^^");
	}
   
	 
   public function getClassMusic(classID:int):void{
   	 rpc.getClassMusic(onResultGet,classID);
   }
   
   /**
   * 获取收藏分类
   */
   
  
   public function getClassListHandle():void{
   	 this.getFavouriteClass(userIndex);
   }
    /**
    * 返回函数
    */
	
	
   public function onResultGet(result:Object):void{
   	  clr();
   	  musicList.splice(0);
   	  musicList = result.slice(0);
   	  showMusic(); 
   }
  
	public function onResultDelClass(result:int):void{
		if (result) {
			Alert.show("删除分类成功");
			this.getFavouriteClass(userIndex);
		}
		else Alert.show("服务器忙,请重试");
	}
   public function delResult(result:Boolean):void{
   	    if (result) {
   	      Alert.show("删除分类成功");
   	      this.getClassMusic(ClassList[classIndex]["playlist_id"]);
   	    }
   	    else Alert.show("服务器忙,请重试");
   }
/**
 * 显示列表函数
 */

	
	
     public function showMusic():void{
    	var count:int;
   	    for( count=0;count<musicList.length;count++){
   	  	 var vbox:ClassVBox = new ClassVBox();
         
         vbox.index = count;
         Vboxes[count] = vbox;
          }
     }
 /**
 * 清除列表函数
 */
    public function clr():void{
   	  musicList.splice(0);
   	  for each (var box:ClassVBox in Vboxes){
   	  	box.littleClassDelete.removeEventListener(MouseEvent.CLICK,deleteClass);
   	  	this.height -= 20;
   	  	this.removeChild(box);
   	  }
   	 
   	}