package ui.skin.pane
{
	import com.anstu.jui.skin.JPanelSkin;
	
	import res.Res;
	
	public class FrameFrontPaneSkin extends JPanelSkin
	{
		private static var _instance:FrameFrontPaneSkin;
		public static function get instance():FrameFrontPaneSkin
		{
			if(_instance == null) { _instance = new FrameFrontPaneSkin(); }
			return _instance;
		}
		
		public function FrameFrontPaneSkin()
		{
			super();
			background_ns = Res.NS;
			background_cls = "bg_paneFrame$png";
			background_opt = null;
		}
	}
}