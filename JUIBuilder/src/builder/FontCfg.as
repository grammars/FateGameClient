package builder
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class FontCfg
	{
		public static var fontNames:Array;
		
		public function FontCfg()
		{
		}
		
		public static function setup():void
		{
			var cfgFile:File = new File(Builder.appDir() + "font.ini");
			var fs:FileStream = new FileStream();
			fs.open(cfgFile, FileMode.READ);
			var content:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
			fs.close();
			var itemsArr:Array = content.split("\r\n");
			fontNames = new Array();
			for(var i:int = 0; i < itemsArr.length; i++)
			{
				var line:String = itemsArr[i];
				if(line == null || line.length <= 1 || -1!=line.indexOf("#"))
				{
					continue;
				}
				fontNames.push(line);
			}
		}
		
	}
}