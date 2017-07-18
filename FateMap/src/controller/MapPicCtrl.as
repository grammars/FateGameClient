package controller
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import model.MapConfig;
	import model.WorkConfig;
	
	import org.aswing.Component;
	import org.aswing.JFrame;
	import org.aswing.JLoadPane;
	import org.aswing.JPanel;
	import org.aswing.JViewport;
	import org.aswing.geom.IntRectangle;
	
	import view.AlertWnd;
	import view.CanvasPanel;

	public class MapPicCtrl
	{
		private static var _me:MapPicCtrl;
		public static function me():MapPicCtrl
		{
			if(_me == null) { _me = new MapPicCtrl(); }
			return _me;
		}
		
		private var loader:Loader;
		
		private var pic:Bitmap;
		
		public function MapPicCtrl()
		{
			loader = new Loader();
		}
		
		public function loadMapPic():void
		{
			if(WorkConfig.me().isLegal())
			{
				loader.unload();
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, __loadingHandler);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __loadedHandler);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __loadErrorHandler);
				loader.load(new URLRequest(WorkConfig.me().getMapPicAddr()));
			}
			else
			{
				trace("工作空间配置不合法MapPicCtrl无法执行loadMapPic()");
			}
		}
		
		private function __loadingHandler(e:ProgressEvent):void
		{
			var progress:int = e.bytesLoaded / e.bytesTotal * 100;
			AlertWnd.me().show("已加载" + progress + "%");
		}
		
		private function __loadedHandler(e:Event):void
		{
			AlertWnd.me().hide();
			pic = loader.content as Bitmap;
			WorkConfig.me().setMapWidth(pic.width);
			WorkConfig.me().setMapHeight(pic.height);
			MapConfig.me().install();
			CanvasPanel.me().setMapPic(pic);
			loader.unload();
			//
			var ul:URLLoader = new URLLoader();
			ul.dataFormat = URLLoaderDataFormat.BINARY;
			ul.addEventListener(Event.COMPLETE, __cfgLoaded);
			ul.addEventListener(IOErrorEvent.IO_ERROR, __cfgFailed);
			trace(WorkConfig.me().getMapSpaceDir() + "\\" + WorkConfig.me().getMapId() + ".map");
			var ur:URLRequest = new URLRequest(WorkConfig.me().getMapSpaceDir() + "\\" + WorkConfig.me().getMapId() + ".map");
			ul.load(ur);
		}
		
		private function __loadErrorHandler(e:IOErrorEvent):void
		{
			AlertWnd.me().show("加载图片异常");
		}
		
		private function __cfgLoaded(e:Event):void
		{
			var bytes:ByteArray = URLLoader(e.target).data as ByteArray;
			var ret:Boolean = MapConfig.me().decode(bytes);
			if(ret == false)
			{
				MapConfig.me().install();
				AlertWnd.me().show(".map文件异常，或与metadata不匹配.");
			}
		}
		
		private function __cfgFailed(e:IOErrorEvent):void
		{
			AlertWnd.me().show("加载.map文件异常");
		}
		
		public function clear():void
		{
			CanvasPanel.me().clear();
			loader.unload();
		}
		
		private var tileBmds:Array = new Array();
		private var sliceW:int = 320;
		private var sliceH:int = 240;
		private var sliceNumX:int = 0;
		private var sliceNumY:int = 0;
		private var exportFile:File;
		private var exportStream:FileStream = new FileStream();
		private var curPiece:int = 0;
		private var quality:int = 0;
		/** 导出切片 */
		public function exportSection(sw:int, sh:int, q:int=80):void
		{
			if(pic && pic.bitmapData)
			{
				quality = q;
				sliceW = sw;
				sliceH = sh;
				tileBmds.length = 0;
				curPiece = 0;
				sliceNumX = Math.ceil(pic.bitmapData.width / sw);
				sliceNumY = Math.ceil(pic.bitmapData.height / sh);
				for(var ny:int = 0; ny < sliceNumY; ny++)
				{
					for(var nx:int = 0; nx < sliceNumX; nx++)
					{
						var piece:BitmapData = new BitmapData(sw, sh, false, 0x0);
						var srcRect:Rectangle = new Rectangle(sw*nx, sh*ny, sw, sh);
						piece.copyPixels(pic.bitmapData, srcRect, new Point(0,0));
						tileBmds.push(piece);
					}
				}
				exportFileIng();
			}
			else
			{
				AlertWnd.me().show("源图像缺失，无法导出切片");
			}
		}
		private function exportFileIng():void
		{
			var piece:BitmapData = tileBmds.shift() as BitmapData;
			var encoder:JPGEncoder = new JPGEncoder(quality);
			var bytes:ByteArray = encoder.encode(piece);
			var nx:int = curPiece % sliceNumX;
			var ny:int = Math.floor(curPiece / sliceNumX);
			exportFile = new File(WorkConfig.me().getMapSpaceDir() + "\\tiles\\" + ny + "_" + nx + ".jpg");
			curPiece++;
			AlertWnd.me().show("正在生成...(剩余" + tileBmds.length + ")");
			if(!exportStream.hasEventListener(Event.CLOSE))
			{
				exportStream.addEventListener(Event.CLOSE , __exportStreamClose);
			}
			exportStream.openAsync(exportFile, FileMode.WRITE);
			exportStream.writeBytes(bytes);
			exportStream.close();
		}
		private function __exportStreamClose(e:Event):void
		{
			if(tileBmds.length == 0)
			{
				exportStream.removeEventListener(Event.CLOSE , __exportStreamClose);
				AlertWnd.me().hide();
				return;
			}
			setTimeout(exportFileIng, 50);
		}
		
	}
}