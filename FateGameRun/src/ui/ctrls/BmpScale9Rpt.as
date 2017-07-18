package ui.ctrls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class BmpScale9Rpt extends Sprite
	{
		private static var srcDic:Dictionary = new Dictionary();
		
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
		
		public function BmpScale9Rpt()
		{
			super();
		}
		
		private var _HRepeat:uint = 1;
		/** 水平重复像素值 */
		public function set HRepeat(value:uint):void
		{
			trace("BmpScale9Rpt::set HRepeat value=", value);
			if(value >= 1)
			{
				_HRepeat = value;
				if(srcDic[source])
				{
					trace("BmpScale9Rpt中srcDic[source]存在");
					srcDic[source].HRepeat = HRepeat;
				}
				//calculateCut();
				resetScale();
			}
			else
			{
				trace("BmpScale9Rpt水平重复像素值小于1像素，这是一个不合理的值");
			}
		}
		public function get HRepeat():uint
		{
			return _HRepeat;
		}
		
		private var _VRepeat:uint = 1;
		/** 垂直重复像素值 */
		public function set VRepeat(value:uint):void
		{
			if(value >= 1)
			{
				_VRepeat = value;
				if(srcDic[source])
				{
					srcDic[source].VRepeat = VRepeat;
				}
				//calculateCut();
				resetScale();
			}
			else
			{
				trace("BmpScale9Rpt水平重复像素值小于1像素，这是一个不合理的值");
			}
		}
		public function get VRepeat():uint
		{
			return _VRepeat;
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
		public function assign(source:BitmapData, scaleGridTop:Number=0, scaleGridBottom:Number=0, scaleGridLeft:Number=0, scaleGridRight:Number=0):void{
			__removeChildren();
			
			this.source = source;
			if(!srcDic[source]){
				srcDic[source] = {};
				srcDic[source].HRepeat = HRepeat;
				srcDic[source].VRepeat = VRepeat;
			}
			
			_srcWidth = source.width;
			_srcHeight = source.height;
			
			calculateCut();
			
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
		
		
		/** 计算分割位置 */
		private function calculateCut():void
		{
			this.scaleGridLeft = int( (_srcWidth - HRepeat) / 2 );
			this.scaleGridRight = int( (_srcWidth + HRepeat) / 2 );
			this.scaleGridTop = int( (_srcHeight - VRepeat) / 2 );
			this.scaleGridBottom = int( (_srcHeight + VRepeat) / 2 );
		}
		
		
		/** 让九个图片格子去获得自己的bmp */
		private function getChildrenBmp():void{
//			if(!srcDic[source].leftUpBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				leftUp = getBitmap(0, 0, scaleGridLeft, scaleGridTop);
				srcDic[source].leftUpBmd = leftUp.bitmapData;
				trace("BmpScale9Rpt::getChildrenBmp() 重新生成");
//			}else{
//				leftUp = new Bitmap(srcDic[source].leftUpBmd);
//				leftUp.x = 0;
//				leftUp.y = 0;
//			}
			//
//			if(!srcDic[source].leftCenterBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				leftCenter = getBitmap(0, scaleGridTop, scaleGridLeft, Math.abs(scaleGridBottom - scaleGridTop));
				srcDic[source].leftCenterBmd = leftCenter.bitmapData;
//			}else{
//				leftCenter = new Bitmap(srcDic[source].leftCenterBmd);
//				leftCenter.x = 0;
//				leftCenter.y = scaleGridTop;
//			}
			//
//			if(!srcDic[source].leftBottomBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				leftBottom = getBitmap(0, scaleGridBottom, scaleGridLeft, Math.abs(source.height - scaleGridBottom));
				srcDic[source].leftBottomBmd = leftBottom.bitmapData;
//			}else{
//				leftBottom = new Bitmap(srcDic[source].leftBottomBmd);
//				leftBottom.x = 0;
//				leftBottom.y = scaleGridBottom;
//			}
			
//			if(!srcDic[source].centerUpBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				centerUp = getBitmap(scaleGridLeft, 0, Math.abs(scaleGridRight - scaleGridLeft), scaleGridTop);
				srcDic[source].centerUpBmd = centerUp.bitmapData;
//			}else{
//				centerUp = new Bitmap(srcDic[source].centerUpBmd);
//				centerUp.x = scaleGridLeft;
//				centerUp.y = 0;
//			}
			
//			if(!srcDic[source].centerBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				center = getBitmap(scaleGridLeft, scaleGridTop, Math.abs(scaleGridRight - scaleGridLeft), Math.abs(scaleGridBottom - scaleGridTop));
				srcDic[source].centerBmd = center.bitmapData;
//			}else{
//				center = new Bitmap(srcDic[source].centerBmd);
//				center.x = scaleGridLeft;
//				center.y = scaleGridTop;
//			}
			//
//			if(!srcDic[source].centerBottomBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				centerBottom = getBitmap(scaleGridLeft, scaleGridBottom, Math.abs(scaleGridRight - scaleGridLeft), Math.abs(source.height - scaleGridBottom));
				srcDic[source].centerBottomBmd = centerBottom.bitmapData;
//			}else{
//				centerBottom = new Bitmap(srcDic[source].centerBottomBmd);
//				centerBottom.x = scaleGridLeft;
//				centerBottom.y = scaleGridBottom;
//			}
			//
//			if(!srcDic[source].rightUpBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				rightUp = getBitmap(scaleGridRight, 0, Math.abs(source.width - scaleGridRight), scaleGridTop);
				srcDic[source].rightUpBmd = rightUp.bitmapData;
//			}else{
//				rightUp = new Bitmap(srcDic[source].rightUpBmd);
//				rightUp.x = scaleGridRight;
//				rightUp.y = 0;
//			}
			//
//			if(!srcDic[source].rightCenterBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				rightCenter = getBitmap(scaleGridRight, scaleGridTop, Math.abs(source.width - scaleGridRight), Math.abs(scaleGridBottom - scaleGridTop));
				srcDic[source].rightCenterBmd = rightCenter.bitmapData;
//			}else{
//				rightCenter = new Bitmap(srcDic[source].rightCenterBmd);
//				rightCenter.x = scaleGridRight;
//				rightCenter.y = scaleGridTop;
//			}
			//
//			if(!srcDic[source].rightBottomBmd || srcDic[source].HRepeat != HRepeat || srcDic[source].VRepeat != VRepeat){
				rightBottom = getBitmap(scaleGridRight, scaleGridBottom, Math.abs(source.width - scaleGridRight), Math.abs(source.height - scaleGridBottom));
				srcDic[source].rightBottomBmd = rightBottom.bitmapData;
//			}else{
//				rightBottom = new Bitmap(srcDic[source].rightBottomBmd);
//				rightBottom.x = scaleGridRight;
//				rightBottom.y = scaleGridBottom;
//			}
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
			tileMe(leftCenter);
			leftBottom.y = _srcHeight - leftBottom.height;
			centerUp.width = _srcWidth - leftUp.width - rightUp.width;
			tileMe(centerUp);
			center.width = centerUp.width;
			center.height = leftCenter.height;
			centerBottom.width = center.width;
			centerBottom.y = leftBottom.y;
			tileMe(centerBottom);
			rightUp.x = _srcWidth - rightUp.width;
			rightCenter.x = rightUp.x;
			rightCenter.height = center.height;
			tileMe(rightCenter);
			rightBottom.x = rightUp.x;
			rightBottom.y = leftBottom.y;
		}
		
		/** 平铺我 */
		private function tileMe(bmp:Bitmap):void
		{
			trace("BmpScale9Rpt::tileMe", bmp.width, bmp.height);
			var needWidth:int = bmp.width;
			var needHeight:int = bmp.height;
			var newBmd:BitmapData = new BitmapData(needWidth, needHeight, true, 0x00000000);
			var shape:Shape = new Shape();
			shape.graphics.beginBitmapFill(bmp.bitmapData);
			shape.graphics.drawRect(0, 0, needWidth, needHeight);
			newBmd.draw(shape);
			//var tmpBmp:Bitmap = new Bitmap(newBmd);
			bmp.bitmapData = newBmd;
			bmp.width = needWidth;
			bmp.height = needHeight;
			//bmp.bitmapData = new BitmapData(200, 50, true, 0x70ff0000);
			//this.addChild(tmpBmp);
			//tmpBmp.y = 320;
		}
		
	}
}