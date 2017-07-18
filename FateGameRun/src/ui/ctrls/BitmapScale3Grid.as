package ui.ctrls{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapScale3Grid extends Sprite{
		
		private var source : BitmapData;
		public var scaleGridLeft : Number;
		public var scaleGridRight : Number;
		
		private var left : Bitmap;
		private var center : Bitmap;
		private var right : Bitmap;
		
		public var _srcWidth : Number;
		public var _srcHeight : Number;
		
		private var minWidth : Number;
		
		public var inited:Boolean = false;
		
		public function BitmapScale3Grid() {
			
		}
		
		override public function set width(w : Number) : void {
			if(w >= minWidth) {
				_srcWidth = w;
				this.scaleX = 1;
				refurbishSize();
			}else{
				_srcWidth = minWidth;
				refurbishSize();
				this.scaleX = w / minWidth;
			}
		}
		
		
		private const CSPACE:int = 2;
		
		/** 赋各种重要的值 */
		public function assign(source:BitmapData):void{
			__removeChildren();
			
			this.source = source;
			
			_srcWidth = source.width;
			_srcHeight = source.height;
			
			this.scaleGridLeft = int( (_srcWidth - CSPACE) / 2 );
			this.scaleGridRight = int( (_srcWidth + CSPACE) / 2 );
			
			if(this.scaleGridRight >= _srcWidth){
				this.scaleGridRight = _srcWidth - 1;
			}
			if(this.scaleGridLeft >= this.scaleGridRight){
				this.scaleGridLeft = this.scaleGridRight - 1;
			}
			getChildrenBmp();
			addChildren();
			setMinRect();
			
			inited = true;
		}
		
		
		/** 让三个图片格子去获得自己的bmp */
		private function getChildrenBmp() : void {
			left = getBitmap(0, 0, scaleGridLeft, _srcHeight);
			center = getBitmap(scaleGridLeft, 0, scaleGridRight - scaleGridLeft, _srcHeight);
			right = getBitmap(scaleGridRight, 0, source.width - scaleGridRight, _srcHeight);
		}
		
		
		/** 设置最小宽度 */
		private function setMinRect():void{
			minWidth = left.width + right.width + 1;
		}
		
		
		/** 将这九个图片格子都添加至this显示列表中去 */
		private function addChildren():void{
			this.addChild(left);
			this.addChild(center);
			this.addChild(right);
		}
		
		
		/** 移除this显示列表中的所有显示对象 */
		private function __removeChildren():void{
			for(var i:int = this.numChildren ; i > 0 ; i--){
				this.removeChild(this.getChildAt(0));
			}
		}
		
		
		/** 每个图片格子获取bmp的方法 */
		private function getBitmap(x:Number, y:Number, w:Number, h:Number) : Bitmap {
			//trace("getBitmap w : " + w);
			//trace("getBitmap h : " + h);
			x = Math.abs(x);
			y = Math.abs(y);
			w = Math.abs(w);
			h = Math.abs(h);
			if(x > source.width){
				x = 0;
			}
			if(y > source.height){
				y = 0;
			}
			if(w == 0){
				w = 1;
			}
			if(h == 0){
				h = 1;
			}
			var bit:BitmapData = new BitmapData(w, h);
			bit.copyPixels(source, new Rectangle(x, y, w, h), new Point(0, 0));
			var bitMap:Bitmap = new Bitmap(bit);
			bitMap.x = x;
			bitMap.y = y;
			return bitMap;
		}
		
		
		public function resetScale():void{
			if(inited == false){
				return;
			}
			__removeChildren();
			getChildrenBmp();
			setMinRect();
			addChildren();
			refurbishSize();
		}
		
		
		public function refurbishSize() : void {
			if(inited == false){
				return;
			}
			center.width = _srcWidth - left.width - right.width;
			right.x = _srcWidth - right.width;
		}
	}
}
