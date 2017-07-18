package builder.view.base
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class BImage extends Sprite
	{
		private var w:Object = null;
		private var h:Object = null;
		
		public function BImage(reUrl:String, w:Object=null, h:Object=null)
		{
			super();
			
			this.w = w;
			this.h = h;
			
			var req:URLRequest = new URLRequest("brs/" + reUrl);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __loaded);
			loader.load(req);
			
			paint();
			
			this.mouseChildren = false;
		}
		
		private function __loaded(e:Event):void
		{
			var loader:Loader = e.target.loader;
			this.addChild(loader);
			if(this.w)
			{
				loader.width = int(w);
			}
			if(this.h)
			{
				loader.height = int(h);
			}
		}
		
		private function paint():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x0, 0);
			this.graphics.drawRect(0, 0, int(w), int(h));
			this.graphics.endFill();
		}
		
	}
}