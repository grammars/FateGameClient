package ui.skin.pane
{
	import com.anstu.jui.skin.JPanelSkin;
	
	import res.Res;
	
	public class TipClassicPaneSkin extends JPanelSkin
	{
		private static var _instance:TipClassicPaneSkin;
		public static function get instance():TipClassicPaneSkin
		{
			if(_instance == null) { _instance = new TipClassicPaneSkin(); }
			return _instance;
		}
		
		public function TipClassicPaneSkin()
		{
			super();
			background_ns = Res.NS;
			background_cls = "bg_tip_classic$png";
			background_opt = null;
		}
	}
}