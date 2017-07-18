package ui.skin.font
{
	import com.anstu.jui.components.JTextFormat;

	public class DefaultFont extends JTextFormat
	{
		private static var _instance:JTextFormat
		public static function get instance():JTextFormat
		{
			if(_instance == null) { _instance = new DefaultFont(); }
			return _instance;
		}
		
		public static function get FONT():String { return "Microsoft Yahei"; }
		
		public function DefaultFont()
		{
			//super("微软雅黑", 12, 0xffecb9);
			super(FONT, 12, 0xffecb9);
		}
		
		/** 一个new出来的DefaultFont */
		public static function create():JTextFormat { return new DefaultFont(); }
		
	}
}