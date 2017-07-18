package ui.skin.comboBox
{
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.skin.JComboBoxSkin;
	import ui.skin.font.DefaultFont;
	import ui.skin.list.DefaultListSkin;
	
	public class DefaultComboBoxSkin extends JComboBoxSkin
	{
		private static var _instance:DefaultComboBoxSkin;
		public static function get instance():DefaultComboBoxSkin
		{
			if(_instance == null) { _instance = new DefaultComboBoxSkin(); }
			return _instance;
		}
		
		public function DefaultComboBoxSkin()
		{
			super();
			base_ns = "fate";
			
			labelBtnNormal_cls = "bg_pure_grey$png";
			labelBtnOver_cls = "bg_miniRndBrdGrey$png";
			labelBtnDown_cls = "bg_miniRndBrdGrey$png";
			labelBtnDisabled_cls = "bg_pure_grey$png";
			
			dropDownBtnNormal_cls = "btn_drop_green_sqr0$png";
			dropDownBtnOver_cls = "btn_drop_green_sqr1$png";
			dropDownBtnDown_cls = "btn_drop_green_sqr2$png";
			dropDownBtnDisabled_cls = "btn_drop_green_sqr2$png";
			
			boxHeight = 20;
			dropDownBtnWidth = 17;
			dropDownBtnHeight = 20;
			
			listSkin = DefaultListSkin.instance;
		}
		
		override public function apply(box:JComboBox):void
		{
			super.apply(box);
			box.labelButton.label.textFormat = DefaultFont.instance;
		}
		
	}
}