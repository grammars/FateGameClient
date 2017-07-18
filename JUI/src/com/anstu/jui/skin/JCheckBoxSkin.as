package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JCheckBox;

	public class JCheckBoxSkin
	{
		public var base_ns:String = "default";
		
		public var unselected_default_cls:String = "CheckBox_default.png";
		public var unselected_over_cls:String = "CheckBox_over.png";
		public var unselected_down_cls:String = "CheckBox_pressed.png";
		public var unselected_disabled_cls:String = "CheckBox_disabled.png";
		
		public var selected_default_cls:String = "CheckBox_default_selected.png";
		public var selected_over_cls:String = "CheckBox_over_selected.png";
		public var selected_down_cls:String = "CheckBox_pressed_selected.png";
		public var selected_disabled_cls:String = "CheckBox_disabled_selected.png";
		
		public var width:int = 13;
		public var height:int = 13;
		
		public var unselected_labelFormat:JTextFormat = null;
		public var selected_labelFormat:JTextFormat = null;
		
		public var labelUseStroke:Boolean = true;
		
		public function JCheckBoxSkin()
		{
		}
		
		public function apply(cb:JCheckBox):void
		{
			var unselectedSkin:JPushButtonSkin = new JPushButtonSkin();
			unselectedSkin.base_ns = base_ns;
			unselectedSkin.defaultBg_cls = unselected_default_cls;
			unselectedSkin.overBg_cls = unselected_over_cls;
			unselectedSkin.downBg_cls = unselected_down_cls;
			unselectedSkin.disabledBg_cls = unselected_disabled_cls;
			unselectedSkin.labelFormat = unselected_labelFormat;
			unselectedSkin.labelUseStroke = labelUseStroke;
			unselectedSkin.apply(cb.unselectedBtn);
			
			var selectedSkin:JPushButtonSkin = new JPushButtonSkin();
			selectedSkin.base_ns = base_ns;
			selectedSkin.defaultBg_cls = selected_default_cls;
			selectedSkin.overBg_cls = selected_over_cls;
			selectedSkin.downBg_cls = selected_down_cls;
			selectedSkin.disabledBg_cls = selected_disabled_cls;
			selectedSkin.labelFormat = selected_labelFormat;
			selectedSkin.labelUseStroke = labelUseStroke;
			selectedSkin.apply(cb.selectedBtn);
			
			if(width > 0 && height > 0)
			{
				cb.setSize(width, height);
			}
		}
		
	}
}