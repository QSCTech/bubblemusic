package as3.Net
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	public class RPC
	{
		private var conn:NetConnection;
        
		private var URL:String = "http://www.qsc.zju.edu.cn/apps/bubble/_amfphp/gateway.php";

		//private var URL:String = "http://localhost/amfphp/gateway.php";
		//private var URL:String = "http://localhost/Bubble/amfphp/gateway.php";

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
			conn.call("User.autoLogin", new Responder(result, onFault), uid);
			conn.close();
		}
		public function loginCheck(result:Function, username:String, userpw:String):void{
			conn.connect(URL);
			conn.call("User.login",new Responder(result,onFault),username,userpw);
			conn.close();
		}
		public function registerCheck(result:Function, username:String, userpw:String, userem:String):void{
			conn.connect(URL);
			conn.call("User.register",new Responder(result,onFault),username,userpw,userem);
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
		
		public function addUserFav(result:Function,musicIndex:int,userIndex:int):void{
			conn.connect(URL);
			conn.call("Music.addUserFav",new Responder(result,onFault),musicIndex,userIndex);
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
		
		
		public function getUserMsg(result:Function,userid:int,page:int):void{
			conn.connect(URL);
			conn.call("User.getUserMsg",new Responder(result,onFault),userid,page);
			conn.close();
		}
		public function getUserSendedMsg(result:Function,userid:int,page:int):void{
			conn.connect(URL);
			conn.call("User.getUserSendedMsg",new Responder(result,onFault),userid,page);
			conn.close();
		}
		public function checkMsg(result:Function,msgid:int,userid:int,page:int):void{
			conn.connect(URL);
			conn.call("User.checkMsg",new Responder(result,onFault),msgid,userid,page);
			conn.close();
		}
		public function delMsg(result:Function,msgid:String,userid:int,page:int):void{
			conn.connect(URL);
			conn.call("User.delMsg",new Responder(result,onFault),msgid,userid,page);
			conn.close();
		}
		public function delSendedMsg(result:Function,msgid:String,userid:int,page:int):void{
			conn.connect(URL);
			conn.call("User.delSendedMsg",new Responder(result,onFault),msgid,userid,page);
			conn.close();
		}
		public function delMsgAll(result:Function,userid:int):void{
			conn.connect(URL);
			conn.call("User.delMsgAll",new Responder(result,onFault),userid);
			conn.close();
		}
		public function delSendedMsgAll(result:Function,userid:int):void{
			conn.connect(URL);
			conn.call("User.delSendedMsgAll",new Responder(result,onFault),userid);
			conn.close();
		}
		
		public function getMsgBody(result:Function,msgid:int,userid:int):void{
			conn.connect(URL);
			conn.call("User.getMsgBody",new Responder(result,onFault),msgid,userid);
			conn.close();
		}
		public function getUserMsgUnCheck(result:Function,userid:int):void{
			conn.connect(URL);
			conn.call("User.getUserMsgUnCheck",new Responder(result,onFault),userid);
			conn.close();
		}
		public function sendMsg(result:Function,userid:int,to_username:String, msghead:String, msgbody:String):void{
			conn.connect(URL);
			conn.call("User.sendMsg",new Responder(result,onFault), userid, to_username, msghead, msgbody);
			conn.close();
		}
		public function getDIYlist(result:Function,userID:int):void{
			conn.connect(URL);
			conn.call("Music.getPlaylist",new Responder(result,onFault),userID);
			conn.close();
		}
		public function getDIYlistMusic(result:Function,listID:int):void{
			conn.connect(URL);
			conn.call("Music.getPlaylistMusic",new Responder(result,onFault),listID);
			conn.close();
		}
		public function addDIYlist(result:Function,userID:int,listName:String,listIntro:String):void{
			conn.connect(URL);
			conn.call("Music.addPlaylist",new Responder(result,onFault),userID,listName,listIntro);
			conn.close();
		}
		public function delDIYlist(result:Function,listID:int):void{
			conn.connect(URL);
			conn.call("Music.delPlaylist",new Responder(result,onFault),listID);
			conn.close();
		}
		public function updateDIYlist(result:Function,listID:int,list:String):void{
			conn.connect(URL);
			conn.call("Music.updatePlaylistMusic",new Responder(result,onFault),listID,list);
            conn.close();
		}
		public function updateListName(result:Function,listID:int,listName:String):void{
			conn.connect(URL);
			conn.call("Music.updatePlaylistName",new Responder(result,onFault),listID,listName);
			conn.close();
		}
		public function updateListdes(result:Function,listID:int,listDes:String):void{
			conn.connect(URL);
			conn.call("Music.updatePlaylistDescription",new Responder(result,onFault),listID,listDes);
			conn.close();
		}
	}
		
}