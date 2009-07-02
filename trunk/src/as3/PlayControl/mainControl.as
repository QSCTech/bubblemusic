package as3.PlayControl
{
	import flash.net.URLRequest;
	
	import mx.containers.VBox;
	import Component.playerSongs;
	import Component.playerSongs2;
	
	public class mainControl
	{
		import flash.media.Sound;
		import flash.media.SoundChannel;
		
		private var pasPos:Number;
		private var music:Sound;
		private var channel:SoundChannel;
		private var isPlay:Boolean;
		private var musicList:VBox;
		
		/**
		 * 进行初始化操作
		 */
		public function mainControl(musicList:VBox)
		{
			pasPos = 0;
			music = new Sound();
			channel = new SoundChannel();
			isPlay = false;
			this.musicList = musicList;
		}
		

		/**
		 * 播放新的音乐
		 * @param musicFile 要播放的音乐的路径
		 * 
		 */
		public function newPlay(musicFile:String,nextFile:String):void{
			music.load(new URLRequest(musicFile));
			channel = music.play(0);
			isPlay = true;
		}
		
		/**
		 *暂停播放操作 
		 * 
		 */
		public function pausePlay():void{
			if(isPlay){
				pasPos = channel.position;
				channel.stop();
				isPlay = false;
			}
		}
		
		/**
		 *继续播放当前音乐 
		 * 
		 */
		public function pursuePlay():void{
			if(!isPlay){
				channel = music.play(pasPos);
				isPlay = true;
			}
		}
		musicList.removech
	}
}