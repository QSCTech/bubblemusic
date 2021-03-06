package as3.PlayControl
{
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
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
		public var volume:Number;
		public var pos:Number;
		
		/**
		 * 进行初始化操作
		 */
		public function playControl()
		{
			pasPos = 0;
			isPlay = false;
			volume = 0.7;
		}
		

		/**
		 * 播放新的音乐
		 * @param musicFile 要播放的音乐的路径
		 * 
		 */
		public function newPlay(musicFile:String):void{
			if(isPlay){
				channel.stop();
				isPlay = false;
			}
			music = new Sound();
			music.load(new URLRequest(musicFile));
			channel = music.play(0);
			channel.addEventListener(Event.SOUND_COMPLETE,nextMusic);
			var soundTransform:SoundTransform = new SoundTransform();
			soundTransform.volume = volume;
			channel.soundTransform = soundTransform;
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
				pos = pasPos/music.length;
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
		
		
		public function setNextMusic(next:Function):void{
			this.nextMusic = next;
		}
		
		/**
		 * 调整音量
		 */
		
		public function changeSoundSize(value:Number):void   {    
			var transform:SoundTransform = channel.soundTransform;  
			transform.volume = value;
			volume = value;
			channel.soundTransform = transform;
		}
		
		public function progressSet():void{
			 progressPos = channel.position/ (music.length / music.bytesLoaded * music.bytesTotal);
		}
		
		public function fadeSound(value:Number):void{  
			var i:Number = value/15;
			if(isPlay){
				var transform:SoundTransform = channel.soundTransform; 
				transform.volume -= i;
				channel.soundTransform = transform;
			}
		}
		public function fadeSoundIn(value:Number):void{
			var transform:SoundTransform = channel.soundTransform;
			if(!isPlay){
				this.pursuePlay();
				transform.volume = 0;
			}
			var i:Number = value/15;
			transform.volume += i;
			channel.soundTransform = transform;
		}
		public function fadePause(event:Event):void{
			this.pausePlay();
		}
		public function setPos(value:Number):void{
			 if(isPlay){
			   this.pausePlay();
			   pasPos = value*music.length;
			   this.pursuePlay();
			 }
			 else{
			   pasPos = value*music.length;
			   this.pursuePlay();
			   this.pausePlay();
			 }
		}
		
	}
}