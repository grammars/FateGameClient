package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JStyle;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class JPushButton extends JComponent
	{
		protected var _back:Sprite;
		protected var _face:Sprite;
		protected var _label:JLabel;
		protected var _over:Boolean = false;
		protected var _down:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _toggle:Boolean = false;
		
		public function get label():JLabel { return _label; }
		
		public var style_default_line:uint = JStyle.BTN_DEFAULT_LINE;
		public var style_default_fill:uint = JStyle.BTN_DEFAULT_FILL;
		public var style_over_line:uint = JStyle.BTN_OVER_LINE;
		public var style_over_fill:uint = JStyle.BTN_OVER_FILL;
		public var style_down_line:uint = JStyle.BTN_DOWN_LINE;
		public var style_down_fill:uint = JStyle.BTN_DOWN_FILL;
		public var style_disabled_line:uint = JStyle.BTN_DISABLED_LINE;
		public var style_disabled_fill:uint = JStyle.BTN_DISABLED_FILL;
		
		protected var _defaultBgFiller:DisplayObject;
		public function fillDefaultBg(filler:DisplayObject):void
		{
			if(_defaultBgFiller && _defaultBgFiller.parent) { _defaultBgFiller.parent.removeChild(_defaultBgFiller); }
			_defaultBgFiller = filler;
			if(_defaultBgFiller) { _back.addChild(_defaultBgFiller); }
			invalidate();
		}
		
		protected var _overBgFiller:DisplayObject;
		public function fillOverBg(filler:DisplayObject):void
		{
			if(_overBgFiller && _overBgFiller.parent) { _overBgFiller.parent.removeChild(_overBgFiller); }
			_overBgFiller = filler;
			if(_overBgFiller) { _back.addChild(_overBgFiller); }
			invalidate();
		}
		
		protected var _downBgFiller:DisplayObject;
		public function fillDownBg(filler:DisplayObject):void
		{
			if(_downBgFiller && _downBgFiller.parent) { _downBgFiller.parent.removeChild(_downBgFiller); }
			_downBgFiller = filler;
			if(_downBgFiller) { _back.addChild(_downBgFiller); }
			invalidate();
		}
		
		protected var _disabledBgFiller:DisplayObject;
		public function fillDisabledBg(filler:DisplayObject):void
		{
			if(_disabledBgFiller && _disabledBgFiller.parent) { _disabledBgFiller.parent.removeChild(_disabledBgFiller); }
			_disabledBgFiller = filler;
			//if(_disabledBgFiller) { _back.addChild(_disabledBgFiller); }
			invalidate();
		}
		
		protected var _faceFiller:DisplayObject;
		public function fillFace(filler:DisplayObject):void
		{
			if(_faceFiller && _faceFiller.parent) { _faceFiller.parent.removeChild(_faceFiller); }
			_faceFiller = filler;
			if(_faceFiller) { _face.addChild(_faceFiller); };
			invalidate();
		}
		
		protected var _disabled:Boolean = false;
		/** 是否不可用状态 */
		public function set disabled(value:Boolean):void
		{
			if(_disabled != value)
			{
				_disabled = value;
				this.mouseEnabled = this.mouseChildren = !_disabled;
				invalidate();
			}
		}
		public function get disabled():Boolean { return _disabled; }
		
		public function JPushButton(caption:String = "", defaultHandler:Function = null)
		{
			super();
			this._type = JuiType.JPushButton;
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
			this.label.text = caption;
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
			setSize(100, 20);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.mouseEnabled = _back.mouseChildren = false;
			addChild(_back);
			
			_face = new Sprite();
			_face.mouseEnabled = _face.mouseChildren = false;
			addChild(_face);
			
			_label = new JLabel();
			_label.mouseEnabled = _label.mouseChildren = false;
			addChild(_label);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		protected function drawFace():void
		{
			if(_faceFiller)
			{
				_faceFiller.x = (_width - _faceFiller.width)/2;
				_faceFiller.y = (_height - _faceFiller.height)/2;
			}
		}
		
		/** 互斥显示 */
		protected function fillerVisualMutex(showFiller:DisplayObject):void
		{
			function compare(show:DisplayObject, check:DisplayObject):void
			{
				if(show == check) { if(check) { _back.addChild(check); } }
				else { if(check && check.parent) { check.parent.removeChild(check); } }
			}
			compare(showFiller, _defaultBgFiller);
			compare(showFiller, _downBgFiller);
			compare(showFiller, _overBgFiller);
			compare(showFiller, _disabledBgFiller);
		}
		
		protected function drawBackNew():void
		{
			_back.graphics.clear();
			if(_disabled)
			{
				if(_disabledBgFiller)
				{
					_disabledBgFiller.width = _width;
					_disabledBgFiller.height = _height;
					fillerVisualMutex(_disabledBgFiller);
				}
				else
				{
					_back.graphics.lineStyle(1, style_disabled_line);
					_back.graphics.beginFill(style_disabled_fill);
					fillerVisualMutex(null);
				}
			}
			else
			{
				if(_down)
				{
					if(_downBgFiller)
					{
						_downBgFiller.width = _width;
						_downBgFiller.height = _height;
						fillerVisualMutex(_downBgFiller);
					}
					else
					{
						_back.graphics.lineStyle(1, style_down_line);
						_back.graphics.beginFill(style_down_fill);
						fillerVisualMutex(null);
					}
				}
				else
				{
					if(_over)
					{
						if(_overBgFiller)
						{
							_overBgFiller.width = _width;
							_overBgFiller.height = _height;
							fillerVisualMutex(_overBgFiller);
						}
						else
						{
							_back.graphics.lineStyle(1, style_over_line);
							_back.graphics.beginFill(style_over_fill);
							fillerVisualMutex(null);
						}
					}
					else
					{
						if(_defaultBgFiller)
						{
							_defaultBgFiller.width = _width;
							_defaultBgFiller.height = _height;
							fillerVisualMutex(_defaultBgFiller);
						}
						else
						{
							_back.graphics.lineStyle(1, style_default_line);
							_back.graphics.beginFill(style_default_fill);
							fillerVisualMutex(null);
						}
					}
				}
			}
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
		}
		
		protected function drawBack():void
		{
			drawBackNew();
			return;
			
			var useSkin:Boolean = false;
			if(_defaultBgFiller && _downBgFiller && _overBgFiller)
			{
				useSkin = true;
			}
			
			_back.graphics.clear();
			if(useSkin)
			{
				if(_disabled)
				{
					_disabledBgFiller.width = _width;
					_disabledBgFiller.height = _height;
					fillerVisualMutex(_disabledBgFiller);
				}
				else
				{
					if(_down)
					{
						_downBgFiller.width = _width;
						_downBgFiller.height = _height;
						fillerVisualMutex(_downBgFiller);
					}
					else
					{
						if(_over)
						{
							_overBgFiller.width = _width;
							_overBgFiller.height = _height;
							fillerVisualMutex(_overBgFiller);
						}
						else
						{
							_defaultBgFiller.width = _width;
							_defaultBgFiller.height = _height;
							fillerVisualMutex(_defaultBgFiller);
						}
					}
				}
			}
			else
			{
				if(_disabled)
				{
					_back.graphics.lineStyle(1, style_disabled_line);
					_back.graphics.beginFill(style_disabled_fill);
				}
				else
				{
					if(_down)
					{
						_back.graphics.lineStyle(1, style_down_line);
						_back.graphics.beginFill(style_down_fill);
					}
					else
					{
						if(_over)
						{
							_back.graphics.lineStyle(1, style_over_line);
							_back.graphics.beginFill(style_over_fill);
						}
						else
						{
							_back.graphics.lineStyle(1, style_default_line);
							_back.graphics.beginFill(style_default_fill);
						}
					}
				}
				_back.graphics.drawRect(0, 0, _width, _height);
				_back.graphics.endFill();
			}
		}
		
		protected function drawLabel():void
		{
			_label.align = JuiConst.CENTER;
			_label.valign = JuiConst.MIDDLE;
			_label.width = _width;
			_label.height = _height;
			_label.draw();
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			drawBack();
			drawFace();
			drawLabel();
		}
		
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOver(event:MouseEvent):void
		{
			_over = true;
			draw();
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOut(event:MouseEvent):void
		{
			_over = false;
			if(!_down)
			{
				draw();
			}
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoDown(event:MouseEvent):void
		{
			_down = true;
			draw();
			if(stage)
			{
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
			}
		}
		
		/**
		 * Internal mouseUp handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoUp(event:MouseEvent):void
		{
			if(_toggle  && _over)
			{
				_selected = !_selected;
			}
			_down = _selected;
			draw();
			if(stage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
			}
		}
		
		/**
		 * Sets / gets the label text shown on this Pushbutton.
		 */
		public function set caption(str:String):void
		{
			label.text = str;
		}
		public function get caption():String
		{
			return label.text;
		}
		
		public function set selected(value:Boolean):void
		{
			if(!_toggle)
			{
				value = false;
			}
			
			_selected = value;
			_down = _selected;
			draw();
		}
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set toggle(value:Boolean):void
		{
			_toggle = value;
		}
		public function get toggle():Boolean
		{
			return _toggle;
		}
		
	}
}