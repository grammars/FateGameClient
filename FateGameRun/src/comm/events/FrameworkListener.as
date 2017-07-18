package comm.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="FrameworkEvent.CFG_LOADED", type="comm.events.FrameworkEvent")]
	public class FrameworkListener extends EventDispatcher
	{
		private static var instance:FrameworkListener;
		public static function getInstance():FrameworkListener
		{
			if(instance == null) { instance = new FrameworkListener(); }
			return instance;
		}
		
		public function FrameworkListener(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/** 配置加载完成事件 */
		public function cfgLoaded():void
		{
			var event:FrameworkEvent = new FrameworkEvent(FrameworkEvent.CFG_LOADED);
			this.dispatchEvent(event);
		}
		
	}
}