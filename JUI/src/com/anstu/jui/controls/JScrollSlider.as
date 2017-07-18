package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class JScrollSlider extends JSlider
	{
		protected var _thumbPercent:Number = 1.0;
		/** Sets the percentage of the size of the thumb button */
		public function set thumbPercent(value:Number):void
		{
			_thumbPercent = Math.min(value, 1.0);
			invalidate();
		}
		public function get thumbPercent():Number
		{
			return _thumbPercent;
		}
		
		protected var _step:int = 1;
		/** 背景条被点击之后的步长 */
		public function set step(value:int):void
		{
			_step = value;
			invalidate();
		}
		public function get step():int
		{
			return _step;
		}
		
		//JScrollSlider禁止设置滑块宽
		override public function set handleFat(value:int):void {}
		
		/**
		 * Constructor
		 */
		public function JScrollSlider(orientation:String, defaultHandler:Function = null)
		{
			super(orientation, defaultHandler);
			if(_orientation == JuiConst.HORIZONTAL)
			{
				this._type = JuiType.JScrollSliderH;
			}
			else
			{
				this._type = JuiType.JScrollSliderV;
			}
		}
		
		/**
		 * Initializes the component.
		 */
		protected override function init():void
		{
			super.init();
			setSliderParams(1, 1, 0);
			backClick = true;
		}
		
		/**
		 * Draws the handle of the slider.
		 */
		override protected function drawHandle() : void
		{
			var size:Number;
			if(_orientation == JuiConst.HORIZONTAL)
			{
				size = Math.round(_width * _thumbPercent);
				_handle.width = size;
			}
			else
			{
				size = Math.round(_height * _thumbPercent);
				_handle.height = size;
			}
			super.drawHandle();
		}
		
		
		/**
		 * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
		 * @param event The MouseEvent passed by the system.
		 */
		protected override function onBackClick(event:MouseEvent):void
		{
			if(_orientation == JuiConst.HORIZONTAL)
			{
				if(mouseX < _handle.x)
				{
					if(_max > _min)
					{
						_value -= _step;
					}
					else
					{
						_value += _step;
					}
					correctValue();
				}
				else
				{
					if(_max > _min)
					{
						_value += _step;
					}
					else
					{
						_value -= _step;
					}
					correctValue();
				}
				positionHandle();
			}
			else
			{
				if(mouseY < _handle.y)
				{
					if(_max > _min)
					{
						_value -= _step;
					}
					else
					{
						_value += _step;
					}
					correctValue();
				}
				else
				{
					if(_max > _min)
					{
						_value += _step;
					}
					else
					{
						_value -= _step;
					}
					correctValue();
				}
				positionHandle();
			}
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		
	}
}