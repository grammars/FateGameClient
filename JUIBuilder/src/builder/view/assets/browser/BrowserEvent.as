package builder.view.assets.browser
{
	import builder.view.assets.AssetsNode;
	
	import flash.events.Event;
	
	public class BrowserEvent extends Event
	{
		public static const PIC_SELECT:String = "BrowserEvent::PIC_SELECT";
		
		public var node:AssetsNode;
		
		public function BrowserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/** 触发图片选择事件 */
		public static function trigPicSelect(picNode:AssetsNode):void
		{
			var event:BrowserEvent = new BrowserEvent(PIC_SELECT);
			event.node = picNode;
			AssetsBrowser.instance.dispatchEvent(event);
		}
		
	}
}