package run.scene.avatar
{
	import flash.display.Sprite;
	
	public class AvtBarPart extends Sprite
	{
		public static const W:int = 80;
		public static const H:int = 12;
		
		private var hpLine:Line;
		private var mpLine:Line;
		
		public var curHp:int = 0;
		public var maxHp:int = 0;
		
		public var curMp:int = 0;
		public var maxMp:int = 0;
		
		public function AvtBarPart()
		{
			super();
			
			this.graphics.beginFill(0xfefe38, 0.001);
			this.graphics.drawRoundRect(0, 0, W, H, 5, 5);
			this.graphics.endFill();
			
			hpLine = new Line(W, 5, 0xff0000, 0x2b2b2b, 0x2b2b2b);
			hpLine.y = 0;
			this.addChild(hpLine);
			mpLine = new Line(W, 5, 0x0000ff, 0x2b2b2b, 0x2b2b2b);
			mpLine.y = 7;
			this.addChild(mpLine);
			
			repaint();
		}
		
		public function repaint():void
		{
			hpLine.curVal = curHp;
			hpLine.maxVal = maxHp;
			hpLine.repaint();
			
			mpLine.curVal = curMp;
			mpLine.maxVal = maxMp;
			mpLine.repaint();
		}
		
	}
}

import flash.display.Shape;

class Line extends Shape
{
	public var curVal:int;
	public var maxVal:int;
	
	protected var w:int;
	protected var h:int;
	protected var fcolor:uint;
	protected var bcolor:uint;
	protected var lineColor:uint;
	
	public function Line(w:int, h:int, fcolor:uint, bcolor:uint, lineColor:uint)
	{
		this.w = w;
		this.h = h;
		this.fcolor = fcolor;
		this.bcolor = bcolor;
		this.lineColor = lineColor;
		
		repaint();
	}
	
	public function repaint():void
	{
		this.graphics.clear();
		this.graphics.lineStyle(1, lineColor);
		
		this.graphics.beginFill(bcolor, 0.7);
		this.graphics.drawRect(0, 0, w, h);
		
		var valWidth:int = 0;
		if(maxVal > 0 && curVal > 0)
		{
			valWidth = w * curVal/maxVal;
		}
		this.graphics.beginFill(fcolor, 0.6);
		this.graphics.drawRect(0, 0, valWidth, h);
		
		this.graphics.endFill();
	}
	
}