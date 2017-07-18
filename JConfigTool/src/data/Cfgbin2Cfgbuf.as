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
	
	public class Cfgbin2Cfgbuf extends TasksRunner
	{
		public function Cfgbin2Cfgbuf()
		{
			super();
		}
		
		override protected function getAcceptExt():String
		{
			return "cfgbin";
		}
		
		private var curFileName:String = "";
		override protected function createNewFileName():String
		{
			return CentreManage.getBufDir() + "\\" + curFileName;
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
			var bytes:ByteArray = (loader.data as ByteArray);
			
			bytes.uncompress();
			
			while(bytes.bytesAvailable > 0)
			{
				var fileNameLen:int = bytes.readInt();
				if(bytes.bytesAvailable >= fileNameLen + 4)
				{
					curFileName = bytes.readMultiByte(fileNameLen, "UTF-8");
				}
				else
				{
					error("非法的cfgbin");
					break;
				}
				var fileContentSize:int = bytes.readInt();
				if(bytes.bytesAvailable >= fileContentSize)
				{
					var contentBytes:ByteArray = new ByteArray();
					bytes.readBytes(contentBytes, 0, fileContentSize);
					
					var nf:File = new File(createNewFileName());
					var nfs:FileStream = new FileStream();
					nfs.open(nf, FileMode.WRITE);
					nfs.writeBytes(contentBytes);
					nfs.close();
					contentBytes.clear();
				}
				else
				{
					error("非法的cfgbin");
					break;
				}
			}
			
			curTaskDone();
		}
		
		
		
	}
}