package as3.Net
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	public class RPC
	{
		private var conn:NetConnection;
	//	private var URL:String = "http://10.76.8.200/qsclab/music/amfphp/services/search_mp3.php";
		private var URL:String = "http://localhost/amfphp/gateway.php";
		
		public function RPC()
		{
			conn = new NetConnection();
			conn.objectEncoding = ObjectEncoding.AMF3;
		} 
		
		
		public function getMusicList(result:Function):void{
			conn.connect(URL);
			conn.call("Music.getList",new Responder(result,onFault));
			conn.close();
		}
		
		private function onFault(fault:String):void{
			trace(fault);
		}
		
		

	}
}