package as3.PlayControl
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class playControl
	{
		import flash.media.Sound;
		import flash.media.SoundChannel;
		
		private var pasPos:Number;
		private var music:Sound;
		private var channel:SoundChannel;
		private var isPlay:Boolean;
		
		/**
		 * 进行初始化操作
		 */
		public function playControl()
		{
			pasPos = 0;
			channel = new SoundChannel();
			isPlay = false;
		}
		

		/**
		 * 播放新的音乐
		 * @param musicFile 要播放的音乐的路径
		 * 
		 */
		public function newPlay(musicFile:String,nextMusic:Function):void{
			music = new Sound();
			music.load(new URLRequest(musicFile));
			channel = music.play(0);
			channel.addEventListener(Event.SOUND_COMPLETE,nextMusic);
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
		
	}
}