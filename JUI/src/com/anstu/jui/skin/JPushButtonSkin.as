package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JPushButton;

	public class JPushButtonSkin
	{
		public var base_ns:String = "default";
		
		public var defaultBg_cls:String = "Button_default.png";//Button_default_shine.png
		public var overBg_cls:String = "Button_over.png";
		public var downBg_cls:String = "Button_pressed.png";
		public var disabledBg_cls:String = "Button_disabled.png";
		public var face_cls:String = null;
		
		public var labelFormat:JTextFormat = null;
		public var labelUseStroke:Boolean = true;
		public var labelStrokeColor:uint = 0x121212;
		
		public var width:int = -1;
		public var height:int = -1;
		
		public function JPushButtonSkin()
		{
		}
		
		public function apply(btn:JPushButton):void
		{
			JResource.fill( btn.fillDefaultBg, defaultBg_cls, base_ns );
			JResource.fill( btn.fillOverBg, overBg_cls, base_ns );
			JResource.fill( btn.fillDownBg, downBg_cls, base_ns );
			JResource.fill( btn.fillDisabledBg, disabledBg_cls, base_ns );
			if(face_cls)
			{
				JResource.fill( btn.fillFace, face_cls, base_ns );
			}
			if(width > 0)
			{
				btn.width = width;
			}
			if(height > 0)
			{
				btn.height = height;
			}
			if(labelFormat)
			{
				btn.label.textFormat = labelFormat;
			}
			btn.label.useStroke = labelUseStroke;
			btn.label.strokeColor = labelStrokeColor;
		}
		
	}
}