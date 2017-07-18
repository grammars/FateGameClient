package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class JPanel extends JComponent
	{
		/**
		 * Container for content added to this panel. This is masked, so best to add children to content, rather than directly to the panel.
		 */
		public var content:Sprite;
		
		/** the background */
		protected var _background:Sprite;
		public function get background():Sprite { return _background; }
		/** the filler for background */
		protected var __backgroundFiller:DisplayObject;
		/** 设置背景填充 */
		public function fillBackground(filler:DisplayObject):void
		{
			if(__backgroundFiller && __backgroundFiller.parent) { __backgroundFiller.parent.removeChild(__backgroundFiller); }
			__backgroundFiller = filler;
			if(__backgroundFiller) { _background.addChild(__backgroundFiller); }
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
		
		protected var _bgColor:uint = 0x123670;
		/** 背景颜色的Color */
		public function set bgColor(value:uint):void
		{
			_bgColor = value;
			invalidate();
		}
		public function get bgColor():uint { return _bgColor; }
		
		public function JPanel()
		{
			super();
			this._type = JuiType.JPanel;
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
			_background = new Sprite();
			super.addChild(_background);
			
			content = new Sprite();
			super.addChild(content);
		}
		
		/**
		 * Overridden to add new child to content.
		 */
		public override function addChild(child:DisplayObject):DisplayObject
		{
			content.addChild(child);
			return child;
		}
		
		/** clear the children in content */
		public function clearContent():void
		{
			var cn:int = content.numChildren;
			for(var i:int = 0; i < cn; i++)
			{
				content.removeChildAt(0);
			}
		}
		
		/**
		 * Access to super.addChild
		 */
		public function addRawChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			return child;
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_background.graphics.clear();
			//_background.graphics.lineStyle(1, 0x123456, _bgAlpha);
			if(!__backgroundFiller)
			{
				_background.graphics.beginFill(_bgColor, _bgAlpha);
			}
			else
			{
				_background.graphics.beginFill(0x0, 0);
				__backgroundFiller.width = _width;
				__backgroundFiller.height = _height;
				__backgroundFiller.alpha = _bgAlpha;
			}
			_background.graphics.drawRect(0, 0, _width, _height);
			_background.graphics.endFill();
		}
		
	}
}