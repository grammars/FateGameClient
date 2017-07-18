package com.anstu.jui.skin
{
	import com.anstu.jui.controls.JComboBox;

	public class JComboBoxSkin
	{
		public var base_ns:String = "default";
		
		public var labelBtnNormal_cls:String = "ComboBox_label_default.png";//ComboBox_label_DD_sto.png
		public var labelBtnOver_cls:String = "ComboBox_label_over.png";//ComboBox_label_over_sto.png
		public var labelBtnDown_cls:String = "ComboBox_label_pressed.png";//ComboBox_label_pressed_sto.png
		public var labelBtnDisabled_cls:String = "ComboBox_label_disabled.png";//ComboBox_label_DD_sto.png
		
		public var dropDownBtnNormal_cls:String = "ComboBox_drop_default.png";//ComboBox_drop_default_s.png
		public var dropDownBtnOver_cls:String = "ComboBox_drop_over.png";//ComboBox_drop_over_s.png
		public var dropDownBtnDown_cls:String = "ComboBox_drop_pressed.png";//ComboBox_drop_pressed_s.png
		public var dropDownBtnDisabled_cls:String = "ComboBox_drop_disabled.png";//ComboBox_drop_disabled_s.png
		
		public var listSkin:JListSkin = new JListSkin();
		
		public var boxHeight:int = 25;
		public var dropDownBtnWidth:int = 17;
		public var dropDownBtnHeight:int = 25;
		
		public function JComboBoxSkin()
		{
			//labelBtnNormal_cls = "ComboBox_label_DD_sto.png";
			//labelBtnOver_cls = "ComboBox_label_over_sto.png";
			//labelBtnDown_cls = "ComboBox_label_pressed_sto.png";
		}
		
		public function apply(box:JComboBox):void
		{
			box.height = boxHeight;
			listSkin.apply(box.list);
			
			var labelBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			labelBtnSkin.base_ns = base_ns;
			labelBtnSkin.defaultBg_cls = labelBtnNormal_cls;
			labelBtnSkin.overBg_cls = labelBtnOver_cls;
			labelBtnSkin.downBg_cls = labelBtnDown_cls;
			labelBtnSkin.apply(box.labelButton);
			
			var dropDownBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			dropDownBtnSkin.base_ns = base_ns;
			dropDownBtnSkin.defaultBg_cls = dropDownBtnNormal_cls;
			dropDownBtnSkin.overBg_cls = dropDownBtnOver_cls;
			dropDownBtnSkin.downBg_cls = dropDownBtnDown_cls;
			dropDownBtnSkin.apply(box.dropDownButton);
			box.dropDownButton.setSize(dropDownBtnWidth, dropDownBtnHeight);
		}
		
	}
}