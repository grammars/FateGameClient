package ui.skin.pushButton
{
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import res.Res;
	
	public class PaneCloseBtnSkin extends JPushButtonSkin
	{
		private static var _instance:PaneCloseBtnSkin;
		public static function get instance():PaneCloseBtnSkin
		{
			if(_instance == null) { _instance = new PaneCloseBtnSkin(); }
			return _instance;
		}
		
		public function PaneCloseBtnSkin()
		{
			super();
			
			base_ns = Res.NS;
			
			defaultBg_cls = "btn_close_pane0$png";
			overBg_cls = "btn_close_pane1$png";
			downBg_cls = "btn_close_pane2$png";
			disabledBg_cls = "btn_close_pane0$png";
			
			width = 31;
			height = 30;
		}
	}
}