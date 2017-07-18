package gamekit.map.events
{
	import flash.events.Event;
	
	public class MapEvent extends Event
	{
		/** 点击了地图层 */
		public static const CLICK:String = "MapEvent.CLICK";
		/** 地图切换 */
		public static const CHANGE:String = "MapEvent.CHANGE";
		
		/** 点击了阻碍点 */
		public var clickBlock:Boolean = false;
		/** 点击地图的像素x位置 */
		public var clickPx:int = 0;
		/** 点击地图的像素y位置 */
		public var clickPy:int = 0;
		/** 点击地图的格子x位置 */
		public var clickGx:int = 0;
		/** 点击地图的格子y位置 */
		public var clickGy:int = 0;
		
		public function MapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}