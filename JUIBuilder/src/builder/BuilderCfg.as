package builder
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class BuilderCfg
	{
		/** 版本  */
		public static var version:String = "1.0.0";
		/** 默认项目 */
		public static var defaultProj:String = "default";
		/** 资源自动保存 */
		public static var assetsAutoSave:Boolean = false;
		
		public function BuilderCfg()
		{
		}
		
		public static function setup():void
		{
			var cfgFile:File = new File(Builder.appDir() + "builder.ini");
			var fs:FileStream = new FileStream();
			fs.open(cfgFile, FileMode.READ);
			var content:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
			fs.close();
			var itemsArr:Array = content.split("\r\n");
			var dic:Object = new Object();
			for(var i:int = 0; i < itemsArr.length; i++)
			{
				var itemStr:String = itemsArr[i];
				var pairArr:Array = itemStr.split("=");
				var key:String = pairArr[0];
				var value:String = pairArr[1];
				dic[key] = value;
			}
			version = dic["version"];
			defaultProj = dic["defaultProj"];
			assetsAutoSave = dic["assetsAutoSave"]=="true";
		}
		
		public static function save():void
		{
			var file:File = new File(Builder.appDir() + "builder.ini");
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			var cfgStr:String = "";
			cfgStr += "version=" + version + "\r\n";
			cfgStr += "defaultProj=" + defaultProj + "\r\n";
			cfgStr += "assetsAutoSave=" + assetsAutoSave;
			fs.writeMultiByte(cfgStr, "UTF-8");
			fs.close();
		}
		
	}
}