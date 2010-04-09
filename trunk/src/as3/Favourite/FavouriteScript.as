/** * 收藏AS部分 * */
    import Component.ClassVBox;
    
    import as3.Net.RPC;
    
    import flash.events.MouseEvent;
    
    import mx.controls.Alert;
    import mx.managers.PopUpManager;  
   
    public var callBack:Function;
    public var userIndex:int;
    public var musicIndex:int;
    public var musicName:String;
    public var music:Object = null;
    public var i:int;
    public var rpc:RPC = new RPC();
    private var ClassList:Array = new Array();
    private var classIndex:int = -1; 
    private var Vboxes:Array = new Array();
    private var musicList:Array = new Array();
    
        
   
   public function close():void{
   	  music = null;
   	  PopUpManager.removePopUp(this);
   }
   /**
   * 收藏歌曲
   */
   public function addFavourite(classID:int,musicID:int):void{
   	  rpc.addClassMusic(onResult,classID,musicID);
   }
   /**
   * 添加,删除分类
   */
    public function addFavouriteClass(userID:int,className:String):void{
   	  rpc.addFavouriteClass(onResultAddClass,userID,className);
   }
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
   * 获取歌曲id
   */
   public function setIndex(index:int):void{
		this.musicIndex = index;
   }
   /**
   * 双击将歌曲加入播放列表
   */
   public function chooseMusic(event:MouseEvent):void{
   	  i = event.currentTarget.index;
   	  musicIndex = musicList[i].id;
   	  music = musicList[i];
   	  callBack(music);
   }
   /**
   * 从分类中删除歌曲
   */
   public function deleteMusic(event:MouseEvent):void{
   	 i = event.currentTarget.parent.index
     musicIndex = musicList[i].id;
     rpc.delClassMusic(delResult,ClassList[classIndex]["playlist_id"],musicIndex)
   }
   /**
   * 返回分类列表
   */
   public function returnToClasslist():void{
   	  this.currentState = "classList";
   	  clr();
   	  showClass();
   }
   public function addFavouriteHandle():void{
   	    if(classIndex == -1) Alert.show("请选择分类！");
   	     else  this.addFavourite(ClassList[classIndex]["playlist_id"],musicIndex);
   }
   public function addClass():void{
   	  if(!txtClassName.text == ""){
   	     
         addFavouriteClass(userIndex,txtClassName.text);
         txtClassName.text = "" ;
        }
      else Alert.show("类别名不能为空!")        
   }
   
   public function deleteClass(event:MouseEvent):void{
   	 var target:Object = event.currentTarget.parent ;
   	 var count:int = target.index;
   	 var i:int = target.index;
   	 this.delFavouriteClass(ClassList[count]["playlist_id"]); 	 
   } 
   public function getClassMusic(classID:int):void{
   	 rpc.getClassMusic(onResultGet,classID);
   }
   
   /**
   * 获取收藏分类
   */
   public function getFavouriteClass(userID:int):void{
   	 rpc.getFavouriteClass(onResultGetClass,userID);
   }
  
   public function getClassListHandle():void{
   	 this.getFavouriteClass(userIndex);
   }
   /**
   * 返回函数
   */
   public function onResult(result:Boolean):void{
   	    if (!result) {
   	      Alert.show("收藏歌曲成功");
   	      this.close();
   	    }
   	    else Alert.show("服务器忙,请重试");
   }
   public function onResultGetClass(result:Object):void{
   	  clr();
   	  ClassList.splice(0);
   	  ClassList = result.slice(0);
   	  showClass();
   }
   public function onResultGet(result:Object):void{
   	  clr();
   	  musicList.splice(0);
   	  musicList = result.slice(0);
   	  showMusic(); 
   }
   public function onResultAddClass(result:int):void{
   	    if (result) {
   	      Alert.show("添加分类成功");
   	      this.getFavouriteClass(userIndex);
   	    }
   	    else Alert.show("服务器忙,请重试");
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
    public function showClass():void{
    	var count:int;
   	    for( count=0;count<ClassList.length;count++){
   	  	 var vbox:ClassVBox = new ClassVBox();
         vbox.x = 10;
         vbox.y = 40+20*count;
         this.height += 20;
         this.addChild(vbox);
         vbox.text.text = ClassList[count]["playlist_name"];
         vbox.index = count;
         Vboxes[count] = vbox;
         vbox.littleClassDelete.addEventListener(MouseEvent.CLICK,deleteClass);
         if(this.name == "collectFavourite")
             vbox.addEventListener(MouseEvent.CLICK,chooseClass);
         else 
         	 vbox.addEventListener(MouseEvent.CLICK,showMusicList);
          }
     }
     public function showMusic():void{
    	var count:int;
   	    for( count=0;count<musicList.length;count++){
   	  	 var vbox:ClassVBox = new ClassVBox();
         vbox.x = 10;
         vbox.y = 40+20*count;
         this.height += 20;
         this.addChild(vbox);
         vbox.text.text = musicList[count].title+"-"+musicList[count].author
         vbox.index = count;
         Vboxes[count] = vbox;
             vbox.littleClassDelete.addEventListener(MouseEvent.CLICK,deleteMusic);
             vbox.addEventListener(MouseEvent.DOUBLE_CLICK,chooseMusic);
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
   	  Vboxes.splice(0);
   	}