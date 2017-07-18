package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JText;

	public class JTextSkin
	{
		public var base_ns:String = "default";
		
		public var pane_default_cls:String = "Text_bg_default.png";
		public var pane_over_cls:String = "Text_bg_over.png";
		public var pane_uneditable_cls:String = "Text_bg_uneditable.png";
		
		public function JTextSkin()
		{
		}
		
		public function apply(text:JText):void
		{
			text.fillDefaultBg( JResource.getBmp(pane_default_cls, base_ns) );
			text.fillOverBg( JResource.getBmp(pane_over_cls, base_ns) );
			text.fillUneditableBg( JResource.getBmp(pane_uneditable_cls, base_ns) );
		}
		
	}
}