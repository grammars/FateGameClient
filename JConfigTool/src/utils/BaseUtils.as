package utils
{
	public class BaseUtils
	{
		public function BaseUtils()
		{
		}
		
		/** 剔除空格 */
		public static function trimSpace(str:String):String
		{
			return str.split(" ").join("");
		}
		
	}
}