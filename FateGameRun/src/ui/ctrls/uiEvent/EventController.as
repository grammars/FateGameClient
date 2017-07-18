package ui.ctrls.uiEvent
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class EventController extends EventDispatcher
	{
		//-------------------------------------------------------------------------
		
		private static var _instance:EventController;
		
		public static function instance():EventController
		{
			if(_instance == null)
			{
				_instance = new EventController();
			}
			return _instance ;
		}
		
		//-------------------------------------------------------------------------
		
		public function EventController(target:IEventDispatcher=null)
		{
			super(target);
		}
		
	}
}