package gamekit.map.material
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class AroundTraver
	{
		public function AroundTraver()
		{
		}
		
		public static function find(centreX:int, centreY:int, radius:Number):Array
		{
			/** 切片序号策略数组 */
			var tilesIndArr:Array = [];
			var centre:Point = new Point(centreX, centreY);
			tilesIndArr.push(centre);
			var limit:int = radius;
			//右手螺旋定则旋转
			const R:int = 0, U:int = 1, L:int = 2, D:int = 3;
			var DIR:Array = [R, U, L, D];
			var last:Point = new Point(centre.x, centre.y);
			for(var i:int = 0; i <= limit*4; i++)
			//for(var i:int = 1; i <= limit*4; i++)
			{
				var theDir:int = DIR[(i)%4];
				//var theDir:int = DIR[(i-1)%4];
				for(var a:int = 0; a <= int(i/2); a++)
				//for(var a:int = 1; a <= int((i+1)/2); a++)
				{
					var next:Point = new Point(last.x, last.y);
					switch(theDir)
					{
						case R:
							next.x++;
							break;
						case U:
							next.y--;
							break;
						case L:
							next.x--;
							break;
						case D:
							next.y++;
							break;
					}
					last.x = next.x;
					last.y = next.y;
					tilesIndArr.push(next);
				}
			}
			tilesIndArr.pop()
			return tilesIndArr;
		}
		
		public static function demo(ctn:DisplayObjectContainer, arr:Array):void
		{
			new Demo(ctn, arr);
		}
		
	}
}


import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.geom.Point;
import flash.utils.clearInterval;
import flash.utils.setInterval;

class Demo
{
	private var ctn:DisplayObjectContainer;
	private var arr:Array;
	
	private var timeId:uint;
	
	public function Demo(ctn:DisplayObjectContainer, arr:Array)
	{
		this.ctn = ctn;
		this.arr = arr;
		timeId = setInterval(__playing, 30);
	}
	
	private var isFirst:Boolean = true;
	
	private function __playing():void
	{
		if(arr.length <= 0)
		{
			clearInterval(timeId);
			return;
		}
		var pt:Point = arr.shift();
		var sp:Shape = new Shape();
		if(isFirst)
		{
			sp.graphics.beginFill(0x0000ff, 0.3);
		}
		else
		{
			sp.graphics.beginFill(0x00ffff, 0.3);
		}
		sp.graphics.drawRect(0, 0, 20, 20);
		sp.graphics.endFill();
		sp.x = pt.x * 25;
		sp.y = pt.y * 25;
		ctn.addChild(sp);
		isFirst = false;
	}
}