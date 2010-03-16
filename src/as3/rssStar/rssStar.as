/**  
 * 关注歌手部分AS 
 *     
 */ 
	import as3.Net.RPC;
	import mx.managers.PopUpManager; 
	
	[Bindable]
	public var text:String = "";
	[Bindable]
	public var text2:String = "";
	
	public function close():void{         
		PopUpManager.removePopUp(this);     
	}