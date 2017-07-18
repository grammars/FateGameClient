package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;

	public class JSliderSkin
	{
		public var base_ns:String = "default";
		
		public var h_background_cls:String = "Slider_h_background.png";
		public var h_handle_default_cls:String = "Slider_h_handle_default.png";
		public var h_handle_over_cls:String = "Slider_h_handle_over.png";
		public var h_handle_down_cls:String = "Slider_h_handle_pressed.png";
		public var h_handle_disabled_cls:String = "Slider_h_handle_disabled.png";
		public var h_handle_face_cls:String = null;
		
		public var v_background_cls:String = "Slider_v_background.png";
		public var v_handle_default_cls:String = "Slider_v_handle_default.png";
		public var v_handle_over_cls:String = "Slider_v_handle_over.png";
		public var v_handle_down_cls:String = "Slider_v_handle_pressed.png";
		public var v_handle_disabled_cls:String = "Slider_v_handle_disabled.png";
		public var v_handle_face_cls:String = null;
		
		public var h_handle_width:int = 10;
		public var h_handle_height:int = 19;
		
		public var v_handle_width:int = 19;
		public var v_handle_height:int = 10;
		
		public function JSliderSkin(orientation:String=JuiConst.HORIZONTAL)
		{
			
		}
		
		public function apply(slider:JSlider):void
		{
			var handleSkin:JPushButtonSkin = new JPushButtonSkin();
			handleSkin.base_ns = base_ns;
			if(slider.orientation == JuiConst.HORIZONTAL)
			{
				slider.fillBackground( JResource.getBmp(h_background_cls, base_ns) );
				
				handleSkin.defaultBg_cls = h_handle_default_cls;
				handleSkin.overBg_cls = h_handle_over_cls;
				handleSkin.downBg_cls = h_handle_down_cls;
				handleSkin.disabledBg_cls = h_handle_disabled_cls;
				handleSkin.face_cls = h_handle_face_cls;
				slider.handle.setSize(h_handle_width, h_handle_height);
			}
			else
			{
				slider.fillBackground( JResource.getBmp(v_background_cls, base_ns) );
				
				handleSkin.defaultBg_cls = v_handle_default_cls;
				handleSkin.overBg_cls = v_handle_over_cls;
				handleSkin.downBg_cls = v_handle_down_cls;
				handleSkin.disabledBg_cls = v_handle_disabled_cls;
				handleSkin.face_cls = v_handle_face_cls;
				slider.handle.setSize(v_handle_width, v_handle_height);
			}
			handleSkin.apply(slider.handle);
		}
		
	}
}