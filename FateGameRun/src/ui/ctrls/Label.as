package ui.ctrls{
	
	import ui.ctrls.Framework.CtrlCenter;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.formats.TextAlign;

	public class Label extends Ape{
		
		/** 用于画到textBmp上的文本，本身并不显示 */
		public var textField:TextField = new TextField();
		
		/** textField的文本样式 */
		public var textFormat:TextFormat = new TextFormat();
		
		//------------------------------------------------------------------------
		
		protected var _uiLabel:String = "壮哉我大孙凯";
		
		public function set uiLabel(value:String):void{
			_uiLabel = value;
			if (textField.text != value){
				textField.width = uiWidth;//改变标签文本内容时，将文本框的宽度和uiWidth同步一下
				var str:String = "";
				if(_useHtml == true)
				{
					textField.htmlText = str;
				}
				else
				{
					str = value.split("\\r").join("\r");
					textField.text = str;
				}
				fresh();
			}
		}
		public function get uiLabel():String{
			//_uiLabel = textField.text;
			return _uiLabel;
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtSize:int = 13;
		
		public function set uiTxtSize(value:String):void{
			_uiTxtSize = parseInt(value);
			textFormat.size	 = _uiTxtSize;
			fresh();
		}
		public function get uiTxtSize():String{
			return _uiTxtSize.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtColor:int = 0xf2eacb;
		
		public function set uiTxtColor(value:String):void{
			_uiTxtColor = parseInt(value,16);
			textFormat.color = _uiTxtColor;
			fresh();
		}
		public function get uiTxtColor():String{
			return _uiTxtColor.toString(16);
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtBold:Boolean = true;
		
		public function set uiTxtBold(value:String):void{
			if(value == "true"){
				_uiTxtBold = true;
			}else if(value == "false"){
				_uiTxtBold = false;
			}
			textFormat.bold = _uiTxtBold;
			fresh();
		}
		public function get uiTxtBold():String{
			return _uiTxtBold.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtItalic:Boolean = false;
		
		public function set uiTxtItalic(value:String):void{
			if(value == "true"){
				_uiTxtItalic = true;
			}else if(value == "false"){
				_uiTxtItalic = false;
			}
			textFormat.italic = _uiTxtItalic;
			fresh();
		}
		public function get uiTxtItalic():String{
			return _uiTxtItalic.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiTxtUnderline:Boolean = false;
		
		public function set uiTxtUnderline(value:String):void{
			if(value == "true"){
				_uiTxtUnderline = true;
			}else if(value == "false"){
				_uiTxtUnderline = false;
			}
			textFormat.underline = _uiTxtUnderline;
			fresh();
		}
		public function get uiTxtUnderline():String{
			return _uiTxtUnderline.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiAlign:String = LayoutStyle.CENTER;
		
		public function set uiAlign(value:String):void{
			_uiAlign = value;
			switch(_uiAlign){
				case LayoutStyle.CENTER:
					textFormat.align = TextAlign.CENTER;
					break;
				case LayoutStyle.LEFT:
					textFormat.align = TextAlign.LEFT;
					break;
				case LayoutStyle.RIGHT:
					textFormat.align = TextAlign.RIGHT;
					break;
			}
			fresh();
		}
		public function get uiAlign():String{
			return _uiAlign;
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiWordWrap:Boolean = true;
		
		public function set uiWordWrap(value:String):void{
			if(value == "true"){
				_uiWordWrap = true;
			}else if(value == "false"){
				_uiWordWrap = false;
			}
			textField.wordWrap = _uiWordWrap;
			fresh();
		}
		public function get uiWordWrap():String{
			return _uiWordWrap.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _useHtml:Boolean = false;
		
		public function set useHtml(value:String):void{
			if(value == "true"){
				_useHtml = true;
			}else if(value == "false"){
				_useHtml = false;
			}
			fresh();
		}
		public function get useHtml():String{
			return _useHtml.toString();
		}
		
		//------------------------------------------------------------------------
		
		public function Label(width:Number = 40, height:Number = 23){
			super(width, height);
			initLabel();
		}
		
		
		protected function initLabel():void{
			textField.width = uiWidth;
			textField.selectable = false;
			textField.multiline = true;
			textField.type = TextFieldType.DYNAMIC;
			var dfmt:TextFormat = new TextFormat();
			dfmt.font = CtrlCenter.defaultFont;
			textField.defaultTextFormat = dfmt;
			textField.text = "标签";
			textField.mouseEnabled = false;
			textField.mouseWheelEnabled = false;
			textField.y = CtrlCenter.txtOffsetYForFont;
			this.uiSubType = UIInfo.LABEL;
			this.addChild(textField);
		}
		
		
		/** 强制重绘 */
		override public function forceFresh():void{
			bgSprite.graphics.clear();
			preRender();
			render();
		}
		
		
		override protected function fresh():void{
			bgSprite.graphics.clear();
			
			drawRectHandler();
			
			preRender();
			if(CtrlCenter.needShowApeFrame){
				bgSprite.graphics.lineStyle(1, 0xFF0000FF);
			}
			//bgSprite.graphics.beginFill(0xfffff0, 0.2);
			bgSprite.graphics.drawRect(0, 0, uiWidth, uiHeight);
			bgSprite.graphics.endFill();
		}
		
		
		override protected function preRender():void{
			//设置textField样式
			textField.setTextFormat(textFormat);
			textField.defaultTextFormat = textFormat;
			if(_useHtml)
			{
				textField.htmlText = uiLabel;
			}
			//设置textField宽度高度
			textField.width = uiWidth;
			textField.height = textField.textHeight + 4;
		}
		
		
	}
}