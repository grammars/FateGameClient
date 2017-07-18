package ui.skin.pushButton
{
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import res.Res;
	
	import ui.skin.font.DefaultFont;
	
	public class CommOrangeBtnSkin extends JPushButtonSkin
	{
		private static var _instance:CommOrangeBtnSkin;
		public static function get instance():CommOrangeBtnSkin
		{
			if(_instance == null) { _instance = new CommOrangeBtnSkin(); }
			return _instance;
		}
		
		public function CommOrangeBtnSkin()
		{
			super();
			
			base_ns = Res.NS;
			
			defaultBg_cls = "btn_comm0$png";
			overBg_cls = "btn_comm1$png";
			downBg_cls = "btn_comm2$png";
			disabledBg_cls = "btn_comm3$png";
			
			labelFormat = DefaultFont.instance;
		}
	}
}