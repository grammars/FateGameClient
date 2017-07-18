package ui.ctrls
{
	import ui.ctrls.Framework.CtrlCenter;
	
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class Title extends Ape
	{
		/** textField */
		public var textField:TextField = new TextField();
		
		/** shape */
		public var shape:Shape = new Shape();
		
		/** filterTf */
		public var filterTf:TextField = new TextField();
		
		/** textField的文本样式 */
		public var textFormat:TextFormat = new TextFormat();
		
		//------------------------------------------------------------------------
		
		protected var _uiLabel:String = "";
		
		public function set uiLabel(value:String):void
		{
			_uiLabel = value;
			if (textField.text != value)
			{
				textField.text = value;
				fresh();
			}
		}
		public function get uiLabel():String
		{
			_uiLabel = textField.text;
			return _uiLabel;
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtFont:String = "STKaiti";
		
		public function set uiTxtFont(value:String):void
		{
			_uiTxtFont = value;
			textFormat.font = _uiTxtFont;
			fresh();
		}
		public function get uiTxtFont():String
		{
			_uiTxtFont = textFormat.font;
			return _uiTxtFont;
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtSize:int = 12;
		
		public function set uiTxtSize(value:String):void
		{
			_uiTxtSize = parseInt(value);
			textFormat.size	 = _uiTxtSize;
			fresh();
		}
		public function get uiTxtSize():String
		{
			return _uiTxtSize.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtBold:Boolean = false;
		
		public function set uiTxtBold(value:String):void
		{
			if(value == "true")
			{
				_uiTxtBold = true;
			}
			else if(value == "false")
			{
				_uiTxtBold = false;
			}
			textFormat.bold = _uiTxtBold;
			fresh();
		}
		public function get uiTxtBold():String
		{
			return _uiTxtBold.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtItalic:Boolean = false;
		
		public function set uiTxtItalic(value:String):void
		{
			if(value == "true")
			{
				_uiTxtItalic = true;
			}
			else if(value == "false")
			{
				_uiTxtItalic = false;
			}
			textFormat.italic = _uiTxtItalic;
			fresh();
		}
		public function get uiTxtItalic():String
		{
			return _uiTxtItalic.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtUnderline:Boolean = false;
		
		public function set uiTxtUnderline(value:String):void
		{
			if(value == "true")
			{
				_uiTxtUnderline = true;
			}
			else if(value == "false")
			{
				_uiTxtUnderline = false;
			}
			textFormat.underline = _uiTxtUnderline;
			fresh();
		}
		public function get uiTxtUnderline():String
		{
			return _uiTxtUnderline.toString();
		}
		
		//------------------------------------------------------------------------		
		
		protected var _uiGradBeg:int = 0xffffff;
		
		public function set uiGradBeg(value:String):void{
			_uiGradBeg = parseInt(value,16);
			fresh();
		}
		public function get uiGradBeg():String{
			return _uiGradBeg.toString(16);
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiGradEnd:int = 0x5db492;
		
		public function set uiGradEnd(value:String):void{
			_uiGradEnd = parseInt(value,16);
			fresh();
		}
		public function get uiGradEnd():String{
			return _uiGradEnd.toString(16);
		}
		
		//------------------------------------------------------------------------

		
		public function Title(width:Number = 40, height:Number = 23)
		{
			super(width, height);
			initTitle();
		}
		
		
		protected function initTitle():void
		{
			textField.width = uiWidth;
			textField.selectable = false;
			textField.type = TextFieldType.DYNAMIC;
			textField.defaultTextFormat = textFormat;
			textField.text = "标签";
			textField.mouseEnabled = false;
			textField.mouseWheelEnabled = false;
			filterTf.mouseEnabled = false;
			filterTf.mouseWheelEnabled = false;
			this.uiSubType = UIInfo.TITLE;
			this.addChild(filterTf);
			this.addChild(textField);
			this.addChild(shape);
		}
		
		
		/** 强制重绘 */
		override public function forceFresh():void
		{
			bgSprite.graphics.clear();
			preRender();
			render();
		}
		
		
		override protected function fresh():void
		{
			bgSprite.graphics.clear();
			preRender();
			if(CtrlCenter.needShowApeFrame)
			{
				bgSprite.graphics.lineStyle(1, 0xFF0000FF);
			}
			//bgSprite.graphics.beginFill(0xfffff0, 0.2);
			bgSprite.graphics.drawRect(0, 0, uiWidth, uiHeight);
			bgSprite.graphics.endFill();
		}
		
		
		override protected function preRender():void
		{
			//设置textField样式
			textFormat.font = uiTxtFont;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.setTextFormat(textFormat);
			//设置textField宽度高度
			textField.width = textField.textWidth + 10;
			textField.height = textField.textHeight + 10;
			//
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox(textField.textWidth+10, textField.textHeight+10, Math.PI / 2, 0, 0);
			shape.graphics.clear();
			shape.graphics.beginGradientFill(GradientType.LINEAR,[_uiGradBeg, _uiGradEnd],[1.0,1.0],[0,255], mtx);
			shape.graphics.drawRect(0, 0, textField.textWidth+10, textField.textHeight+10);
			shape.graphics.endFill();
			//
			textField.cacheAsBitmap = true;
			shape.cacheAsBitmap = true;
			shape.mask = textField;
			//
			filterTf.text = uiLabel;
			filterTf.width = textField.width;
			filterTf.height = textField.height;
			filterTf.setTextFormat(textFormat);
			filterTf.filters =  [new GlowFilter(0x222222, 1.0, 5, 5, 3, 2, false, true)];
		}
		
	}
}