package ui.ctrls.uiEvent
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/** Render事件的基类 */
	public class RenderEvent extends Event
	{
		//-----------------------------------------------------------------------
		
		private var _data:Object = null ;
		
		public function set data(value:Object):void
		{
			_data = value ;
		}
		
		public function get data():Object
		{
			return _data ;
		}
		
		//-----------------------------------------------------------------------
		
		public function RenderEvent(type:String , data:Object = null)
		{
			super(type);
			this.data = data;
		}
		
		
		public function dispatch():Boolean
		{
			if(dispatcher != null)
			{
				return	dispatcher.dispatchEvent(this);
			}
			else
			{
				return false;
			}
		}
		
		
		protected function get dispatcher():IEventDispatcher
		{
			throw new Error(this + ':dispatcher方法需要被重写');
			return null;
		}
		
	}
}