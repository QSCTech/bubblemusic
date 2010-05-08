/**  
 * 专题AS部分  
 * 
 */          
	 
	import as3.Net.RPC;
	
	import flash.events.MouseEvent;
	
	import mx.managers.PopUpManager;
                 
	private var rpc:RPC;
    public var specialResult:Array = new Array();	
	public var callback:Function;  
	private var specialId:int;
	private var specialName:String;
	
	/**  
	 * 关闭popupmanager  
	 * 
	 */
	public function close():void{  
		PopUpManager.removePopUp(this);     
	}
	
	/**  
	 * 初始  
	 * 
	 */ 
	public function init():void{
		rpc = new RPC();
		rpc.getSpecial(this.getSpecial);
		
	}
	
	/**  
	 * 得到专题列表  
	 * 
	 */
	public function getSpecial(result:Array):void{
		this.specialResult = result;
		this.syncSpecialList(specialResult);
	}
	/**
	* 得到字符串实际长度 一个中文as“XX”
	*/
	private function getStrActualLen(str:String):int{  
		return str.replace(/[^\x00-\xff]/g,"xx").length;  
	}
	
	public function getSpecialMusicList(event:MouseEvent):void{
		var i:int = event.currentTarget.index;
		specialId = specialResult[i].id;
		specialName = specialResult[i].name;
		rpc.getSpecialMusic(this.callSpecial,specialId);
		  
	}
	public function callSpecial(result:Array):void{
		if(callback != null){
			callback(result,specialName);                 
		}
	}
	/**  
	 * 初始化专题列表  
	 * 
	 */
	public function syncSpecialList(result:Array):void{
		var x:Number = 10;
		var y:Number = 30;
		var sum:Number = 10;
		for(var i:int = 0;i<result.length;i++){
			var lBtn:linkBtn = new linkBtn();
			lBtn.text = result[i].name;
			lBtn.index = i;
			lBtn.toolTip = result[i].description;
			lBtn.addEventListener(MouseEvent.CLICK,callSpecial);
			var len:int = getStrActualLen(result[i].name) * 8;
			lBtn.width = len;
			sum = sum + len;
			if(sum>380){
				x = 10;
				y = y + 20;
				lBtn.x = 10;
				lBtn.y = y; 
				this.addChild(lBtn);
				sum = 10 + len;
				x = sum;
			}
			else{
				lBtn.x = x;
				lBtn.y = y;
				this.addChild(lBtn);
				x = sum;
			}
		}
	}