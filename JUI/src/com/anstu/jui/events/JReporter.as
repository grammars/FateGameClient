package com.anstu.jui.events
{
	import flash.events.EventDispatcher;

	[Event(name="JFrameEvent.ACTIVE", type="com.anstu.jui.events.JFrameEvent")]
	public class JReporter extends EventDispatcher
	{
		private static var _instance:JReporter;
		public static function get instance():JReporter
		{
			if(_instance == null) { _instance = new JReporter(); }
			return _instance;
		}
		
		public function JReporter()
		{
		}
		
		
		
	}
}