package data
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import manage.CentreManage;
	
	import utils.TasksRunner;
	import utils.excel.Excel;
	
	public class Xlsx2Cfgbuf extends TasksRunner
	{
		public function Xlsx2Cfgbuf()
		{
			super();
		}
		
		override protected function getAcceptExt():String
		{
			return "xlsx";
		}
		
		override protected function createNewFileName():String
		{
			return CentreManage.getBufDir() + "\\" + curFileInfo.name.replace("xlsx", "cfgbuf");
		}
		
		override protected function work():void
		{
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, __bytesLoaded);
			loader.load(new URLRequest(curFileInfo.nativePath));
		}
		
		private function __bytesLoaded(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			var excel:Excel = new Excel(loader.data as ByteArray);
			var sheet:Array = excel.getSheetArray();//得到表格数据
			var result:String = "";
			for(var i:int = 0; i < sheet.length; i++)
			{
				var line:Array = sheet[i];
				if(line == null) { continue; }
				for(var j:int = 0; j < line.length; j++)
				{
					var grid:String = line[j];
					if(grid == null) { continue; }
					if(j != 0) { result += Tag.WORD_SEP; }
					result += grid;
				}
				if(i != sheet.length-1)
				{
					result += Tag.LINE_SEP;
				}
			}
			
			var nf:File = new File(createNewFileName());
			var nfs:FileStream = new FileStream();
			var nba:ByteArray = new ByteArray();
			nba.writeMultiByte(result, "UTF-8");
			nfs.open(nf, FileMode.WRITE);
			nfs.writeBytes(nba);
			nfs.close();
			nba.clear();
			
			curTaskDone();
		}
		
	}
}