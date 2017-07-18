package com.anstu.jcommon.log
{
	import flash.utils.getTimer;

	public class Log
	{
		public function Log()
		{
		}
		
		/** 日志等级
		 * OFF > FATAL > ERROR > WARN > INFO > DEBUG > ALL */
		private static var level:int = LogLevel.ALL;
		/** 设置日志等级[value enum from LogLevel.as]<br>
		 * OFF > FATAL > ERROR > WARN > INFO > DEBUG > ALL */
		public static function setLevel(value:int):void
		{
			level = value;
		}
		/** 获取日志等级 */
		public static function getLevel():int { return level; }
		
		/** 是否添加时间 */
		private static var addTime:Boolean = false;
		/** 设置是否添加时间 */
		public static function setAddTime(value:Boolean):void
		{
			addTime = value;
		}
		/** 获取是否添加时间 */
		public static function getAddTime():Boolean { return addTime; }
		
		/** 以ALL级别输出到控制台 */
		public static function print(...args):void
		{
			if(level >= LogLevel.ALL) { worker(args); }
		}
		
		/** 以DEBUG级别输出到控制台 */
		public static function debug(...args):void
		{
			if(level >= LogLevel.DEBUG) { worker(args); }
		}
		
		/** 以INFO级别输出到控制台 */
		public static function info(...args):void
		{
			if(level >= LogLevel.INFO) { worker(args); }
		}
		
		/** 以WARN级别输出到控制台 */
		public static function warn(...args):void
		{
			if(level >= LogLevel.WARN) { worker(args); }
		}
		
		/** 以ERROR级别输出到控制台 */
		public static function error(...args):void
		{
			if(level >= LogLevel.ERROR) { worker(args); }
		}
		
		/** 以FATAL级别输出到控制台 */
		public static function fatal(...args):void
		{
			if(level >= LogLevel.FATAL) { worker(args); }
		}
		
		/** I'am worker */
		private static function worker(...args):void
		{
			//var timestamp:String= addTime == true ? "["+new Date().time.toString()+"]" : "";
			var timestamp:String= addTime == true ? "["+getTimer()+"]" : "";
			trace(args, timestamp);
		}
		
	}
}