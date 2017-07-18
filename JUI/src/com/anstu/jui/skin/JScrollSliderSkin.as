package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JScrollSlider;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;

	public class JScrollSliderSkin
	{
		
		public var base_ns:String = "default";
		
		public var h_background_cls:String = "ScrollBar_h_background.png";
		public var h_handle_default_cls:String = "ScrollBar_h_handle_default.png";
		public var h_handle_over_cls:String = "ScrollBar_h_handle_over.png";
		public var h_handle_down_cls:String = "ScrollBar_h_handle_pressed.png";
		public var h_handle_disabled_cls:String = "ScrollBar_h_handle_disabled.png";
		public var h_handle_face_cls:String = "ScrollBar_h_handle_face.png";
		
		public var v_background_cls:String = "ScrollBar_v_background.png";
		public var v_handle_default_cls:String = "ScrollBar_v_handle_default.png";
		public var v_handle_over_cls:String = "ScrollBar_v_handle_over.png";
		public var v_handle_down_cls:String = "ScrollBar_v_handle_pressed.png";
		public var v_handle_disabled_cls:String = "ScrollBar_v_handle_disabled.png";
		public var v_handle_face_cls:String = "ScrollBar_v_handle_face.png";
		
		public var handle_size:int = 15;
		
		public function JScrollSliderSkin(orientation:String=JuiConst.HORIZONTAL)
		{
			
		}
		
		public function apply(slider:JScrollSlider):void
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
				if(handle_size > 0) { slider.handle.height = handle_size; }
			}
			else
			{
				slider.fillBackground( JResource.getBmp(v_background_cls, base_ns) );
				
				handleSkin.defaultBg_cls = v_handle_default_cls;
				handleSkin.overBg_cls = v_handle_over_cls;
				handleSkin.downBg_cls = v_handle_down_cls;
				handleSkin.disabledBg_cls = v_handle_disabled_cls;
				handleSkin.face_cls = v_handle_face_cls;
				if(handle_size > 0) { slider.handle.width = handle_size; }
			}
			handleSkin.apply(slider.handle);
		}
	}
}