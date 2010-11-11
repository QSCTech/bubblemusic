package as3.preloader
{
	import flash.display.Loader;  
	import flash.utils.ByteArray;  
	public class LoadInner extends Loader  
	{  
		[Embed(source="style/loading.jpg", mimeType="application/octet-stream")]    
		public var myLogoBMD:Class;    
		public function preLoader()  
		{  
			this.loadBytes(new myLogoBMD() as ByteArray);  
		}
	}
	
	import flash.display.MovieClip;  
	import flash.display.Sprite;  
	import flash.events.Event;    
	import flash.events.ProgressEvent;  
	import flash.geom.Rectangle;    
	import flash.utils.Timer;  
	import mx.events.FlexEvent;    
	import mx.preloaders.DownloadProgressBar;  
   
	public class MyPreloader extends DownloadProgressBar //Flex的加载进度条继承  
	{  
	    private var _loadInner:LoadInner;//进度条的图片  
	    private var _movieInner:Sprite;   //装进度条图片的影片  
        private var _preloader:Sprite;     //主要显示对象  
  
	    public function MyPreloader()     //在这里初始化，将对象加载到舞台  
	    {     
			this._loadInner = new LoadInner();  
			this._movieInner = new MovieClip();  
			this._totalWidth = this._movieInner.width;  
			this._movieInner.addChild(this._loadInner);  
			this.addChild(this._movieInner);  
			super();  
	    }  
    	
   		
    //在这里加入四个主要事件的侦听，而后分别在各个相应方法中加入自己的逻辑  
   override public function set preloader(value:Sprite):void{     
        _preloader = value     
         //加载进度   
        _preloader.addEventListener(ProgressEvent.PROGRESS,load_progress);   
         //加载完毕  
        _preloader.addEventListener(Event.COMPLETE,load_complete);  
         //初始化进度  
        _preloader.addEventListener(FlexEvent.INIT_PROGRESS,init_progress);   
         //初始化完毕    
        _preloader.addEventListener(FlexEvent.INIT_COMPLETE,init_complete);   
  
         //下面进行定位   
        
         this._movieInner.x = (stage.stageWidth - 400)/2+4;  
         this._movieInner.y = (stage.stageHeight - 100)/2+11;  
  
         //绘制背景  
         graphics.clear();     
         graphics.beginFill(0x000000);     
         graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);     
         graphics.endFill();     
                           
     }     
     //结束后删除侦听，这是好习惯  
     private function remove():void{     
         _preloader.removeEventListener(ProgressEvent.PROGRESS,load_progress);     
         _preloader.removeEventListener(Event.COMPLETE,load_complete);     
         _preloader.removeEventListener(FlexEvent.INIT_PROGRESS,init_progress);     
         _preloader.removeEventListener(FlexEvent.INIT_COMPLETE,init_complete);     
      }     
     //在加载过程中进行的方法  
     private function load_progress(e:ProgressEvent):void{     
          //计算加载进度  
          var ProNum:int = int(e.bytesLoaded/e.bytesTotal*100);  
          //根据加载进度来显示进度条的相应部分，在这里想多说一句：  
          //josh的博客里写用Timer来更新显示进度，但是那并不是必需的，在这里同样可以写  
          this._movieInner.scrollRect = new Rectangle(0,0,Math.ceil(387*ProNum/100),45);  
     }     
     //下面的我没有加入效果和逻辑，所以空着以后用  
     private function load_complete(e:Event):void{     
            
     }     
     private function init_progress(e:FlexEvent):void{     
             
     }     
    private function init_complete(e:FlexEvent):void{     
           dispatchEvent(new Event(Event.COMPLETE))     
     }     
  }
	
}