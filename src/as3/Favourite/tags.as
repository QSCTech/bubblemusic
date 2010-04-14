/**  
 * 心情AS部分  
 * 
 */          
	import Component.ClassVBox;
	import as3.Net.RPC;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
                 
	private var rpc:RPC = new RPC();
	public var userIndex:int;
	
	public function close():void{
		PopUpManager.removePopUp(this);
	}
	
	public function init():void{
		rpc.getUserClass(this.onGetClassResult,userIndex);
	}
	
	public function onGetClassResult(result:Array):void{
		
		
	}
	
	
	