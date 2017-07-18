package  ui.ctrls.Framework{
	
	public class CtrlCenter{
		
		public static var needShowApeFrame:Boolean = false;
		
		public static var defaultFont:String = "微软雅黑";
		/** 因为变换字体而导致的需要调整文字偏移 */
		public static function get txtOffsetYForFont():int
		{
			switch(defaultFont)
			{
				case "宋体":
					return 0;
					break;
				case "微软雅黑":
					return 0;
					break;
			}
			return 0;
		}
		
		public function CtrlCenter(){
			
		}
		
	}
}