package com.anstu.jui.skin
{
	public class JRadioButtonSkin extends JCheckBoxSkin
	{
		public function JRadioButtonSkin()
		{
			super();
			
			unselected_default_cls = "RadioButton_default.png";
			unselected_over_cls = "RadioButton_over.png";
			unselected_down_cls = "RadioButton_pressed.png";
			unselected_disabled_cls = "RadioButton_disabled.png";
			
			selected_default_cls = "RadioButton_default_selected.png";
			selected_over_cls = "RadioButton_over_selected.png";
			selected_down_cls = "RadioButton_pressed_selected.png";
			selected_disabled_cls = "RadioButton_disabled_selected.png";
			
			width = 12;
			height = 12;
		}
	}
}