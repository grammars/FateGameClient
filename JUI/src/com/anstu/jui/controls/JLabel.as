package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	[Event(name="resize", type="flash.events.Event")]
	public class JLabel extends JBaseText
	{
		public function JLabel(text:String = "")
		{
			super();
			this._type = JuiType.JLabel;
			this.text = text;
		}
		
		//=====Set/Get==Beg========================================
		
		protected var _usePack:Boolean = false;
		/** 是否使用包裹 */
		public function set usePack(b:Boolean):void
		{
			if(_usePack != b)
			{
				_usePack = b;
				invalidate();
			}
		}
		public function get usePack():Boolean { return _usePack; }
		
		//=====Set/Get==End========================================
		
		override protected function addChildren():void
		{
			mouseEnabled = false;
			mouseChildren = false;
			_width = DEFAULT_WIDTH;
			_height = DEFAULT_HEIGHT;
			super.addChildren();
			
			_tf = new TextField();
			//_tf.border = true;
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.multiline = true;
			addChild(_tf);
			_format.relateTf = _tf;
			_tf.defaultTextFormat = _format;
			
			draw();
		}
		
		override public function draw():void
		{
			super.draw();
			
			var indent:int = 0;
			if(textFormat.indent)
			{
				indent = int(textFormat.indent);
			}
			_tf.width = Math.max(_width-indent, 1);
			_tf.height = _height;
			
			_tf.wordWrap = _autoWrap;
			
			if(_useHtml)
			{
				_tf.htmlText = _text;
			}
			else
			{
				_tf.text = _text;
			}
			
			_tf.width = _tf.textWidth+indent+8;
			_tf.height = _tf.textHeight+4;
			
			if(_usePack)
			{
				_width = _tf.width;
				_height = _tf.height;
				drawFrame();
			}
			switch(_align)
			{
				case JuiConst.LEFT:
					_tf.x = 0;
					break;
				case JuiConst.CENTER:
					_tf.x = (_width - _tf.width+4)/2;
					break;
				case JuiConst.RIGHT:
					_tf.x = (_width - _tf.width+4);
					break;
				default:
					_tf.x = 0;
					break;
			}
			switch(_valign)
			{
				case JuiConst.UP:
					_tf.y = 0;
					break;
				case JuiConst.DOWN:
					_tf.y = _height - (_tf.height);
					break;
				case JuiConst.MIDDLE:
				default:
					_tf.y = ( _height - (_tf.height) ) / 2;
					break;
			}
			drawStroke();
		}
		
		/** 内容高度 */
		public function contentHeight():Number
		{
			return _tf.height;
		}
		
	}
}