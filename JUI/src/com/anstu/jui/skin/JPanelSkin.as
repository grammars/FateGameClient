package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JPanel;

	public class JPanelSkin
	{
		public var background_ns:String = "base";
		public var background_cls:String = "defaultPaneBg.png";
		public var background_opt:Object = null;
		
		public function JPanelSkin()
		{
		}
		
		public function apply(pane:JPanel):void
		{
			JResource.fill(pane.fillBackground, background_cls, background_ns, background_opt);
		}
		
	}
}