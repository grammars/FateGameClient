package com.anstu.jui.skin
{
	import com.anstu.jui.controls.JScrollBar;
	import com.anstu.jui.define.JuiConst;

	public class JScrollBarSkin
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
		
		public var h_upBtn_default_cls:String = "Common_arrow_left_default.png";
		public var h_upBtn_over_cls:String = "Common_arrow_left_over.png";
		public var h_upBtn_down_cls:String = "Common_arrow_left_pressed.png";
		public var h_upBtn_disabled_cls:String = "Common_arrow_left_disabled.png";
		public var h_downBtn_default_cls:String = "Common_arrow_right_default.png";
		public var h_downBtn_over_cls:String = "Common_arrow_right_over.png";
		public var h_downBtn_down_cls:String = "Common_arrow_right_pressed.png";
		public var h_downBtn_disabled_cls:String = "Common_arrow_right_disabled.png";
		
		public var v_upBtn_default_cls:String = "Common_arrow_up_default.png";
		public var v_upBtn_over_cls:String = "Common_arrow_up_over.png";
		public var v_upBtn_down_cls:String = "Common_arrow_up_pressed.png";
		public var v_upBtn_disabled_cls:String = "Common_arrow_up_disabled.png";
		public var v_downBtn_default_cls:String = "Common_arrow_down_default.png";
		public var v_downBtn_over_cls:String = "Common_arrow_down_over.png";
		public var v_downBtn_down_cls:String = "Common_arrow_down_pressed.png";
		public var v_downBtn_disabled_cls:String = "Common_arrow_down_disabled.png";
		
		public var h_btns_width:int = 16;
		public var h_btns_height:int = 15;
		
		public var v_btns_width:int = 15;
		public var v_btns_height:int = 16;
		
		public function JScrollBarSkin()
		{
		}
		
		public function apply(scrollBar:JScrollBar):void
		{
			var sliderSkin:JScrollSliderSkin = new JScrollSliderSkin();
			sliderSkin.base_ns = base_ns;
			sliderSkin.h_background_cls = h_background_cls;
			sliderSkin.h_handle_default_cls = h_handle_default_cls;
			sliderSkin.h_handle_over_cls = h_handle_over_cls;
			sliderSkin.h_handle_down_cls = h_handle_down_cls;
			sliderSkin.h_handle_disabled_cls = h_handle_disabled_cls;
			sliderSkin.h_handle_face_cls = h_handle_face_cls;
			sliderSkin.v_background_cls = v_background_cls;
			sliderSkin.v_handle_default_cls = v_handle_default_cls;
			sliderSkin.v_handle_over_cls = v_handle_over_cls;
			sliderSkin.v_handle_down_cls = v_handle_down_cls;
			sliderSkin.v_handle_disabled_cls = v_handle_disabled_cls;
			sliderSkin.v_handle_face_cls = v_handle_face_cls;
			sliderSkin.handle_size = handle_size;
			sliderSkin.apply(scrollBar.scrollSlider);
			
			var upBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			upBtnSkin.base_ns = base_ns;
			var downBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			downBtnSkin.base_ns = base_ns;
			if(scrollBar.orientation == JuiConst.HORIZONTAL)
			{
				upBtnSkin.defaultBg_cls = h_upBtn_default_cls;
				upBtnSkin.overBg_cls = h_upBtn_over_cls;
				upBtnSkin.downBg_cls = h_upBtn_down_cls;
				upBtnSkin.disabledBg_cls = h_upBtn_disabled_cls;
				
				downBtnSkin.defaultBg_cls = h_downBtn_default_cls;
				downBtnSkin.overBg_cls = h_downBtn_over_cls;
				downBtnSkin.downBg_cls = h_downBtn_down_cls;
				downBtnSkin.disabledBg_cls = h_downBtn_disabled_cls;
				
				scrollBar.setUpDownBtnSize(h_btns_width, h_btns_height);
			}
			else
			{
				upBtnSkin.defaultBg_cls = v_upBtn_default_cls;
				upBtnSkin.overBg_cls = v_upBtn_over_cls;
				upBtnSkin.downBg_cls = v_upBtn_down_cls;
				upBtnSkin.disabledBg_cls = v_upBtn_disabled_cls;
				
				downBtnSkin.defaultBg_cls = v_downBtn_default_cls;
				downBtnSkin.overBg_cls = v_downBtn_over_cls;
				downBtnSkin.downBg_cls = v_downBtn_down_cls;
				downBtnSkin.disabledBg_cls = v_downBtn_disabled_cls;
				
				scrollBar.setUpDownBtnSize(v_btns_width, v_btns_height);
			}
			upBtnSkin.apply(scrollBar.upButton);
			downBtnSkin.apply(scrollBar.downButton);
			
			if(handle_size > 0) { scrollBar.fatSize = handle_size; }
		}
		
	}
}