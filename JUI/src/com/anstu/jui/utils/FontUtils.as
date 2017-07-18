package com.anstu.jui.utils
{
	import flash.text.Font;

	public class FontUtils
	{
		public function FontUtils()
		{
		}
		
		public static function dumpFonts():void
		{
			var sysFonts:Array = Font.enumerateFonts(true);
			for(var i:int = 0; i < sysFonts.length; i++)
			{
				var font:Font = sysFonts[i];
				trace("fontName=" + font.fontName + " fontStyle=" + font.fontStyle + " fontType=" + font.fontType);
			}
		}
		
		//"微软雅黑" || curFN == "Microsoft YaHei")
		public static function getFontNames():Array
		{
			var arr:Array = new Array();
			var sysFonts:Array = Font.enumerateFonts(true);
			for(var i:int = 0; i < sysFonts.length; i++)
			{
				var font:Font = sysFonts[i];
				arr.push(font.fontName);
			}
			return arr;
		}
		
	}
}