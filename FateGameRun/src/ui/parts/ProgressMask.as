package ui.parts
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class ProgressMask
	{
		private var tar:Sprite;
		
		public static const LEFT:int = 0;
		public static const RIGHT:int = 1;
		private var baseDir:int = 0;
		
		private var shape:Shape = new Shape();
		
		private var RW:int = 0;
		private var RH:int = 0;
		
		public function ProgressMask()
		{
		}
		
		public function setup(tar:Sprite, baseDir:int=0, pRW:int=0, pRH:int=0):ProgressMask
		{
			this.tar = tar;
			this.baseDir = baseDir;
			this.tar.addChild(shape);
			this.tar.mask = shape;
			RW = pRW > 0 ? pRW : tar.width;
			RH = pRH > 0 ? pRH : tar.height;
			return this;
		}
		
		public function setProgress(scale:Number):void
		{
			if(scale < 0) { scale = 0; }
			if(scale > 1) { scale = 1; }
			shape.graphics.clear();
			shape.graphics.beginFill(0xff0000);
			if(baseDir == LEFT)
			{
				shape.graphics.drawRect(0,0,RW*scale,RH);
			}
			else
			{
				shape.graphics.drawRect(RW*(1-scale),0,RW*scale,RH);
			}
			shape.graphics.endFill();
		}
		
	}
}