package builder.view.prop.item.parts
{
	import builder.Builder;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	public class PicLoader extends Sprite
	{
		public function PicLoader(relPath:String)
		{
			super();
			this.graphics.beginFill(0xff0000, 0.6);
			this.graphics.drawRect(0,0,50, 50);
			this.graphics.endFill();
			var url:String = Builder.assetsDirFull() + relPath;
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			this.addChild(loader);
		}
	}
}