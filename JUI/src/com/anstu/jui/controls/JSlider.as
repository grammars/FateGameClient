package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JStyle;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	[Event(name="change", type="flash.events.Event")]
	public class JSlider extends JComponent
	{
		protected var _handle:JPushButton;
		protected var _background:Sprite;
		protected var _backClick:Boolean = true;
		protected var _value:Number = 0;
		protected var _max:Number = 100;
		protected var _min:Number = 0;
		protected var _orientation:String;
		protected var _tick:Number = 0.01;
		
		protected var _backgroundFiller:DisplayObject;
		public function fillBackground(filler:DisplayObject):void
		{
			if(_backgroundFiller && _backgroundFiller.parent) { _backgroundFiller.parent.removeChild(_backgroundFiller); }
			_backgroundFiller = filler;
			if(_backgroundFiller) { _background.addChild(_backgroundFiller); }
			drawBack();
		}
		
		public function get handle():JPushButton { return _handle; }
		
		protected var _disabled:Boolean = false;
		/** 是否不可用状态 */
		public function set disabled(value:Boolean):void
		{
			if(_disabled != value)
			{
				_disabled = value;
				_handle.disabled = value;
			}
		}
		public function get disabled():Boolean { return _disabled; }
		
		/** 滑块宽 */
		public function set handleFat(value:int):void
		{
			if(_orientation == JuiConst.HORIZONTAL)
			{
				_handle.width = Math.min(value, _width);
			}
			else
			{
				_handle.height = Math.min(value, _height);
			}
		}
		public function get handleFat():int
		{
			if(_orientation == JuiConst.HORIZONTAL)
			{
				return _handle.width;
			}
			else
			{
				return _handle.height;
			}
		}
		
		public function JSlider(orientation:String = JuiConst.HORIZONTAL, defaultHandler:Function = null)
		{
			_orientation = orientation;
			super();
			if(_orientation == JuiConst.HORIZONTAL)
			{
				this._type = JuiType.JSliderH;
			}
			else
			{
				this._type = JuiType.JSliderV;
			}
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			
			if(_orientation == JuiConst.HORIZONTAL)
			{
				setSize(200, 19);
			}
			else
			{
				setSize(19, 200);
			}
			handleFat = 10;
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_background = new Sprite();
			addChild(_background);
			
			_handle = new JPushButton();
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			_handle.buttonMode = true;
			_handle.useHandCursor = true;
			addChild(_handle);
		}
		
		/**
		 * Draws the back of the slider.
		 */
		protected function drawBack():void
		{
			var useSkin:Boolean = false;
			if(_backgroundFiller) { useSkin = true; }
			_background.graphics.clear();
			if(!useSkin)
			{
				_background.graphics.lineStyle(1, JStyle.SLIDER_BG_LINE);
				_background.graphics.beginFill(JStyle.SLIDER_BG_FILL);
				_background.graphics.drawRect(0, 0, _width, _height);
				_background.graphics.endFill();
			}
			else
			{
				_backgroundFiller.width = _width;
				_backgroundFiller.height = _height;
			}
			if(_backClick)
			{
				_background.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
			}
			else
			{
				_background.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
			}
		}
		
		/**
		 * Draws the handle of the slider.
		 */
		protected function drawHandle():void
		{
			if(_orientation == JuiConst.HORIZONTAL)
			{
				_handle.height = _height;
			}
			else
			{
				_handle.width = _width;
			}
			_handle.x = _handle.y = 0;
			
			positionHandle();
		}
		
		/**
		 * Adjusts value to be within minimum and maximum.
		 */
		protected function correctValue():void
		{
			if(_max > _min)
			{
				_value = Math.min(_value, _max);
				_value = Math.max(_value, _min);
			}
			else
			{
				_value = Math.max(_value, _max);
				_value = Math.min(_value, _min);
			}
		}
		
		/**
		 * Adjusts position of handle when value, maximum or minimum have changed.
		 * TODO: Should also be called when slider is resized.
		 */
		protected function positionHandle():void
		{
			var range:Number;
			if(_orientation == JuiConst.HORIZONTAL)
			{
				range = width - _handle.width;
				_handle.x = (_value - _min) / (_max - _min) * range;
			}
			else
			{
				range = height - _handle.height;
				_handle.y = (_value - _min) / (_max - _min) * range;
			}
		}
		
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			drawBack();
			drawHandle();
		}
		
		/**
		 * Convenience method to set the three main parameters in one shot.
		 * @param min The minimum value of the slider.
		 * @param max The maximum value of the slider.
		 * @param value The value of the slider.
		 */
		public function setSliderParams(min:Number, max:Number, value:Number):void
		{
			this.minimum = min;
			this.maximum = max;
			this.value = value;
		}
		
		
		/**
		 * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onBackClick(event:MouseEvent):void
		{
			if(_orientation == JuiConst.HORIZONTAL)
			{
				_handle.x = mouseX - _height / 2;
				_handle.x = Math.max(_handle.x, 0);
				_handle.x = Math.min(_handle.x, _width - _height);
				_value = _handle.x / (width - _height) * (_max - _min) + _min;
			}
			else
			{
				_handle.y = mouseY - _width / 2;
				_handle.y = Math.max(_handle.y, 0);
				_handle.y = Math.min(_handle.y, _height - _width);
				_value = (_height - _width - _handle.y) / (height - _width) * (_max - _min) + _min;
			}
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		/**
		 * Internal mouseDown handler. Starts dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			if(_orientation == JuiConst.HORIZONTAL)
			{
				_handle.startDrag(false, new Rectangle(0, 0, _width - _handle.width, 0));
			}
			else
			{
				_handle.startDrag(false, new Rectangle(0, 0, 0, _height - _handle.height));
			}
			event.stopPropagation();
		}
		
		/**
		 * Internal mouseUp handler. Stops dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			stopDrag();
		}
		
		/**
		 * Internal mouseMove handler for when the handle is being moved.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onSlide(event:MouseEvent):void
		{
			var oldValue:Number = _value;
			if(_orientation == JuiConst.HORIZONTAL)
			{
				if(_width == _handle.width)
				{
					_value = _min;
				}
				else
				{
					_value = _handle.x / (_width - _handle.width) * (_max - _min) + _min;
				}
			}
			else
			{
				if(_height == _handle.height)
				{
					_value = _min;
				}
				else
				{
					_value = _handle.y / (_height - _handle.height) * (_max - _min) + _min;
				}
			}
			if(_value != oldValue)
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		/**
		 * Sets / gets whether or not a click on the background of the slider will move the handler to that position.
		 */
		public function set backClick(b:Boolean):void
		{
			_backClick = b;
			invalidate();
		}
		public function get backClick():Boolean
		{
			return _backClick;
		}
		
		/**
		 * Sets / gets the current value of this slider.
		 */
		public function set value(v:Number):void
		{
			_value = v;
			correctValue();
			positionHandle();
			
		}
		public function get value():Number
		{
			return Math.round(_value / _tick) * _tick;
		}
		
		/**
		 * Gets the value of the slider without rounding it per the tick value.
		 */
		public function get rawValue():Number
		{
			return _value;
		}
		
		/**
		 * Gets / sets the maximum value of this slider.
		 */
		public function set maximum(m:Number):void
		{
			_max = m;
			correctValue();
			positionHandle();
		}
		public function get maximum():Number
		{
			return _max;
		}
		
		/**
		 * Gets / sets the minimum value of this slider.
		 */
		public function set minimum(m:Number):void
		{
			_min = m;
			correctValue();
			positionHandle();
		}
		public function get minimum():Number
		{
			return _min;
		}
		
		/**
		 * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number. 
		 */
		public function set tick(t:Number):void
		{
			_tick = t;
		}
		public function get tick():Number
		{
			return _tick;
		}
		
		public function get orientation():String { return _orientation; }
		
	}
}