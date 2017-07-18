package ui.skin.pane
{
	import com.anstu.jui.skin.JPanelSkin;
	
	import res.Res;
	
	public class GreyShadowPaneSkin extends JPanelSkin
	{
		private static var _instance:GreyShadowPaneSkin;
		public static function get instance():GreyShadowPaneSkin
		{
			if(_instance == null) { _instance = new GreyShadowPaneSkin(); }
			return _instance;
		}
		
		public function GreyShadowPaneSkin()
		{
			super();
			background_ns = Res.NS;
			background_cls = "bg_grey_shadow$png";
			background_opt = null;
		}
	}
}