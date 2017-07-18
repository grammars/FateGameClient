package manage 
{
	
	import data.Tag;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import manage.main.MainView;
	
	import spark.components.WindowedApplication;
	
	import utils.InvokeHandler;

	public class CentreManage
	{
		private static var _winApp:WindowedApplication = null;
		public static function get winApp():WindowedApplication
		{
			return _winApp;
		}
		
		/** 项目名称 */
		public static var projName:String;
		/** 项目空间路径 */
		public static var projSpace:String;
		
		public function CentreManage()
		{
		}
		
		/** 启动 */
		public static function startup(app:WindowedApplication):void
		{
			_winApp = app;
			
			new InvokeHandler();
			
			MainManage.startup();
			CreateProjManage.startup();
		}
		
		
		/** 关闭程序 */
		public static function shutdown():void
		{
			_winApp.exit();
		}
		
		/** 生成项目配置内容 */
		public static function makeProjCfgContent():String
		{
			var result:String = "";
			result += "projName=" + projName + "\r";
			return result;
		}
		
		/** 解析项目配置文件内容 */
		private static function digestProjCfgContent(content:String):void
		{
			
		}
		
		/** 创建项目所需的子目录结构 */
		public static function makeProjStruct():void
		{
			var xlsxDir:File = new File(getXlsxDir());
			xlsxDir.createDirectory();
			var bufDir:File = new File(getBufDir());
			bufDir.createDirectory();
			var binDir:File = new File(getBinDir());
			binDir.createDirectory();
		}
		
		public static function getXlsxDir():String
		{
			return projSpace+"\\xlsx";
		}
		
		public static function getBufDir():String
		{
			return projSpace+"\\buf";
		}
		
		public static function getBinDir():String
		{
			return projSpace+"\\bin";
		}
		
		/** 刷新项目空间 */
		public static function updateProjSpace():void
		{
			MainManage.updateFileList();
		}
		
		/** 打开一个现有项目 */
		public static function openProj():void
		{
			var cfgFile:File = new File();
			var fileFilter:FileFilter = new FileFilter("项目配置文件", "*."+Tag.PROJ_CFG_EXT);
			cfgFile.addEventListener(Event.SELECT, __selectProjCfgFile);
			cfgFile.browseForOpen("选择项目文件", [fileFilter]);
		}
		private static function __selectProjCfgFile(e:Event):void
		{
			var cfgFile:File = e.target as File;
			cfgFile.removeEventListener(Event.SELECT, __selectProjCfgFile);
			readProjCfgFile(cfgFile);
		}
		
		/** 读取项目配置文件 */
		public static function readProjCfgFile(cfgFile:File):void
		{
			var fs:FileStream = new FileStream();
			fs.open(cfgFile, FileMode.READ);
			var cfgContent:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
			
			digestProjCfgContent(cfgContent);
			
			var cfgFilePath:String = cfgFile.nativePath;
			projSpace = cfgFilePath.replace(cfgFile.name, "");
			
			updateProjSpace();
		}
		
		/** 关闭项目 */
		public static function closeProj():void
		{
			projName = null;
			projSpace = null;
			updateProjSpace();
		}
		
		
	}
}