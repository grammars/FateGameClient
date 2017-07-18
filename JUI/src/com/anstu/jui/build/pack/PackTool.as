package com.anstu.jui.build.pack
{
	import flash.utils.ByteArray;

	public class PackTool
	{
		
		public function PackTool()
		{
		}
		
		public static function encode(items:Vector.<PackItem>):ByteArray
		{
			var output:ByteArray = new ByteArray();
			for(var i:int = 0; i < items.length; i++)
			{
				var item:PackItem = items[i];
				
				var fileNameBytes:ByteArray = new ByteArray();
				fileNameBytes.writeMultiByte(item.name, "UTF-8");
				output.writeInt(fileNameBytes.length);
				output.writeBytes(fileNameBytes);
					
				var fileContentBytes:ByteArray = new ByteArray();
				fileContentBytes.writeMultiByte(item.content, "UTF-8");
				output.writeInt(fileContentBytes.length);
				output.writeBytes(fileContentBytes);
			}
			output.compress();
			return output;
		}
		
		public static function decode(input:ByteArray):Vector.<PackItem>
		{
			input.uncompress();
			var items:Vector.<PackItem> = new Vector.<PackItem>();
			while(readOneItem(input, items)) {}
			return items;
		}
		
		private static function readOneItem(bytes:ByteArray, items:Vector.<PackItem>):Boolean
		{
			if(bytes.bytesAvailable < 4) { return false; }
			var fileNameLen:int = bytes.readInt();
			if(bytes.bytesAvailable < fileNameLen) { return false; }
			var fileName:String = bytes.readMultiByte(fileNameLen, "UTF-8");
			if(bytes.bytesAvailable < 4) { return false; }
			var fileContentLen:int = bytes.readInt();
			if(bytes.bytesAvailable < fileContentLen) { return false; }
			var fileContent:String = bytes.readMultiByte(fileContentLen, "UTF-8");
			
			var item:PackItem = new PackItem();
			item.name = fileName;
			item.content = fileContent;
			
			items.push(item);
			
			return true;
		}
		
		public static function dump(items:Vector.<PackItem>, needTrace:Boolean=true):String
		{
			var debugStr:String = "";
			for(var i:int = 0; i < items.length; i++)
			{
				var item:PackItem = items[i];
				debugStr += "============="+item.name+"=============\r";
				debugStr += item.content + "\r\n";
			}
			if(needTrace) { trace(debugStr); }
			return debugStr;
		}
		
	}
}