package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.define.JuiConst;
	
	import flash.display.Shape;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	public class JBaseText extends JComponent
	{
		/** 默认区域width */
		public static const DEFAULT_WIDTH:int = 120;
		/** 默认区域height */
		public static const DEFAULT_HEIGHT:int = 30;
		
		protected var _tf:TextField;
		public function get textField():TextField { return _tf; }
		
		public function JBaseText(text:String = "")
		{
			super();
			this.text = text;
		}
		
		//=====Set/Get==Beg========================================
		
		public override function set enabled(value:Boolean):void
		{
			super.enabled = value;
			_tf.tabEnabled = value;
		}
		
		protected var _text:String = "";
		/** 文本内容 */
		public function set text(t:String):void
		{
			_text = t;
			if(_text == null) _text = "";
			invalidate();
		}
		public function get text():String { return _text; }
		
		protected var _format:JTextFormat = new JTextFormat();
		/** textField的文本样式 */
		public function set textFormat(f:JTextFormat):void
		{
			_format = f;
			_format.relateTf = _tf;
			_tf.defaultTextFormat = _format;
			invalidate();
		}
		public function get textFormat():JTextFormat { return _format; }
		
		protected var _align:String = JuiConst.LEFT;
		/** 水平对齐方式
		 * 默认JuiConst.LEFT，接受三种值LEFT CENTER RIGHT */
		public function set align(a:String):void
		{
			if(_align != a)
			{
				_align = a;
				invalidate();
			}
		}
		public function get align():String { return _align; }
		
		protected var _valign:String = JuiConst.MIDDLE;
		/** 垂直对齐方式
		 * 默认JuiConst.MIDDLE，接受三种值UP MIDDLE DOWN */
		public function set valign(a:String):void
		{
			if(_valign != a)
			{
				_valign = a;
				invalidate();
			}
		}
		public function get valign():String { return _valign; }
		
		protected var _autoWrap:Boolean = false;
		/** 自动换行 */
		public function set autoWrap(b:Boolean):void
		{
			if(_autoWrap != b)
			{
				_autoWrap = b;
				invalidate();
			}
		}
		public function get autoWrap():Boolean { return _autoWrap; }
		
		/** 输入限制 */
		public function set restrict(str:String):void
		{
			_tf.restrict = str;
		}
		public function get restrict():String
		{
			return _tf.restrict;
		}
		
		/** 最大字数 */
		public function set maxChars(max:int):void
		{
			_tf.maxChars = max;
		}
		public function get maxChars():int
		{
			return _tf.maxChars;
		}
		
		/** 作为密码样式显示 */
		public function set password(b:Boolean):void
		{
			_tf.displayAsPassword = b;
		}
		public function get password():Boolean
		{
			return _tf.displayAsPassword;
		}
		
		protected var _useStroke:Boolean = false;
		/** 是否使用描边 */
		public function set useStroke(b:Boolean):void
		{
			if(_useStroke != b)
			{
				_useStroke = b;
				invalidate();
			}
		}
		public function get useStroke():Boolean { return _useStroke; }
		
		protected var _strokeColor:int = 0x0e0600;
		/** 描边颜色 */
		public function set strokeColor(c:int):void
		{
			_strokeColor = c;
			invalidate();
		}
		public function get strokeColor():int { return _strokeColor; }
		
		protected var _strokeBlur:int = 4;
		/** 描边扩散 */
		public function set strokeBlur(b:int):void
		{
			_strokeBlur = b;
			invalidate();
		}
		public function get strokeBlur():int { return _strokeBlur; }
		
		protected var _strokeStrength:int = 4;
		/** 描边强度 */
		public function set strokeStrength(s:int):void
		{
			_strokeStrength = s;
			invalidate();
		}
		public function get strokeStrength():int { return _strokeStrength; }
		
		protected var _useHtml:Boolean = false;
		/** 是否使用Html */
		public function set useHtml(b:Boolean):void
		{
			if(_useHtml != b)
			{
				_useHtml = b;
				invalidate();
			}
		}
		public function get useHtml():Boolean { return _useHtml; }
		
		//=====Set/Get==End========================================
		
		override protected function addChildren():void
		{
			super.addChildren();
		}
		
		/** 绘制描边 */
		protected function drawStroke():void
		{
			if(_useStroke)
			{
				_tf.filters = [new GlowFilter(_strokeColor, 1, _strokeBlur, _strokeBlur, _strokeStrength)];
			}
			else
			{
				_tf.filters = [];
			}
		}
		
	}
}