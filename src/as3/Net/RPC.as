package as3.Net
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	public class RPC
	{
		private var conn:NetConnection;
	//    private var URL:String = "http://10.76.8.200/bubble/amfphp/gateway.php";
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
		public function getNextMusic(result:Function,num:int):void{
			conn.connect(URL);
			conn.call("Music.getNextMusic", new Responder(result,onFault),num);
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
		public function autoLogin(result:Function, sid:String):void{
			conn.connect(URL);
			conn.call("Music.autoLogin", new Responder(result, onFault), sid);
			conn.close();
		}
		public function loginCheck(result:Function, username:String, userpw:String):void{
			conn.connect(URL);
			conn.call("Music.login",new Responder(result,onFault),username,userpw);
			conn.close();
		}
		public function registerCheck(result:Function, username:String, userpw:String, userem:String):void{
			conn.connect(URL);
			conn.call("Music.register",new Responder(result,onFault),username,userpw,userem);
			conn.close();
		}

		public function getSpecial(result:Function, page:int):void{
			conn.connect(URL);
			conn.call("Music.getSubject",new Responder(result,onFault),page);
			conn.close();
		}
		public function getSpecialMusic(result:Function, id:int):void{
			conn.connect(URL);
			conn.call("Music.getSubjectMusic",new Responder(result,onFault),id);
			conn.close();
		}
		public function getNotes(result:Function):void{
			conn.connect(URL);
			conn.call("Music.getNotice",new Responder(result,onFault));
			conn.close();
		}
		
		public function getAllList(result:Function,username:String):void{
			conn.connect(URL);
			conn.call("Music.getAllDiyList",new Responder(result,onFault),username);
			conn.close();
		}
		
		public function addUserListen(result:Function,userid:Number,songid:int):void{
			conn.connect(URL);
			conn.call("Music.addUserListen",new Responder(result,onFault),userid,songid);
			conn.close();
		}
		
		public function addUserDelete(result:Function,userid:Number,songid:int):void{
			conn.connect(URL);
			conn.call("Music.addUserDelete",new Responder(result,onFault),userid,songid);
			conn.close();
		}
		
		public function getUserListen(result:Function,userid:Number,page:int):void{
			conn.connect(URL);
			conn.call("Music.getUserListen",new Responder(result,onFault),userid,page);
			conn.close();
		}
		
	}
}