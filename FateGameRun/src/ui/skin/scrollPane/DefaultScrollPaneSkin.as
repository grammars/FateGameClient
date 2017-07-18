package ui.skin.scrollPane
{
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import res.Res;
	
	import ui.skin.scrollBar.DefaultScrollBarSkin;
	
	public class DefaultScrollPaneSkin extends JScrollPanelSkin
	{
		private static var _instance:DefaultScrollPaneSkin;
		public static function get instance():DefaultScrollPaneSkin
		{
			if(_instance == null) { _instance = new DefaultScrollPaneSkin(); }
			return _instance;
		}
		
		
		public function DefaultScrollPaneSkin()
		{
			super();
			base_ns = Res.NS;
			background_cls = "base_transparant$png";
			scrollBarSkin = DefaultScrollBarSkin.instance;
		}
		
	}
}