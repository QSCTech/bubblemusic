package as3.Net
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	public class RPC
	{
		private var conn:NetConnection;
	 //   private var URL:String = "http://10.76.8.200/bubble/amfphp/gateway.php";
		private var URL:String = "http://localhost/amfphp/gateway.php";
		
		public function RPC()
		{
			conn = new NetConnection();
			conn.objectEncoding = ObjectEncoding.AMF3;
		} 
		
		
		public function getMusicList(result:Function, arg:String):void{
			conn.connect(URL);
			conn.call("Music.getList",new Responder(result,onFault),arg);
			conn.close();
		}
		
		public function getSearchList(result:Function,a:String,b:String,c:int):void{
			conn.connect(URL);
		//	conn.call("Music.getSearchResult",new Responder(result,onFault),a,b,c);
			conn.call("Music.search",new Responder(result,onFault),a,b,c);
			conn.close();
		}
		public function getNextMusic(result:Function):void{
			conn.connect(URL);
			conn.call("Music.getNextMusic", new Responder(result,onFault));
			conn.close();
		}
		
		public function addComment(result:Function,musicid:int,comment:String,username:String):void{
			conn.connect(URL);
			conn.call("Music.addComment", new Responder(result,onFault),musicid,comment,username);
			conn.close();
		}
		
		public function getComment(result:Function,musicid:int,page:int):void{
			conn.connect(URL);
			conn.call("Music.getComment", new Responder(result,onFault),musicid,page);
			conn.close();
		}
		
		private function onFault(fault:String):void{
			trace(fault);
		}
		
		public function loginCheck(result:Function, username:String, userpw:String):void{
			conn.connect(URL);
			conn.call("Music.login",new Responder(result,onFault),username,userpw);
			conn.close();
		}

	}
}