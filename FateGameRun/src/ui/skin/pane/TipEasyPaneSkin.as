package ui.skin.pane
{
	import com.anstu.jui.skin.JPanelSkin;
	
	import res.Res;
	
	public class TipEasyPaneSkin extends JPanelSkin
	{
		private static var _instance:TipEasyPaneSkin;
		public static function get instance():TipEasyPaneSkin
		{
			if(_instance == null) { _instance = new TipEasyPaneSkin(); }
			return _instance;
		}
		
		public function TipEasyPaneSkin()
		{
			super();
			background_ns = Res.NS;
			background_cls = "bg_tip_easy$png";
			background_opt = null;
		}
	}
}