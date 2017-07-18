package gamekit.utils
{
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class Utils
	{
		public function Utils()
		{
		}
		
		/** 当前绝对时间 */
		public static function now():Number
		{
			return new Date().time;
		}
		
		/** 世界绝对时间 */
		public static function timestamp():Number
		{
			return new Date().time;
		}
		
		/** 打印出ByteArray的当前位置之后的所有字节 */
		public static function dumpBytes(bytes:ByteArray, needTrace:Boolean=true):String
		{
			if(bytes == null) { return "bytes=>{null}"; }
			var position:uint = bytes.position;
			var debugStr:String = "";
			while(bytes.bytesAvailable > 0)
			{
				var bt:int = bytes.readByte();
				debugStr += bt + "_";
			}
			if(needTrace) { trace(debugStr); }
			bytes.position = position;
			return debugStr;
		}
		
	}
}