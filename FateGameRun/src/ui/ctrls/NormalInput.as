package ui.ctrls{
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class NormalInput extends Ape{
		
		public var input:TextField = new TextField();
		
		public var textFormat:TextFormat = new TextFormat();
		
		public function set content(value:String):void
		{
			input.text = value;
		}
		public function get content():String
		{
			return input.text;
		}
		
		//------------------------------------------------------------------------
		
		private var _asPassword:Boolean = false;
		
		public function set asPassword(value:String):void{
			if(value == "true"){
				this._asPassword = true;
			}else if(value == "false"){
				this._asPassword = false;
			}
		}
		
		public function get asPassword():String{
			return this._asPassword.toString();
		}
		
		//------------------------------------------------------------------------
		
		private var _uiTxtSize:uint = 12;
		
		public function set uiTxtSize(value:String):void{
			if(_uiTxtSize != parseInt(value)){
				_uiTxtSize = parseInt(value);
				fresh();
			}
		}
		public function get uiTxtSize():String{
			return _uiTxtSize.toString();
		}
		
		//------------------------------------------------------------------------
		
		private var _uiTxtColor:uint = 0x000000;
		
		public function set uiTxtColor(value:String):void{
			if(_uiTxtColor != parseInt(value,16)){
				_uiTxtColor = parseInt(value,16);
				fresh();
			}
		}
		public function get uiTxtColor():String{
			return _uiTxtColor.toString(16);
		}
		
		//------------------------------------------------------------------------
		
		private var _uiTxtBold:Boolean = false;
		
		public function set uiTxtBold(value:String):void{
			if(value == "true"){
				_uiTxtBold = true;
			}else if(value == "false"){
				_uiTxtBold = false;
			}
			fresh();
		}
		public function get uiTxtBold():String{
			return _uiTxtBold.toString();
		}
		
		//------------------------------------------------------------------------
		
		private var _uiTxtItalic:Boolean = false;
		
		public function set uiTxtItalic(value:String):void{
			if(value == "true"){
				_uiTxtItalic = true;
			}else if(value == "false"){
				_uiTxtItalic = false;
			}
			fresh();
		}
		public function get uiTxtItalic():String{
			return _uiTxtItalic.toString();
		}
		
		//------------------------------------------------------------------------
		
		private var _uiTxtUnderline:Boolean = false;
		
		public function set uiTxtUnderline(value:String):void{
			if(value == "true"){
				_uiTxtUnderline = true;
			}else if(value == "false"){
				_uiTxtUnderline = false;
			}
			fresh();
		}
		public function get uiTxtUnderline():String{
			return _uiTxtUnderline.toString();
		}
		
		//------------------------------------------------------------------------
		
		protected var _uiAlign:String = LayoutStyle.CENTER;
		
		public function set uiAlign(value:String):void{
			_uiAlign = value;
			fresh();
		}
		public function get uiAlign():String{
			return _uiAlign;
		}
		
		//------------------------------------------------------------------------
		
		public function NormalInput(width:Number=120, height:Number=23){
			super(width, height);
			init();
		}
		
		private function init():void{
			input.type = TextFieldType.INPUT;
			input.border = false;
			input.displayAsPassword = false;
			var dfmt:TextFormat = new TextFormat();
			dfmt.font = "宋体";
			input.defaultTextFormat = dfmt;
			this.uiAlpha = 0;
			this.input.text = "输入框";
			this.uiSubType = UIInfo.NORMALINPUT;
			this.addChild(input);
		}
		
		
		override protected function preRender():void{
			input.width = this.uiWidth;
			input.height = this.uiHeight;
			input.displayAsPassword = _asPassword;
			//设置文字样式
			textFormat.color = _uiTxtColor;
			textFormat.size	 = _uiTxtSize;
			textFormat.bold = _uiTxtBold;
			textFormat.italic = _uiTxtItalic;
			textFormat.underline = _uiTxtUnderline;
			//由uiAlign决定是否居中
			switch(uiAlign){
				case LayoutStyle.CENTER:
					textFormat.align = TextFormatAlign.CENTER;
					break;
				case LayoutStyle.LEFT:
					textFormat.align = TextFormatAlign.LEFT;
					break;
				case LayoutStyle.RIGHT:
					textFormat.align = TextFormatAlign.RIGHT;
					break;
			}
			input.setTextFormat(textFormat);
			input.defaultTextFormat = textFormat;
		}
		
	}
}