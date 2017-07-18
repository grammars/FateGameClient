package gamekit.map.events
{
	import flash.events.Event;
	
	import gamekit.map.material.MapConfig;
	
	public class MapConfigEvent extends Event
	{
		/** 被完整部署了 */
		public static const FULL_DONE:String = "MapConfigEvent.FULL_DONE";
		
		public var config:MapConfig;
		
		public function MapConfigEvent(type:String, config:MapConfig, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.config = config;
		}
		
		public static function dispatchMapConfigFullDone(cfg:MapConfig):void
		{
			var event:MapConfigEvent = new MapConfigEvent(FULL_DONE, cfg);
			MapMonitor.getInstance().dispatchEvent(event);
		}
	}
}