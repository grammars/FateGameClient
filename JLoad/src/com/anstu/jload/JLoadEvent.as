package com.anstu.jload
{
	import flash.events.Event;
	
	public class JLoadEvent extends Event
	{
		/** 任务队列执行完毕 */
		public static const FINISH:String = "FINISH";
		/** 任务进度事件 */
		public static const PROGRESS:String = "PROGRESS";
		
		/** 当前速度[Byte/ms]=[KB/s] */
		public var speed:Number = 0;
		
		public function JLoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}