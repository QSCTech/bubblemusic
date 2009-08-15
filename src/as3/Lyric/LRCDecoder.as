package as3.Lyric
{
	public class LRCDecoder
	{
		public function LRCDecoder(){
		}
		public static function decoder(value:String):Array
		{
			var ar_reg:RegExp=/\[ar:[^\]]*]/si;//演唱者
			var al_reg:RegExp=/\[al:[^\]]*]/si;//专辑名
			var by_reg:RegExp=/\[by:[^\]]*]/si;//歌词作者
			var ti_reg:RegExp=/\[ti:[^\]]*]/si;//作曲名
			var offset_reg:RegExp=/\[offset:[^\]]*]/si;//时间补偿
			var lyric_reg:RegExp=/[^\r]+\r/sg;//歌词
			var time_reg:RegExp=/\d{1,2}:\d{1,2}(\.\d{1,3})?/sg;//歌词时间
			
			var result:Object=new Object();//临时返回数据
			var lrc:Array = new Array();//全部信息：歌词信息+歌词
			var info:String=new String();//歌词信息
			var timeOffset:Number=0;//时间延迟(可为正或负)
			
			value = value.replace(/[\r\n]+/sg, "\r");//清除多余换行
			value = "\r" + value + "\r";
			value = value.replace(/\[:\][^\r]*\r/sg, "");//清除注释
			
			/*
			获取歌词info数据
			*/
/*			info.ar=getInfo(value,ar_reg);
			info.al=getInfo(value,al_reg);
			info.by=getInfo(value,by_reg);
			info.ti=getInfo(value,ti_reg);
			result=getInfo(value,offset_reg);
			if(result){
				timeOffset=Number(result);
			}
			lrc.push({time:timeOffset,lrc:info});*/
			
			result=getInfo(value,ar_reg);
			if(result)info=result.toString();
			result=getInfo(value,al_reg);
			if(result)info+="  "+result.toString();
			result=getInfo(value,by_reg);
			if(result)info+="  "+result.toString();
			result=getInfo(value,ti_reg);
			if(result)info+="  "+result.toString();
			result=getInfo(value,offset_reg);
			if(result)timeOffset=Number(result);
			lrc.push({time:timeOffset,lrc:info});
			
			//获取歌词部分
			result = lyric_reg.exec(value);
			while(result) {
				var item:String = result.toString();
				
				var contentStr:String = item.substr(item.lastIndexOf("]") + 1, item.length);
				contentStr = contentStr.replace(/^\s+/sg, "");
				contentStr = contentStr.replace(/\s+$/sg, "");
				
				var timeRegObj:Object = time_reg.exec(item);
				while(timeRegObj) {
					var timeStr:String = timeRegObj[0].toString();
					var time:Number = Number(timeStr.substring(0, timeStr.indexOf(":"))) * 60 * 1000;
					time += Number(timeStr.substr(timeStr.indexOf(":") + 1, timeStr.length)) * 1000;
					lrc.push({time:time + timeOffset, lrc:contentStr});
					
					timeRegObj = time_reg.exec(item);
				}
				
				result = lyric_reg.exec(value);
            }

			lrc.sort(sortByTime);
			return lrc;
			
			function getInfo(str:String,reg:RegExp):String{
				var resultString:String;
				var resultObject:Object=reg.exec(str);
				if (resultObject) {
					resultString = resultObject.toString();
					return resultString.substring(resultString.indexOf(":") + 1, resultString.indexOf("]"));
				}
				return null;
			}
			function sortByTime(a:Object, b:Object):Number {
				if(a.time > b.time) {
					return 1;
				} else {
				return -1;
				}
			}
		}
	}
}