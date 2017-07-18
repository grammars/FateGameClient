package com.anstu.jload.past
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.system.ApplicationDomain;

	public class LoadResult
	{
		/** 加载完成的字节 */
		public var bytesLoaded:Number;
		/** 总共需要加载的字节数 */
		public var bytesTotal:Number;
		/** 应用程序域 */
		public var domain:ApplicationDomain;
		/** 显示对象 */
		public var content:DisplayObject;
		/** 数据 */
		public var data:*;
		
		/** 携带的参数 */
		public var args:*;
		
		public function LoadResult()
		{
		}
	}
}