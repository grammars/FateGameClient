package com.anstu.jcommon.utils
{
	import flash.net.LocalConnection;

	/** 垃圾回收请求类 */
	public class GCUtil
	{
		public function GCUtil()
		{
		}
		
		/** 试图运行一次垃圾回收
		 * 相对于FP自己自动回收，这是相对主动的做法 */
		public static function run():void
		{
			try
			{
				new LocalConnection().connect("PleaseGC");
				new LocalConnection().connect("PleaseGC");
			}
			catch(error : Error)
			{
				trace("成功尝试主动运行一次垃圾回收");
			}
		}
		
	}
}