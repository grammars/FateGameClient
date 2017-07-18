package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	[Event(name="change", type="flash.events.Event")]
	public class JText extends JBaseText
	{
		private var _over:Boolean = false;
		
		protected var _editable:Boolean = true;
		protected var _panel:JPanel;
		protected var _selectable:Boolean = true;
		
		protected var _defaultBgFiller:DisplayObject;
		public function fillDefaultBg(filler:DisplayObject):void
		{
			if(_defaultBgFiller && _defaultBgFiller.parent) { _defaultBgFiller.parent.removeChild(_defaultBgFiller); }
			_defaultBgFiller = filler;
			invalidate();
		}
		
		protected var _overBgFiller:DisplayObject;
		public function fillOverBg(filler:DisplayObject):void
		{
			if(_overBgFiller && _overBgFiller.parent) { _overBgFiller.parent.removeChild(_overBgFiller); }
			_overBgFiller = filler;
			invalidate();
		}
		
		protected var _uneditableBgFiller:DisplayObject;
		public function fillUneditableBg(filler:DisplayObject):void
		{
			if(_uneditableBgFiller && _uneditableBgFiller.parent) { _uneditableBgFiller.parent.removeChild(_uneditableBgFiller); }
			_uneditableBgFiller = filler;
			invalidate();
		}
		
		public function JText(text:String = "")
		{
			super(text);
			this._type = JuiType.JText;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			_panel = new JPanel();
			addChild(_panel);
			
			_tf = new TextField();
			_tf.x = 2;
			_tf.y = 2;
			_tf.height = _height;
			_tf.embedFonts = false;
			_tf.multiline = true;
			_tf.wordWrap = _autoWrap;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_format.relateTf = _tf;
			_tf.defaultTextFormat = _format;
			_tf.addEventListener(Event.CHANGE, onChange);			
			addChild(_tf);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, __mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, __mouseOut);
			
			setSize(200, 100);
		}
		
		protected function __mouseOver(e:MouseEvent):void
		{
			_over = true;
			invalidate();
		}
		
		protected function __mouseOut(e:MouseEvent):void
		{
			_over = false;
			invalidate();
		}
		
		override public function draw():void
		{
			super.draw();
			
			_panel.setSize(_width, _height);
			if(_editable)
			{
				if(_over)
				{
					_panel.fillBackground(_overBgFiller);
				}
				else
				{
					_panel.fillBackground(_defaultBgFiller);
				}
			}
			else
			{
				_panel.fillBackground(_uneditableBgFiller);
			}
			
			////////////////////////////////
			
			_tf.width = _width - 4;
			_tf.height = _height - 4;
			_tf.wordWrap = _autoWrap;
			if(_useHtml)
			{
				_tf.htmlText = _text;
			}
			else
			{
				_tf.defaultTextFormat = _format;
				_tf.text = _text;
			}
			if(_editable)
			{
				_tf.mouseEnabled = true;
				_tf.selectable = true;
				_tf.type = TextFieldType.INPUT;
			}
			else
			{
				_tf.mouseEnabled = _selectable;
				_tf.selectable = _selectable;
				_tf.type = TextFieldType.DYNAMIC;
			}
			_tf.setTextFormat(textFormat);
			
			drawStroke();
		}
		
		/**
		 * Called when the text in the text field is manually changed.
		 */
		protected function onChange(event:Event):void
		{
			_text = _tf.text;
			dispatchEvent(event);
		}
		
		
		/**
		 * Gets / sets whether or not this text component will be editable.
		 */
		public function set editable(b:Boolean):void
		{
			_editable = b;
			invalidate();
		}
		public function get editable():Boolean
		{
			return _editable;
		}
		
		/**
		 * Gets / sets whether or not this text component will be selectable. Only meaningful if editable is false.
		 */
		public function set selectable(b:Boolean):void
		{
			_selectable = b;
			invalidate();
		}
		public function get selectable():Boolean
		{
			return _selectable;
		}
		
	}
}