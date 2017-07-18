package gamekit.map.material
{
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import gamekit.FateGameKit;
	
	public class MapTile extends Bitmap
	{
		private static var pool:Vector.<MapTile> = new Vector.<MapTile>();
		public static function getTile(url:String):MapTile
		{
			var i:int = 0;
			for(i = 0; i < pool.length; i++)
			{
				if(pool[i].url == url)
				{
					return pool[i];
				}
			}
			var t:MapTile = new MapTile();
			pool.push(t);
			return t;
		}
		
		public static function invalidPool():void
		{
			for(var i:int = 0; i < pool.length; i++)
			{
				pool[i].unload();
			}
		}
		
		public static function renderPool(container:DisplayObjectContainer):void
		{
			for(var i:int = 0; i < pool.length; )
			{
				if(pool[i].disposed)
				{
					if(pool[i].parent) { pool[i].parent.removeChild(pool[i]); }
					pool.splice(i, 1);
				}
				else
				{
					container.addChild(pool[i]);
					i++;
				}
			}
			jl.start();
		}
		
		private static var jl:JLoader = new JLoader();
		
		
		private var _disposed:Boolean = true;
		/** 是否被释放，被释放的才能被重新利用 */
		public function get disposed():Boolean { return _disposed; }
		
		public var url:String;
		
		public function MapTile()
		{
			super();
		}
		
		public function load(url:String, tw:int, th:int):void
		{
			_disposed = false;
			if(this.bitmapData == null)
			{
				this.bitmapData = new BitmapData(tw, th, true, 0xff000000);
			}
			if(this.url != url)
			{
				this.url = url;
				var task:JLoadTask = new JLoadTask(JLoadTask.TYPE_DISPLAY_CONTENT, this.url, FateGameKit.SAME_DOMAIN);
				task.onComplete = __picLoaded;
				jl.add(task);
			}
		}
		
		private function __picLoaded(task:JLoadTask):void
		{
			//this.addChild(task.result.getBmp());
			this.bitmapData = task.result.getBmp().bitmapData;
//			this.graphics.clear();
//			this.graphics.beginBitmapFill(bmd, null, true, true);
//			this.graphics.drawRect(0, 0, bmd.width, bmd.height);
//			this.graphics.endFill();
		}
		
		/** 只是标记被释放，但不要真的去释放资源，因为load的时候会优化 */
		public function unload():void
		{
			_disposed = true;
		}
		
	}
}