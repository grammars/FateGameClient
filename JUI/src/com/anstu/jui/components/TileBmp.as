package com.anstu.jui.components
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class TileBmp extends Sprite
	{
		protected var _bmd:BitmapData;
		public function set bmd(value:BitmapData):void
		{
			_bmd = value;
			repaint();
		}
	 	public function get bmd():BitmapData { return _bmd; }
		
		protected var _repeat:Boolean = true;
		public function set repeat(value:Boolean):void
		{
			_repeat = value;
			repaint();
		}
		public function get repeat():Boolean { return _repeat; }
		
		public function TileBmp(bmd:BitmapData=null)
		{
			super();
			this.bmd = bmd;
		}
		
		protected var _width:Number = 0;
		override public function set width(value:Number):void
		{
			_width = value;
			repaint();
		}
		override public function get width():Number { return _width; }
		
		protected var _height:Number = 0;
		override public function set height(value:Number):void
		{
			_height = value;
			repaint();
		}
		override public function get height():Number { return _height; }
		
		protected function repaint():void
		{
			this.graphics.clear();
			if(_bmd)
			{
				this.graphics.beginBitmapFill(_bmd, null, true, false);
				if(!repeat)
				{
					var drawW:int = Math.min(_width, _bmd.width);
					var drawH:int = Math.min(_height, _bmd.height);
					this.graphics.drawRect(0, 0, drawW, drawH);
				}
				else
				{
					this.graphics.drawRect(0, 0, _width, _height);
				}
				this.graphics.endFill();
			}
		}
		
	}
}