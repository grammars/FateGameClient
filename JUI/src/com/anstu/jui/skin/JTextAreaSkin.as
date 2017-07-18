package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JTextArea;

	public class JTextAreaSkin
	{
		public var base_ns:String = "default";
		
		public var pane_default_cls:String = "Text_bg_default.png";
		public var pane_over_cls:String = "Text_bg_over.png";
		public var pane_uneditable_cls:String = "Text_bg_uneditable.png";
		
		public var scrollBarSkin:JScrollBarSkin = new JScrollBarSkin();
		
		public function JTextAreaSkin()
		{
		}
		
		public function apply(ta:JTextArea):void
		{
			ta.fillDefaultBg( JResource.getBmp(pane_default_cls, base_ns) );
			ta.fillOverBg( JResource.getBmp(pane_over_cls, base_ns) );
			ta.fillUneditableBg( JResource.getBmp(pane_uneditable_cls, base_ns) );
			
			scrollBarSkin.apply(ta.scrollbar);
		}
		
	}
}