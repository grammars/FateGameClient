package com.anstu.jui.build
{

	public class BU
	{
		public function BU()
		{
		}
		
		public static function replace(targetString:String , oldString:String , newString:String):String
		{
			return targetString.split(oldString).join(newString);
		}
		
		public static function trim(targetString:String):String
		{
			return replace(targetString, " ", "");
		}
		
		/** 获得符合输出xml的String */
		public static function XML(srcText:String):String
		{
			srcText = replace(srcText, "<", "&lt;");
			srcText = replace(srcText, ">", "&gt;");
			srcText = replace(srcText, "/", "\/");
			srcText = replace(srcText, "'", "&apos;");
			srcText = replace(srcText, '"', "&quot;");
			return srcText;
		}
		
		public static function available(str:String):Boolean
		{
			if(str != null && str != "" && str != "null")
			{
				return true;
			}
			return false;
		}
		
		/** 将"null"转成真正的null */
		public static function richStr(str:String):String
		{
			if(str == "null") { return null; }
			return str;
		}
		
		public static function unRichStr(obj:Object):String
		{
			if(obj==null) { return "null"; }
			return obj.toString();
		}
		
		public static function hex2int(hexStr:String):int
		{
			if(hexStr == null) { return 0; }
			return parseInt(hexStr, 16);
		}
		
		public static function int2hex(value:Object):String
		{
			if(value == null) { return "0x0"; }
			return value.toString(16);
		}
		
		public static function str2bool(str:String):Boolean
		{
			return str == "true";
		}
		
		public static function bool2str(b:Boolean):String
		{
			return b ? "true" : "false";
		}
		
		/** String to Positive Integer */
		public static function S2PI(value:String):int
		{
			var i:int = parseInt(value);
			if(i <= 0 || isNaN(i)) { return 1; }
			return i;
		}
		
		public static function txtSize2Str(size:Object):String
		{
			if(size == null) { return "12"; }
			return size.toString();
		}
		
	}
}