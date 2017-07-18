package builder.view.assets
{
	import com.anstu.jui.build.BU;
	import builder.Builder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class AssetsCompTask
	{
		public static const PNG:String = "png";
		public static const JPG:String = "jpg";
		public static const JPEG:String = "jpeg";
		public static const BMP:String = "bmp";
		public static const GIF:String = "gif";
		public static const UNDEFINED:String = "undefined";
		
		public var type:String = PNG;
		
		public var loadSucc:Boolean = false;
		
		public var className:String = "default_png";
		public var bmd:BitmapData;
		
		/** @param relPath:String "bg/main.png"
		 * @param url:String "G:\wxclient\JUIBuilder\bin-debug\uidoc\assets\btn/main.png" */
		public function AssetsCompTask(relPath:String, url:String)
		{
			//trace("relPath:" + relPath + "\rurl=" + url);
			checkType(relPath);
			makeClassName(relPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __picLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __picLoadErr);
			loader.load(new URLRequest(url));
		}
		
		/** 检查图片类型 */
		private function checkType(path:String):void
		{
			const pngExt:String = "."+PNG;
			const jpgExt:String = "."+JPG;
			const jpegExt:String = "."+JPEG;
			const bmpExt:String = "."+BMP;
			const gifExt:String = "."+GIF;
			
			if(path.indexOf(pngExt) != -1)
			{
				this.type = PNG;
			}
			else if(path.indexOf(jpgExt) != -1)
			{
				this.type = JPG;
			}
			else if(path.indexOf(jpegExt) != -1)
			{
				this.type = JPEG;
			}
			else if(path.indexOf(bmpExt) != -1)
			{
				this.type = BMP;
			}
			else if(path.indexOf(gifExt) != -1)
			{
				this.type = GIF;
			}
			else
			{
				this.type = UNDEFINED;
			}
			//trace(type);
		}
		
		private function makeClassName(relPath:String):void
		{
			className = Builder.makeAssetsClassName(relPath);
//			className = relPath;
//			className = BU.replace(className, ".", Builder.CLASSNAME_EXT_TAG);
//			className = BU.replace(className, "//", Builder.CLASSNAME_SLASH_TAG);
//			className = BU.replace(className, "\\\\", Builder.CLASSNAME_SLASH_TAG);
//			className = BU.replace(className, "/", Builder.CLASSNAME_SLASH_TAG);
//			className = BU.replace(className, "\\", Builder.CLASSNAME_SLASH_TAG);
		}
		
		private function __picLoaded(e:Event):void
		{
			var loader:Loader = e.target.loader;
			var bmp:Bitmap = loader.content as Bitmap;
			this.bmd = bmp.bitmapData;
			
			this.loadSucc = true;
			AssetsCompiler.handleLoadedTask(this);
		}
		
		private function __picLoadErr(e:IOErrorEvent):void
		{
			this.loadSucc = false;
			AssetsCompiler.handleLoadedTask(this);
		}
		
	}
}