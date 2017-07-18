package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	[Event(name="change", type="flash.events.Event")]
	public class JScrollBar extends JComponent
	{
		protected const DELAY_TIME:int = 200;
		protected const REPEAT_TIME:int = 100; 
		protected const UP:String = "up";
		protected const DOWN:String = "down";
		
		protected var _autoHide:Boolean = false;
		protected var _upButton:JPushButton;
		protected var _downButton:JPushButton;
		protected var _scrollSlider:JScrollSlider;
		protected var _orientation:String;
		public function get orientation():String { return _orientation; }
		protected var _step:int = 10;
		protected var _delayTimer:Timer;
		protected var _repeatTimer:Timer;
		protected var _direction:String;
		protected var _shouldRepeat:Boolean = false;
		
		public function get upButton():JPushButton { return _upButton; }
		public function get downButton():JPushButton { return _downButton; }
		public function get scrollSlider():JScrollSlider { return _scrollSlider; }
		
		/** 组件的胖度(根据水平或者垂直 影响/取决于 width 或 宽度) */
		public function set fatSize(fs:int):void
		{
			if(_orientation == JuiConst.HORIZONTAL)
			{
				height = fs;
			}
			else
			{
				width = fs;
			}
		}
		public function get fatSize():int
		{
			if(_orientation == JuiConst.HORIZONTAL)
			{
				return height;
			}
			else
			{
				return width;
			}
		}
		
		protected var _disabled:Boolean = false;
		/** 是否不可用状态 */
		public function set disabled(value:Boolean):void
		{
			if(_disabled != value)
			{
				_disabled = value;
				_upButton.disabled = value;
				_downButton.disabled = value;
				_scrollSlider.disabled = value;
			}
		}
		public function get disabled():Boolean { return _disabled; }
		
		public function JScrollBar(orientation:String, defaultHandler:Function = null)
		{
			_orientation = orientation;
			super();
			if(_orientation == JuiConst.HORIZONTAL)
			{
				this._type = JuiType.JScrollBarH;
			}
			else
			{
				this._type = JuiType.JScrollBarV;
			}
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_scrollSlider = new JScrollSlider(_orientation, onChange);
			this.addChild(_scrollSlider);
			_upButton = new JPushButton("");
			this.addChild(_upButton);
			_upButton.addEventListener(MouseEvent.MOUSE_DOWN, onUpClick);
			
			_downButton = new JPushButton("");
			this.addChild(_downButton);
			_downButton.addEventListener(MouseEvent.MOUSE_DOWN, onDownClick);
		}
		
		/**
		 * Initializes the component.
		 */
		protected override function init():void
		{
			super.init();
			if(_orientation == JuiConst.HORIZONTAL)
			{
				setSize(100, 20);
				setUpDownBtnSize(24, 20);
			}
			else
			{
				setSize(20, 100);
				setUpDownBtnSize(20, 24);
			}
			_delayTimer = new Timer(DELAY_TIME, 1);
			_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayComplete);
			_repeatTimer = new Timer(REPEAT_TIME);
			_repeatTimer.addEventListener(TimerEvent.TIMER, onRepeat);
		}
		
		public function setUpDownBtnSize(w:int, h:int):void
		{
			upButton.setSize(w, h);
			downButton.setSize(w, h);
		}
		
		/**
		 * Convenience method to set the three main parameters in one shot.
		 * @param min The minimum value of the slider.
		 * @param max The maximum value of the slider.
		 * @param value The value of the slider.
		 */
		public function setSliderParams(min:Number, max:Number, value:Number):void
		{
			_scrollSlider.setSliderParams(min, max, value);
		}
		
		/**
		 * Sets the percentage of the size of the thumb button.
		 */
		public function set thumbPercent(value:Number):void
		{
			_scrollSlider.thumbPercent = value;
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			if(_orientation == JuiConst.VERTICAL)
			{
				//_upButton.width = _upButton.height = _downButton.width = _downButton.height = _width;
				_scrollSlider.x = 0;
				_scrollSlider.y = _upButton.height;
				_scrollSlider.width = _width;
				_scrollSlider.height = _height - (_upButton.height + _downButton.height);//_scrollSlider.height = _height - 2*_width;
				_downButton.x = 0;
				_downButton.y = _height - _downButton.height;
			}
			else
			{
				//_upButton.width = _upButton.height = _downButton.width = _downButton.height = _height;
				_scrollSlider.x = _upButton.width;
				_scrollSlider.y = 0;
				_scrollSlider.width = _width - (_upButton.width + _downButton.width);
				_scrollSlider.height = _height;
				_downButton.x = _width - _downButton.width;
				_downButton.y = 0;
			}
			_scrollSlider.draw();
			if(_autoHide)
			{
				visible = _scrollSlider.thumbPercent < 1.0;
			}
			else
			{
				visible = true;
			}
		}
		
		
		/**
		 * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
		 */
		public function set autoHide(value:Boolean):void
		{
			_autoHide = value;
			invalidate();
		}
		public function get autoHide():Boolean
		{
			return _autoHide;
		}
		
		/**
		 * Sets / gets the current value of this scroll bar.
		 */
		public function set value(v:Number):void
		{
			_scrollSlider.value = v;
		}
		public function get value():Number
		{
			return _scrollSlider.value;
		}
		
		/**
		 * Sets / gets the minimum value of this scroll bar.
		 */
		public function set minimum(v:Number):void
		{
			_scrollSlider.minimum = v;
		}
		public function get minimum():Number
		{
			return _scrollSlider.minimum;
		}
		
		/**
		 * Sets / gets the maximum value of this scroll bar.
		 */
		public function set maximum(v:Number):void
		{
			_scrollSlider.maximum = v;
		}
		public function get maximum():Number
		{
			return _scrollSlider.maximum;
		}
		
		/** 滑块移动的步长when up or down buttons are pressed. */
		public function set step(value:int):void
		{
			_step = value;
			_scrollSlider.step = value;
			invalidate();
		}
		public function get step():int
		{
			return _step;
		}
		
		protected function onUpClick(event:MouseEvent):void
		{
			goUp();
			_shouldRepeat = true;
			_direction = UP;
			_delayTimer.start();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function goUp():void
		{
			_scrollSlider.value -= _step;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onDownClick(event:MouseEvent):void
		{
			goDown();
			_shouldRepeat = true;
			_direction = DOWN;
			_delayTimer.start();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function goDown():void
		{
			_scrollSlider.value += _step;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			_delayTimer.stop();
			_repeatTimer.stop();
			_shouldRepeat = false;
		}
		
		protected function onChange(event:Event):void
		{
			dispatchEvent(event);
		}
		
		protected function onDelayComplete(event:TimerEvent):void
		{
			if(_shouldRepeat)
			{
				_repeatTimer.start();
			}
		}
		
		protected function onRepeat(event:TimerEvent):void
		{
			if(_direction == UP)
			{
				goUp();
			}
			else
			{
				goDown();
			}
		}
		
	}
}

