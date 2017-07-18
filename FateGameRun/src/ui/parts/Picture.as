package ui.parts
{
	import central.Centre;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import gamekit.FateGameKit;
	
	public class Picture extends Sprite
	{
		private var content:Bitmap = new Bitmap();
		
		/** 预期宽度 */
		private var exWidth:int = 0;
		/** 预期高度 */
		private var exHeight:int = 0;
		/** 是否居中 */
		private var inCentre:Boolean = true;
		
		public function Picture(picUrl:String, inCentre:Boolean=true, exWidth:int=0, exHeight:int=0)
		{
			super();
			this.inCentre = inCentre;
			this.exWidth = exWidth;
			this.exHeight = exHeight;
			
			this.addChild(content);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __loadErr);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __loaded);
			loader.load(new URLRequest(picUrl));
		}
		
		private function __loadErr(event:IOErrorEvent):void
		{
			var li:LoaderInfo = event.target as LoaderInfo;
			li.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
			li.removeEventListener(Event.COMPLETE, __loaded);
		}
		
		private function __loaded(event:Event):void
		{
			var li:LoaderInfo = event.target as LoaderInfo;
			li.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
			li.removeEventListener(Event.COMPLETE, __loaded);
			var bmp:Bitmap = li.loader.content as Bitmap;
			content.bitmapData = bmp.bitmapData;
			li.loader.unload();
			
			if(inCentre)
			{
				content.x = (exWidth - content.width)/2;
				content.y = (exHeight - content.height)/2;
			}
		}
		
	}
}