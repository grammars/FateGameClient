package builder.view.open
{
	import builder.Builder;
	import builder.view.OpenPop;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;

	public class DocSnapTask
	{
		public var juiFile:File;
		public var loader:Loader = new Loader();
		/** 是否有预览图 */
		public var hasSnap:Boolean = false;
		
		public function DocSnapTask(juiFile:File)
		{
			this.juiFile = juiFile;
			var pureName:String = juiFile.name.replace("."+Builder.EXT, "");
			var picUrl:String = Builder.snapDirFull() + pureName;
			if(new File(picUrl+".png").exists)
			{
				picUrl += ".png";
			}
			else if(new File(picUrl+".jpg").exists)
			{
				picUrl += ".jpg";
			}
			else
			{
				picUrl += ".gif";
			}
			//trace("picUrl=" + picUrl);
			var picReq:URLRequest = new URLRequest(picUrl);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __loaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __loadErr);
			loader.load(picReq);
			
		}
		
		private function __loaded(e:Event):void
		{
			hasSnap = true;
			OpenPop.instance.addDocSnap(this);
		}
		
		private function __loadErr(e:IOErrorEvent):void
		{
			hasSnap = false;
			OpenPop.instance.addDocSnap(this);
		}
		
	}
}