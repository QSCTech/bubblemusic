package as3.Net
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import mx.controls.Alert;
	
	public class RPC
	{
		private var conn:NetConnection;

		//private var URL:String = "http://www.qsc.zju.edu.cn/apps/bubble/amfphp/gateway.php";

		//private var URL:String = "http://10.76.8.200/bubble/amfphp/gateway.php";
		private var URL:String = "http://localhost/amfphp/gateway.php";

		public function RPC()
		{
			conn = new NetConnection();
			conn.objectEncoding = ObjectEncoding.AMF3;
		} 
		
		
		public function getMusicList(result:Function, arg:String,userId:int):void{
			conn.connect(URL);
			conn.call("Music.getList",new Responder(result,onFault),arg,userId);
			conn.close();
		}
		
		public function getSearchList(result:Function,a:String,b:String,c:int):void{
			conn.connect(URL);
		//	conn.call("Music.getSearchResult",new Responder(result,onFault),a,b,c);
			conn.call("Music.search",new Responder(result,onFault),a,b,c);
			conn.close();
		}
		public function getNextMusic(result:Function,num:int,userId:int):void{
			conn.connect(URL);
			conn.call("Music.getNextMusic", new Responder(result,onFault),num,userId);
			conn.close();
		}
		
		public function addComment(result:Function,musicid:int,comment:String,userid:int):void{
			conn.connect(URL);
			conn.call("Music.addComment", new Responder(result,onFault),musicid,comment,userid);
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
		public function autoLogin(result:Function, uid:String):void{
			conn.connect(URL);
			conn.call("Music.autoLogin", new Responder(result, onFault), uid);
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

		public function getSpecial(result:Function):void{
			conn.connect(URL);
			conn.call("Music.getSubject",new Responder(result,onFault));
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


	
		public function checkUserFav(result:Function,musicIndex:int,userIndex:int):void{
			conn.connect(URL);
			conn.call("Music.checkUserFav",new Responder(result,onFault),musicIndex,userIndex);
			conn.close();
		}
		
		public function getUserFavTag(result:Function,userIndex:int):void{
			conn.connect(URL);
			conn.call("Music.getUserFavTag",new Responder(result,onFault),userIndex);
			conn.close();
		}
		
		public function getUserFavArtists(result:Function,userID:int):void{
			conn.connect(URL);
			conn.call("Music.getUserFavArtists",new Responder(result,onFault),userID);
			conn.close();
		}
		
		public function addUserFav(result:Function,musicIndex:int,userIndex:int,tags:String):void{
			conn.connect(URL);
			conn.call("Music.addUserFav",new Responder(result,onFault),musicIndex,userIndex,tags);
			conn.close();
		}
		
		public function getUserFavourite(result:Function,userIndex:int,page:int):void{
			conn.connect(URL);
			conn.call("Music.getUserFav",new Responder(result,onFault),userIndex,page);
			conn.close();
		}
		
		public function getUserClassMusic(result:Function,userIndex:int,page:int,classIndex:int):void{
		    conn.connect(URL);
			conn.call("Music.getUserFav",new Responder(result,onFault),userIndex,page,classIndex);
			conn.close();
		}
		
		public function getUserSingerMusic(result:Function,userIndex:int,page:int,classIndex:int,authorID:int):void{
		    conn.connect(URL);
			conn.call("Music.getUserFav",new Responder(result,onFault),userIndex,page,classIndex,authorID);
			conn.close();
		}
		
		public function delUserFav(result:Function,musicIndex:int,userIndex:int):void{
			conn.connect(URL);
			conn.call("Music.delUserFav",new Responder(result,onFault),musicIndex,userIndex);
			conn.close();
		}
		
		public function delFavouriteClass(result:Function,classIndex:int):void{
			conn.connect(URL);
			conn.call("Music.delPlaylist",new Responder(result,onFault),classIndex);
			conn.close();
		}
		public function delClassMusic(result:Function,classIndex:int,musicIndex:int):void{
			conn.connect(URL);
			conn.call("Music.delPlaylistMusic",new Responder(result,onFault),classIndex,musicIndex);
			conn.close();
		}
	
		public function addUserListen(result:Function,userid:int,songid:int):void{
			conn.connect(URL);
			conn.call("Music.addUserListen",new Responder(result,onFault),userid,songid);
			conn.close();
		}
		
		public function addUserDelete(result:Function,userid:int,songid:int):void{
			conn.connect(URL);
			conn.call("Music.addUserDelete",new Responder(result,onFault),userid,songid);
			conn.close();
		}
		
		public function getUserListened(result:Function,userid:int,page:int):void{
			conn.connect(URL);
			conn.call("Music.getUserListen",new Responder(result,onFault),userid,page);
			conn.close();
		}
		
		public function getCredit(result:Function,userid:int):void{
			conn.connect(URL);
			conn.call("Music.getUserInfo",new Responder(result,onFault),userid);
			conn.close();
		}
		
		public function getStyle(result:Function,userid:int):void{
			conn.connect(URL);
			conn.call("Music.getStyle",new Responder(result,onFault),userid);
			conn.close();
		}
		
		public function updateUserStyle(result:Function,userid:int,styleText:String):void{
			conn.connect(URL);
			conn.call("Music.updateUserStyle",new Responder(result,onFault),userid,styleText);
			conn.close();
		}
	}
}