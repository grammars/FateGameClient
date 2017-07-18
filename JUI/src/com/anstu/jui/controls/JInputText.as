package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	public class JInputText extends JBaseText
	{
		
		public function JInputText(text:String = "")
		{
			super();
			this._type = JuiType.JInputText;
			this.text = text;
		}
		
		//=====Set/Get==Beg========================================
		
		
		
		//=====Set/Get==End========================================
		
		override protected function init():void
		{
			super.init();
			setSize(100, 16);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			_tf = new TextField();
			//_tf.embedFonts = false;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_format.relateTf = _tf;
			_tf.defaultTextFormat = _format;
			addChild(_tf);
			_tf.addEventListener(Event.CHANGE, onChange);
		}
		
		protected function onChange(event:Event):void
		{
			_text = _tf.text;
			event.stopImmediatePropagation();
			dispatchEvent(event);
		}
		
		override public function draw():void
		{
			super.draw();
			
			switch(align)
			{
				case JuiConst.LEFT:
					_format.align = TextAlign.LEFT;
					break;
				case JuiConst.CENTER:
					_format.align = TextAlign.CENTER;
					break;
				case JuiConst.RIGHT:
					_format.align = TextAlign.RIGHT;
					break;
			}
			_tf.setTextFormat(_format);
			
			if(_text != null)
			{
				_tf.text = _text;
			}
			else 
			{
				_tf.text = "";
			}
			_tf.width = _width - 4;
			if(_tf.text == "")
			{
				_tf.text = "X";
				_tf.height = Math.min(_tf.textHeight + 4, _height);
				_tf.text = "";
			}
			else
			{
				_tf.height = Math.min(_tf.textHeight + 4, _height);
			}
			_tf.x = 2;
			_tf.y = Math.round(_height / 2 - _tf.height / 2);
			
			drawStroke();
		}
		
	}
}