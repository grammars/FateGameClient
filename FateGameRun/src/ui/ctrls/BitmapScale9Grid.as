package ui.ctrls{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapScale9Grid extends Sprite{
		
		private var source : BitmapData;
		public var scaleGridTop : Number;
		public var scaleGridBottom : Number;
		public var scaleGridLeft : Number;
		public var scaleGridRight : Number;
		
		private var leftUp : Bitmap;
		private var leftCenter : Bitmap;
		private var leftBottom : Bitmap;
		private var centerUp : Bitmap;
		private var center : Bitmap;
		private var centerBottom : Bitmap;
		private var rightUp : Bitmap;
		private var rightCenter : Bitmap;
		private var rightBottom : Bitmap;
		
		public var _srcWidth : Number;
		public var _srcHeight : Number;
		
		private var minWidth : Number;
		private var minHeight : Number;
		
		public var inited:Boolean = false;
		
		public function BitmapScale9Grid() {
			
		}
		
		
		override public function set width(w : Number) : void {
			if(w < minWidth) {
				w = minWidth;
			}
			_srcWidth = w;
			refurbishSize();
		}
		
		override public function set height(h : Number) : void {
			if(h < minHeight) {
				h = minHeight;
			}
			_srcHeight = h;
			refurbishSize();
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
			this.scaleGridTop = int( (_srcHeight - CSPACE) / 2 );
			this.scaleGridBottom = int( (_srcHeight + CSPACE) / 2 );
			
			
			if(this.scaleGridBottom >= _srcHeight){
				this.scaleGridBottom = _srcHeight - 1;
			}
			if(this.scaleGridTop >= this.scaleGridBottom){
				this.scaleGridTop = this.scaleGridBottom - 1;
			}
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
		
		
		/** 让九个图片格子去获得自己的bmp */
		private function getChildrenBmp():void{
			leftUp = getBitmap(0, 0, scaleGridLeft, scaleGridTop);
			leftCenter = getBitmap(0, scaleGridTop, scaleGridLeft, Math.abs(scaleGridBottom - scaleGridTop));
			leftBottom = getBitmap(0, scaleGridBottom, scaleGridLeft, Math.abs(source.height - scaleGridBottom));
			centerUp = getBitmap(scaleGridLeft, 0, Math.abs(scaleGridRight - scaleGridLeft), scaleGridTop);
			center = getBitmap(scaleGridLeft, scaleGridTop, Math.abs(scaleGridRight - scaleGridLeft), Math.abs(scaleGridBottom - scaleGridTop));
			centerBottom = getBitmap(scaleGridLeft, scaleGridBottom, Math.abs(scaleGridRight - scaleGridLeft), Math.abs(source.height - scaleGridBottom));
			rightUp = getBitmap(scaleGridRight, 0, Math.abs(source.width - scaleGridRight), scaleGridTop);
			rightCenter = getBitmap(scaleGridRight, scaleGridTop, Math.abs(source.width - scaleGridRight), Math.abs(scaleGridBottom - scaleGridTop));
			rightBottom = getBitmap(scaleGridRight, scaleGridBottom, Math.abs(source.width - scaleGridRight), Math.abs(source.height - scaleGridBottom));
		}
		
		
		/** 设置最小宽度 和 最小高度 */
		private function setMinRect():void{
			minWidth = this.leftUp.width + this.rightUp.width + 1;
			minHeight = this.leftUp.height + this.leftBottom.height + 1;
		}
		
		
		/** 将这九个图片格子都添加至this显示列表中去 */
		private function addChildren():void{
			this.addChild(leftUp);
			this.addChild(leftCenter);
			this.addChild(leftBottom);
			this.addChild(centerUp);
			this.addChild(center);
			this.addChild(centerBottom);
			this.addChild(rightUp);
			this.addChild(rightCenter);
			this.addChild(rightBottom);
		}
		
		
		/** 移除this显示列表中的所有显示对象 */
		private function __removeChildren():void{
			for(var i:int = this.numChildren ; i > 0 ; i--){
				this.removeChild(this.getChildAt(0));
			}
		}
		
		
		/** 每个图片格子获取bmp的方法 */
		private function getBitmap(x:Number, y:Number, w:Number, h:Number) : Bitmap {
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
			var bit:BitmapData = new BitmapData(w , h);
			bit.copyPixels(source, new Rectangle(x , y , w , h), new Point(0, 0));
			var bitMap:Bitmap = new Bitmap(bit);
			bitMap.x = x;
			bitMap.y = y;
			return bitMap;
		}
		
		
		/** 重新设定上下左右维持之后的提供的刷新方法 */
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
		
		
		/** 刷新调整九个格子的宽高与位置 */
		public function refurbishSize() : void {
			if(inited == false){
				return;
			}
			leftCenter.height = _srcHeight - leftUp.height - leftBottom.height;
			//tileMe(leftCenter);//尝试性的，感觉不怎么可行
			leftBottom.y = _srcHeight - leftBottom.height;
			centerUp.width = _srcWidth - leftUp.width - rightUp.width;
			center.width = centerUp.width;
			center.height = leftCenter.height;
			centerBottom.width = center.width;
			centerBottom.y = leftBottom.y;
			rightUp.x = _srcWidth - rightUp.width;
			rightCenter.x = rightUp.x;
			rightCenter.height = center.height;
			rightBottom.x = rightUp.x;
			rightBottom.y = leftBottom.y;
		}
		
		/** 平铺我 */
		private function tileMe(bmp:Bitmap):void
		{
			var needWidth:int = bmp.width;
			var needHeight:int = bmp.height;
			var newBmd:BitmapData = new BitmapData(needWidth, needHeight, true, 0x00000000);
			var shape:Shape = new Shape();
			shape.graphics.beginBitmapFill(bmp.bitmapData);
			shape.graphics.drawRect(0, 0, needWidth, needHeight);
			newBmd.draw(shape);
			bmp.bitmapData = newBmd;
		}
		
	}
}
