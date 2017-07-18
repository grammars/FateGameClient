package run.cd
{
	import central.Game;
	
	import comm.struct.cd.StCDInfo;
	
	import flash.events.Event;
	
	public class CDEvent extends Event
	{
		public static const UPDATE:String = "CDEvent.UPDATE";
		
		public var info:StCDInfo;
		
		public function CDEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static function dispatchUpdate(pInfo:StCDInfo):void
		{
			var event:CDEvent = new CDEvent(CDEvent.UPDATE);
			event.info = pInfo;
			Game.cd.dispatchEvent(event);
		}
		
	}
}