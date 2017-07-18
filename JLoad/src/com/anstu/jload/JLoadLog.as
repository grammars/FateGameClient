package com.anstu.jload
{
	public class JLoadLog
	{
		public static var USE_LOG:Boolean = false;
		
		public function JLoadLog()
		{
		}
		
		public static function log(...args):void
		{
			if(USE_LOG)
			{
				trace("[JLoad]", args);
			}
		}
		
	}
}