package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class JTitle extends JComponent
	{
		/** 默认区域width */
		public static const DEFAULT_WIDTH:int = 120;
		/** 默认区域height */
		public static const DEFAULT_HEIGHT:int = 30;
		
		/** textField */
		private var textField:TextField = new TextField();
		
		/** shape */
		private var shape:Sprite = new Sprite();
		
		/** filterTf */
		private var filterTf:TextField = new TextField();
		
		protected var _format:JTextFormat = new JTextFormat();
		/** textField的文本样式 */
		public function set textFormat(f:JTextFormat):void
		{
			_format = f;
			invalidate();
		}
		public function get textFormat():JTextFormat { return _format; }
		
		
		protected var _text:String = "";
		/** 标题文字 */
		public function set text(value:String):void
		{
			_text = value;
			if(_text == null) _text = "";
			_needRecreate = true;
			invalidate();
		}
		public function get text():String { return _text; }
		
		/** 需要被重建TextField，为解决TextField autoSize和width产生的冲突bug而生 */
		private var _needRecreate:Boolean = true;
		
		protected var _align:String = JuiConst.LEFT;
		/** 水平对齐方式
		 * 默认JuiConst.LEFT，接受三种值LEFT CENTER RIGHT */
		public function set align(a:String):void
		{
			if(_align != a)
			{
				_align = a;
				_needRecreate = true;
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
				_needRecreate = true;
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
		
		override public function set width(w:Number):void
		{
			_needRecreate = true;
			super.width = w;
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			_needRecreate = true;
			super.setSize(w, h);
		}
		
		protected var _gradBeg:int = 0xffffff;
		/** 渐变起始色 */
		public function set gradBeg(c:int):void
		{
			_gradBeg = c;
			_needRecreate = true;
			invalidate();
		}
		public function get gradBeg():int { return _gradBeg; }
		
		protected var _gradEnd:int = 0x5db492;
		/** 渐变结束色 */
		public function set gradEnd(c:int):void
		{
			_gradEnd = c;
			_needRecreate = true;
			invalidate();
		}
		public function get gradEnd():int { return _gradEnd; }
		
		
		public function JTitle(text:String="")
		{
			super();
			this._type = JuiType.JTitle;
			this.text = text;
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			mouseChildren = false;
			_width = DEFAULT_WIDTH;
			_height = DEFAULT_HEIGHT;
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			draw();
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			if(_needRecreate)
			{
				if(textField && textField.parent) { textField.parent.removeChild(textField); }
				textField = new TextField();
				textField.type = TextFieldType.DYNAMIC;
				textField.width = _width;
				textField.height = _height;
				
				if(filterTf && filterTf.parent) { filterTf.parent.removeChild(filterTf); }
				filterTf = new TextField();
				filterTf.type = TextFieldType.DYNAMIC;
				filterTf.width = _width;
				filterTf.height = _height;
				
				switch(_align)
				{
					case JuiConst.LEFT:
						textField.autoSize = TextFieldAutoSize.LEFT;
						filterTf.autoSize = TextFieldAutoSize.LEFT;
						break;
					case JuiConst.CENTER:
						textField.autoSize = TextFieldAutoSize.CENTER;
						filterTf.autoSize = TextFieldAutoSize.CENTER;
						break;
					case JuiConst.RIGHT:
						textField.autoSize = TextFieldAutoSize.RIGHT;
						filterTf.autoSize = TextFieldAutoSize.RIGHT;
						break;
					default:
						textField.autoSize = TextFieldAutoSize.NONE;
						filterTf.autoSize = TextFieldAutoSize.NONE;
						break;
				}
				
				textField.selectable = false;
				textField.mouseEnabled = false;
				textField.multiline = true;
				textField.cacheAsBitmap = true;
				
				filterTf.selectable = false;
				filterTf.mouseEnabled = false;
				filterTf.multiline = true;
				filterTf.cacheAsBitmap = true;
				
				textField.text = _text;
				textField.setTextFormat(_format);
				
				filterTf.text = _text;
				filterTf.setTextFormat(_format);
				
				var mtx:Matrix = new Matrix();
				mtx.createGradientBox(textField.textWidth, textField.textHeight, Math.PI / 2, 0, 0);
				shape.graphics.clear();
				shape.graphics.beginGradientFill(GradientType.LINEAR,[_gradBeg, _gradEnd],[1.0,1.0],[0,255], mtx);
				shape.graphics.drawRect(0, 0, _width, _height);
				shape.graphics.endFill();
				shape.cacheAsBitmap = true;
				shape.mask = textField;
				
				this.addChild(filterTf);
				shape.addChild(textField);
				this.addChild(shape);
			}
			_needRecreate = false;
			
			textField.wordWrap = _autoWrap;
			textField.defaultTextFormat = _format;
			textField.setTextFormat(_format);
			
			filterTf.wordWrap = _autoWrap;
			filterTf.defaultTextFormat = _format;
			filterTf.setTextFormat(_format);
			
			if(_usePack)
			{
				_width = textField.width = textField.textWidth + 4;
				_height = textField.height = textField.textHeight;
			}
			
			switch(_valign)
			{
				case JuiConst.UP:
					shape.y = 0;
					filterTf.y = 0;
					break;
				case JuiConst.DOWN:
					shape.y = _height - (textField.textHeight+4);
					filterTf.y = _height - (textField.textHeight+4);
					break;
				case JuiConst.MIDDLE:
				default:
					shape.y = ( _height - (textField.textHeight+4) ) / 2;
					filterTf.y = ( _height - (textField.textHeight+4) ) / 2;
					break;
			}
			//
			drawStroke();
			//
			drawRect(_bgColor, _bgAlpha, _lineColor, _lineAlpha);
		}
		
		private var _bgColor:uint=0xffffff;
		private var _bgAlpha:Number=0;
		private var _lineColor:uint=0x2b2b2b;
		private var _lineAlpha:Number=0;
		/** drawRect */
		public function drawRect(bgColor:uint=0xffffff, bgAlpha:Number=1, lineColor:uint=0x2b2b2b, lineAlpha:Number=1):void
		{
			_bgColor = bgColor;
			_bgAlpha = bgAlpha;
			_lineColor = lineColor;
			_lineAlpha = lineAlpha;
			this.graphics.clear();
			this.graphics.lineStyle(1, lineColor, lineAlpha);
			this.graphics.beginFill(bgColor, bgAlpha);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
		}
		
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
		
		protected var _strokeColor:uint = 0x222222;
		/** 描边颜色 */
		public function set strokeColor(value:uint):void
		{
			_strokeColor = value;
			invalidate();
		}
		public function get strokeColor():uint { return _strokeColor; }
		
		protected var _strokeAlpha:Number = 1.0;
		/** 描边alpha */
		public function set strokeAlpha(value:Number):void
		{
			_strokeAlpha = value;
			invalidate();
		}
		public function get strokeAlpha():Number { return _strokeAlpha; }
		
		protected var _strokeBlur:Number = 4.0;
		/** 描边blur */
		public function set strokeBlur(value:Number):void
		{
			_strokeBlur = value;
			invalidate();
		}
		public function get strokeBlur():Number { return _strokeBlur; }
		
		protected var _strokeStrength:Number = 2;
		/** 描边strength */
		public function set strokeStrength(value:Number):void
		{
			_strokeStrength = value;
			invalidate();
		}
		public function get strokeStrength():Number { return _strokeStrength; }
		
		/** 绘制描边 */
		protected function drawStroke():void
		{
			if(_useStroke)
			{
				filterTf.filters = [new GlowFilter(_strokeColor, _strokeAlpha, _strokeBlur, _strokeBlur, _strokeStrength, 2, false, true)];
			}
			else
			{
				filterTf.filters = [];
			}
		}
		
	}
}