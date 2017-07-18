package com.anstu.jui.events
{
	import flash.events.Event;
	
	public class JBaseEvent extends Event
	{
		public static const DRAW:String = "JBaseEvent.DRAW";
		
		public function JBaseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function report():void
		{
			JReporter.instance.dispatchEvent(this);
		}
	}
}