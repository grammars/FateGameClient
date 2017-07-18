package com.anstu.jui.components
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Grid9Bmp extends Sprite
	{
		private var leftUp:Bitmap = new Bitmap();
		private var leftCenter:Bitmap = new Bitmap();
		private var leftBottom:Bitmap = new Bitmap();
		private var centerUp:Bitmap = new Bitmap();
		private var center:Bitmap = new Bitmap();
		private var centerBottom:Bitmap = new Bitmap();
		private var rightUp:Bitmap = new Bitmap();
		private var rightCenter:Bitmap = new Bitmap();
		private var rightBottom:Bitmap = new Bitmap();
		
		private var _width:Number;
		private var _height:Number;
		
		private var _minWidth:Number;
		private var _minHeight:Number;
		
		private var _bmd:Grid9Bmd;
		public function set bmd(value:Grid9Bmd):void
		{
			_bmd = value;
			if(_bmd)
			{
				_width = _bmd.srcWidth;
				_height = _bmd.srcHeight;
				_minWidth = _bmd.srcWidth;
				_minHeight = _bmd.srcHeight;
				
				leftUp.bitmapData = _bmd.leftUp;
				leftCenter.bitmapData = _bmd.leftCenter;
				leftBottom.bitmapData = _bmd.leftBottom;
				centerUp.bitmapData = _bmd.centerUp;
				center.bitmapData = _bmd.center;
				centerBottom.bitmapData = _bmd.centerBottom;
				rightUp.bitmapData = _bmd.rightUp;
				rightCenter.bitmapData = _bmd.rightCenter;
				rightBottom.bitmapData = _bmd.rightBottom;
				
				initPos();
				refurbishSize();
			}
		}
		public function get bmd():Grid9Bmd { return _bmd; }
		
		public function Grid9Bmp(bmd:Grid9Bmd=null)
		{
			super();
			if(bmd)
			{
				this.bmd = bmd;
			}
			init();
		}
		
		private function init():void
		{
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
		
		override public function set width(w:Number):void
		{	
			if(w < _minWidth)
			{
				this.scaleX = w/_minWidth;
				w = _minWidth;
			}
			else
			{
				this.scaleX = 1;
			}
			_width = w;
			refurbishSize();
		}
		
		override public function set height(h:Number):void
		{	
			if(h < _minHeight)
			{	
				this.scaleY = h/_minHeight;
				h = _minHeight;	
			}
			else
			{
				this.scaleY = 1;
			}
			_height = h;
			refurbishSize();	
		}
		
		private function initPos():void
		{
			leftUp.x = 0;
			leftUp.y = 0;
			leftCenter.x = 0;
			leftCenter.y = _bmd.scaleGridTop;
			leftBottom.x = 0;
			leftBottom.y =  _bmd.scaleGridBottom;
			centerUp.x = _bmd.scaleGridLeft;
			centerUp.y = 0;
			center.x = _bmd.scaleGridLeft;
			center.y = _bmd.scaleGridTop;
			centerBottom.x = _bmd.scaleGridLeft;
			centerBottom.y = _bmd.scaleGridBottom;
			rightUp.x = _bmd.scaleGridRight;
			rightUp.y = 0;
			rightCenter.x = _bmd.scaleGridRight;
			rightCenter.y = _bmd.scaleGridTop;
			rightBottom.x = _bmd.scaleGridRight;
			rightBottom.y = _bmd.scaleGridBottom;
		}
		
		private function refurbishSize():void
		{	
			leftCenter.height = _height - leftUp.height - leftBottom.height;	
			leftBottom.y = _height - leftBottom.height;
			centerUp.width = _width - leftUp.width - rightUp.width;
			center.width = centerUp.width;
			center.height = leftCenter.height;
			centerBottom.width = center.width;
			centerBottom.y = leftBottom.y;
			rightUp.x = _width - rightUp.width;
			rightCenter.x = rightUp.x;
			rightCenter.height = center.height;
			rightBottom.x = rightUp.x;
			rightBottom.y = leftBottom.y;
		}
		
	}
}