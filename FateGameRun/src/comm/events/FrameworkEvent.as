package comm.events
{
	import flash.events.Event;
	
	public class FrameworkEvent extends Event
	{
		/** 配置表文件已下载完成 */
		public static const CFG_LOADED:String = "FrameworkEvent.CFG_LOADED";
		
		public function FrameworkEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}