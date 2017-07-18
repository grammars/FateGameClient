package ui.ctrls.Advanced.SelectList
{
	import ui.ctrls.uiEvent.EventController;
	import ui.ctrls.uiEvent.RenderEvent;
	
	import flash.events.IEventDispatcher;
	
	public class SelectListEvent extends RenderEvent
	{
		/** 下拉选项选中事件
		 * data.uiName
		 * data.index
		 * data.content */
		public static const SELECT_LIST_ITEM_CLICK:String = "selectListItemClick";
		
		public function SelectListEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		protected override function get dispatcher():IEventDispatcher
		{
			return EventController.instance();
		}
		
	}
}