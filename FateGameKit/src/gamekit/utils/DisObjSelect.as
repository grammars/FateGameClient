package gamekit.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.flash_proxy;
	
	import gamekit.FateGameKit;

	public class DisObjSelect
	{
		private static var _stage:Stage;
		public static function set STAGE(value:Stage):void { _stage = value; }
		public static function get STAGE():Stage
		{
			if(_stage == null) { _stage = FateGameKit.STAGE; }
			return _stage;
		}
		
		public function DisObjSelect()
		{
		}
		
		/** 获取指定舞台位置的最顶端的真实的可视对象，即忽略透明部分 */
		public static function getTopReal(stgX:Number,stgY:Number, onlyInteract:Boolean=true):DisplayObject
		{
			var targetDisplay:DisplayObject = STAGE;
			var stagePt:Point = new Point(stgX, stgY);
			var arr:Array = STAGE.getObjectsUnderPoint(stagePt);//取得容器中鼠标处的对象数组 
			var ptLocal:Point;	
			for (var i:int=arr.length-1; i>=0; i--)//从上至下比较,寻找出目标对象
			{
				if( onlyInteract )
				{
					if( (arr[i] is InteractiveObject) && (arr[i] as InteractiveObject).mouseEnabled==true )
					{
						//
					}
					else
					{
						continue;
					}
				}
				ptLocal = arr[i].globalToLocal(stagePt);
				if( arr[i] is Bitmap )
				{					
					if (Bitmap(arr[i]).bitmapData.getPixel32(ptLocal.x,ptLocal.y) != 0)// 不透明       
					{ 
						targetDisplay=arr[i];           
						break;
					}
				}
				else if( arr[i] is TextField )
				{
					targetDisplay = arr[i]; 
					break;
				}
				else
				{
					//取得 ptLocal点的像素
					var rect:Rectangle = new Rectangle(0,0,1,1)
					var mat:Matrix = new Matrix();
					mat.tx = 0-ptLocal.x;
					mat.ty = 0-ptLocal.y;
					var bmd:BitmapData = new BitmapData(rect.width, rect.height,true); 
					bmd.setPixel32(0,0,0x000000);
					bmd.draw(arr[i],mat,null,null,rect);
					if ( (bmd.getPixel32(0,0) >> 24 & 0xFF) != 0 )// 不透明 
					{ 
						targetDisplay=arr[i];
						break;  
					}
				}
			}
			return targetDisplay;
		}
		
	}
}