package builder.view.base
{
	import builder.Builder;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BFrame extends Sprite
	{
		public static const MARGIN:int = 5;
		
		public function get W():int
		{
			return 400;
		}
		
		public function get H():int
		{
			return 300;
		}
		
		protected var lineColor:uint = Builder.LAKE_BLUE;
		protected var fillColor:uint = Builder.DARK_GREY;
		
		public function BFrame()
		{
			super();
			createParts();
			paint();
			Builder.stage.addEventListener(Event.RESIZE, __resize);
		}
		
		protected function createParts():void
		{
			
		}
		
		protected function paint():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(3, lineColor);
			this.graphics.beginFill(fillColor, 1);
			this.graphics.drawRoundRect(0, 0, W, H, 3);
			this.graphics.endFill();
		}
		
		protected function __resize(e:Event):void
		{
			paint();
		}
		
	}
}