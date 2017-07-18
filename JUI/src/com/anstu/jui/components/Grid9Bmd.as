package com.anstu.jui.components
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Grid9Bmd
	{
		private var source : BitmapData;
		
		private var _scaleGridLeft : Number;
		private var _scaleGridRight : Number;
		private var _scaleGridTop : Number;
		private var _scaleGridBottom : Number;
		
		public function get scaleGridLeft():Number { return _scaleGridLeft; }
		public function get scaleGridRight():Number { return _scaleGridRight; }
		public function get scaleGridTop():Number { return _scaleGridTop; }
		public function get scaleGridBottom():Number { return _scaleGridBottom; }
		
		public var leftUp : BitmapData;
		public var leftCenter : BitmapData;
		public var leftBottom : BitmapData;
		public var centerUp : BitmapData;
		public var center : BitmapData;
		public var centerBottom : BitmapData;
		public var rightUp : BitmapData;
		public var rightCenter : BitmapData;
		public var rightBottom : BitmapData;
		
		private var _srcWidth:Number;
		public function get srcWidth():Number { return _srcWidth; }
		private var _srcHeight:Number;
		public function get srcHeight():Number { return _srcHeight; }
		
		private var _minWidth:Number;
		public function get minWidth():Number { return _minWidth; }
		private var _minHeight:Number;
		public function get minHeight():Number { return _minHeight; }
		
		public function Grid9Bmd(source:BitmapData, scaleGridLeft:Number, scaleGridRight:Number, scaleGridTop:Number, scaleGridBottom:Number)
		{
			this.source = source;
			this._scaleGridTop = scaleGridTop;
			this._scaleGridBottom = scaleGridBottom;
			this._scaleGridLeft = scaleGridLeft;
			this._scaleGridRight = scaleGridRight;
			init();
		}
		
		private function init():void 
		{
			leftUp = getPart(0, 0, _scaleGridLeft, _scaleGridTop);
			leftCenter = getPart(0, _scaleGridTop, _scaleGridLeft, _scaleGridBottom - _scaleGridTop);
			leftBottom = getPart(0, _scaleGridBottom, _scaleGridLeft, source.height - _scaleGridBottom);
			centerUp = getPart(_scaleGridLeft, 0, _scaleGridRight - _scaleGridLeft, _scaleGridTop);
			center = getPart(_scaleGridLeft, _scaleGridTop, _scaleGridRight - _scaleGridLeft, _scaleGridBottom - _scaleGridTop);
			centerBottom = getPart(_scaleGridLeft, _scaleGridBottom, _scaleGridRight - _scaleGridLeft, source.height - _scaleGridBottom);
			rightUp = getPart(_scaleGridRight, 0, source.width - _scaleGridRight, _scaleGridTop);
			rightCenter = getPart(_scaleGridRight, _scaleGridTop, source.width - _scaleGridRight, _scaleGridBottom - _scaleGridTop);
			rightBottom = getPart(_scaleGridRight, _scaleGridBottom, source.width - _scaleGridRight, source.height - _scaleGridBottom);
			_srcWidth = source.width;
			_srcHeight = source.height;
			_minWidth = leftUp.width + rightBottom.width;
			_minHeight = leftBottom.height + rightBottom.height;
		}
		
		private function getPart(x:Number, y:Number, w:Number, h:Number):BitmapData
		{
			var bmd:BitmapData = new BitmapData(w, h);
			bmd.copyPixels(source, new Rectangle(x, y, w, h), new Point(0, 0));
			return bmd;
		}
		
		
	}
}