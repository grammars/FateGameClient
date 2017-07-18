package comm.define
{
	public class SexType
	{
		/** 无性别 */
		public static const NULL:int = 0;
		/** 男 */
		public static const BOY:int = 1;
		/** 女 */
		public static const GIRL:int = 2;
		
		public function SexType()
		{
		}
		
		/** Str */
		public static function Str(type:int):String
		{
			switch(type)
			{
			case NULL: return "无性别";
			case BOY: return "男";
			case GIRL: return "女";
			default: return "未定义";
			}
		}
		
	}
}