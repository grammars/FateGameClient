package ui.skin.pushButton
{
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import res.Res;
	
	public class MiniCloseBtnSkin extends JPushButtonSkin
	{
		private static var _instance:MiniCloseBtnSkin;
		public static function get instance():MiniCloseBtnSkin
		{
			if(_instance == null) { _instance = new MiniCloseBtnSkin(); }
			return _instance;
		}
		
		public function MiniCloseBtnSkin()
		{
			super();
			
			base_ns = Res.NS;
			
			defaultBg_cls = "btn_close_mini0$png";
			overBg_cls = "btn_close_mini1$png";
			downBg_cls = "btn_close_mini2$png";
			disabledBg_cls = "btn_close_mini0$png";
			
			width = 31;
			height = 30;
		}
		
	}
}