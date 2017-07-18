package ui.skin.list
{
	import com.anstu.jui.skin.JListSkin;
	import ui.skin.font.DefaultFont;
	import ui.skin.scrollBar.DefaultScrollBarSkin;
	
	public class DefaultListSkin extends JListSkin
	{
		private static var _instance:DefaultListSkin;
		public static function get instance():DefaultListSkin
		{
			if(_instance == null) { _instance = new DefaultListSkin(); }
			return _instance;
		}
		
		public function DefaultListSkin()
		{
			super();
			base_ns = "fate";
			item_textFormat = DefaultFont.instance;
			scrollBarSkin = DefaultScrollBarSkin.instance;
		}
	}
}