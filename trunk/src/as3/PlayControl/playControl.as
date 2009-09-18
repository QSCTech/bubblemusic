package as3.PlayControl
{
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class playControl
	{
		import flash.media.Sound;
		import flash.media.SoundChannel;
		import flash.media.SoundTransform;
	//	import flash.media.ID3Info;
		
		private var pasPos:Number;
		private var music:Sound;
		public var channel:SoundChannel;
		public var isPlay:Boolean;
		private var nextMusic:Function;
		
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
		
		public function onTimer(value:Number):void   {    
			var a:Number = value / music.length;    
			
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
		
	/*	public function changePosition(value:Number):void   {    
			
			pasPos = music.length * value;
			channel.position = pasPos;
		}
*/
		
	}
}