package com.anstu.jui.components
{
	public class StListItemData implements ICaption
	{
		public var data:Object;
		
		public function StListItemData(caption:String="", data:Object=null)
		{
			this.caption = caption;
			this.data = data;
		}
		
		protected var _caption:String = "";
		public function set caption(c:String):void
		{
			_caption = c;
		}
		public function get caption():String { return _caption; }
		
	}
}