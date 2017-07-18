package com.anstu.jcommon.def
{
	public class CharsetConst
	{
		public static const GB2312:String = "gb2312";
		public static const GBK:String = "GBK";
		public static const UTF8:String = "UTF-8";
		
		public function CharsetConst()
		{
		}
		
		public static function getValue(charset:String):String
		{
			if(charset == GB2312) return GB2312;
			if(charset == GBK) return GBK;
			if(charset == UTF8) return UTF8;
			return UTF8;
		}
		
	}
}