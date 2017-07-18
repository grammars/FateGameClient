package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class JImage extends JComponent
	{
		/** the filler for background */
		protected var __backgroundFiller:DisplayObject;
		/** 设置背景填充 */
		public function fillBackground(filler:DisplayObject):void
		{
			if(__backgroundFiller && __backgroundFiller.parent) { __backgroundFiller.parent.removeChild(__backgroundFiller); }
			__backgroundFiller = filler;
			if(__backgroundFiller) { this.addChild(__backgroundFiller); }
			invalidate();
		}
		
		protected var _bgAlpha:Number = 1.0;
		/** 背景颜色的alpha */
		public function set bgAlpha(value:Number):void
		{
			_bgAlpha = value;
			invalidate();
		}
		public function get bgAlpha():Number { return _bgAlpha; }
		
		protected var _bgColor:uint = 0x654321;
		/** 背景颜色的Color */
		public function set bgColor(value:uint):void
		{
			_bgColor = value;
			invalidate();
		}
		public function get bgColor():uint { return _bgColor; }
		
		public function JImage()
		{
			super();
			this._type = JuiType.JImage;
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			setSize(100, 100);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			this.graphics.clear();
			if(!__backgroundFiller)
			{
				//this.graphics.lineStyle(1, 0x654321, _bgAlpha);
				this.graphics.beginFill(_bgColor, _bgAlpha);
				this.graphics.drawRect(0, 0, _width, _height);
				this.graphics.endFill();
			}
			else
			{
				__backgroundFiller.width = _width;
				__backgroundFiller.height = _height;
				__backgroundFiller.alpha = _bgAlpha;
			}
		}
		
	}
}