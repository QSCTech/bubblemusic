package as3.PlayControl
{
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import Component.playerTop;
	
	public class playControl
	{
		import flash.media.Sound;
		import flash.media.SoundChannel;
		import flash.media.SoundTransform;
		import flash.media.ID3Info;
		

		
		private var pasPos:Number;
		private var music:Sound;
		public var channel:SoundChannel;
		public var isPlay:Boolean;
		private var nextMusic:Function;
		public var progressPos:Number;
		private static var temp:Number; 
		

		
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
		public function newPlay(musicFile:String):void{
			if(isPlay){
				//music.close();
				channel.stop();
				isPlay = false;
			}
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
				channel.addEventListener(Event.SOUND_COMPLETE,nextMusic);
			}
		}
		
		/**
		 * 调整音量
		 */
		
		public function setNextMusic(next:Function):void{
			this.nextMusic = next;
		}
		
		
		
		public function changeSoundSize(value:Number):void   {    
			var transform:SoundTransform = channel.soundTransform;  
			transform.volume = value;
			channel.soundTransform = transform;   
		}
		
		public function progressSet():void{
			 progressPos = channel.position/music.length;
		}
		
		public function fadeSound(value:Number):void{   
			var transform:SoundTransform = channel.soundTransform; 
			if(isPlay){
				temp = channel.soundTransform.volume; 
				var i:Number = temp/20;
				transform.volume -= i;
				
			}
			else{
				transform.volume = value;
			}
			channel.soundTransform = transform;
			if(transform.volume <= 0){
					this.pausePlay();
				}
		}
		
	}
}