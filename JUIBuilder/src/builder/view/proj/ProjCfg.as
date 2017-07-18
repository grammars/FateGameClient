package builder.view.proj
{
	import builder.Builder;
	import builder.BuilderCfg;
	
	import com.codeazur.as3swf.utils.ObjCUtils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class ProjCfg
	{
		/** 项目名称 */
		public var projName:String;
		
		public function ProjCfg(projName:String="")
		{
			this.projName = projName;
		}
		
		/** 创建项目 */
		public function create():void
		{
			var file:File = new File(Builder.appDir()+projName+"."+Builder.PROJ_EXT);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(makeContent(), "UTF-8");
			fs.close();
			
			var dir:File;
			dir = new File(Builder.docDirFull());
			dir.createDirectory();
			
			dir = new File(Builder.templatesDirFull());
			dir.createDirectory();
			
			dir = new File(Builder.assetsDirFull());
			dir.createDirectory();
			
			dir = new File(Builder.snapDirFull());
			dir.createDirectory();
			
			dir = new File(Builder.outputDirFull());
			dir.createDirectory();
		}
		
		private function makeContent():String
		{
			return "projName="+projName + "\r\n" + "version=123";
		}
		
		/** 从配置文件中读取配置 */
		public function readFromFile(f:File):void
		{
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
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
			projName = dic["projName"];
		}
		
	}
}