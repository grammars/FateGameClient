package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JScrollPanel;

	public class JScrollPanelSkin
	{
		public var base_ns:String = "base";
		
		public var background_cls:String = "transparant.png";
		
		public var scrollBarSkin:JScrollBarSkin = new JScrollBarSkin();
		
		public function JScrollPanelSkin()
		{
		}
		
		public function apply(sp:JScrollPanel):void
		{
			sp.fillBackground( JResource.getBmp(background_cls, base_ns) );
			scrollBarSkin.apply(sp.hScrollbar);
			scrollBarSkin.apply(sp.vScrollbar);
		}
		
	}
}