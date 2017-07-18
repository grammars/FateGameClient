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
	
	public class Cfgbuf2Cfgbin extends TasksRunner
	{
		private var resultBytes:ByteArray = new ByteArray();
		
		public function Cfgbuf2Cfgbin()
		{
			super();
		}
		
		override protected function getAcceptExt():String
		{
			return "cfgbuf";
		}
		
		override protected function createNewFileName():String
		{
			return CentreManage.getBinDir() + "\\release.cfgbin";
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
			
			var fileNameBytes:ByteArray = new ByteArray();
			fileNameBytes.writeMultiByte(curFileInfo.name, "UTF-8");
			
			resultBytes.writeInt(fileNameBytes.length);
			resultBytes.writeBytes(fileNameBytes);
			
			resultBytes.writeInt(bytes.length);
			resultBytes.writeBytes(bytes);
			
			curTaskDone();
		}
		
		override protected function allTasksDone():void
		{
			resultBytes.compress();
			
			var nf:File = new File(createNewFileName());
			var nfs:FileStream = new FileStream();
			nfs.open(nf, FileMode.WRITE);
			nfs.writeBytes(resultBytes);
			nfs.close();
			resultBytes.clear();
			
			super.allTasksDone();
		}
		
	}
}