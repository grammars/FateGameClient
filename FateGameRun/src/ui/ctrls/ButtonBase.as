package ui.ctrls{
	
	import ui.ctrls.Framework.CtrlCenter;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	
	public class ButtonBase extends StrokeLabel{ 	
		public static const MOUSE_OVER:String 	= "state_button_mouse_over";
		public static const MOUSE_DOWN:String 	= "state_button_mouse_down";
		public static const NORMAL:String 		= "state_button_normal";
		public static const DISABLED:String 	= "state_button_disabled";
		
		protected var _state:String = NORMAL;
		
		protected var _overTxtColor:uint = 0xfffacb;
		protected var _downTxtColor:uint = 0xf2fac0;
		
		protected var _stateOverBmd:BitmapData;
		protected var _stateDownBmd:BitmapData;
		protected var _stateDisabledBmd:BitmapData;
		
		protected var _stateOverSrc:String		= "";
		protected var _stateDownSrc:String		= "";
		protected var _stateDisabledSrc:String 	= "";
		
		public function ButtonBase(width:Number = 75, height:Number = 23){
			super(width, height);
			this.uiLabel = "按钮";
			this.mouseEnabled 	= true;
			//this.mouseChildren 	= false;
			this.buttonMode 	= true;
			this.uiWordWrap = "false";
			this.uiType			= UIInfo.TYPE_CONTROL;
			
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			initButton();
		}
		
		protected function initButton():void{
			this.uiSubType		= UIInfo.BUTTON;
		}
		
		//------------------------------------------------------------------
		public function set state(value:String):void{
			if(value != this._state){
				this._state = value;
				fresh();
			}
		}
		
		public function get state():String{
			return this._state;
		}
		
		//------------------------------------------------------------------------
		
		public function set overTxtColor(value:String):void{
			this._overTxtColor = parseInt(value, 16);
			fresh();
		}
		
		public function get overTxtColor():String{
			return this._overTxtColor.toString(16);
		}
		
		//------------------------------------------------------------------------
		
		public function set downTxtColor(value:String):void{
			this._downTxtColor = parseInt(value, 16);
			fresh();
		}
		
		public function get downTxtColor():String{
			return this._downTxtColor.toString(16);
		}
		
		//------------------------------------------------------------------------
		
		public function set stateOverBmd(value:BitmapData):void{
			this._stateOverBmd = value;
			fresh();
		}
		
		public function get stateOverBmd():BitmapData{
			return this._stateOverBmd;
		}
		
		//------------------------------------------------------------------------
		
		public function set stateDownBmd(value:BitmapData):void{
			this._stateDownBmd = value;
			fresh();
		}
		
		public function get stateDownBmd():BitmapData{
			return this._stateDownBmd;
		}
		
		//------------------------------------------------------------------------
		
		public function set stateDisabledBmd(value:BitmapData):void{
			this._stateDisabledBmd = value;
			fresh();
		}
		
		public function get stateDisabledBmd():BitmapData{
			return this._stateDisabledBmd;
		}
		
		//------------------------------------------------------------------------
		
		public function set stateOverSrc(path:String):void{
			if (path != null && path != this._stateOverSrc){
				this._stateOverSrc = path;
				this.setStateSrc(path, ButtonBase.MOUSE_OVER);
				fresh();
			}
		}
		
		public function get stateOverSrc():String{
			return this._stateOverSrc;	
		}
		
		//------------------------------------------------------------------------
		
		public function set stateDownSrc(path:String):void{
			if (path != null && path != this._stateDownSrc){
				this._stateDownSrc = path;
				this.setStateSrc(path, ButtonBase.MOUSE_DOWN);
				fresh();
			}
		}
		
		public function get stateDownSrc():String{
			return this._stateDownSrc;
		}
		
		//------------------------------------------------------------------------
		
		public function set stateDisabledSrc(path:String):void{
			if (path != null && path != this._stateDisabledSrc){
				this._stateDisabledSrc = path;
				this.setStateSrc(path, ButtonBase.DISABLED);
				fresh();
			}
		}
		
		public function get stateDisabledSrc():String{
			return this._stateDisabledSrc
		}
		
		//------------------------------------------------------------------------
		
		private var _txtOffsetV:int = 0;
		public function get txtOffsetV():String { return _txtOffsetV.toString(); }
		public function set txtOffsetV(value:String):void
		{
			_txtOffsetV = parseInt(value);
		}
		
		//------------------------------------------------------------------------
		
		protected function onMouseUp(event:MouseEvent):void{
			this.state = ButtonBase.MOUSE_OVER;
		}
		
		protected function onMouseOut(event:MouseEvent):void{
			this.state = ButtonBase.NORMAL;
		}
		
		protected function onMouseOver(event:MouseEvent):void{
			this.state = ButtonBase.MOUSE_OVER;
		}
		
		protected function onMouseDown(event:MouseEvent):void{
			this.state = ButtonBase.MOUSE_DOWN;
		}
		
		//------------------------------------------------------------------------
		
		override public function set buttonMode(value:Boolean):void{
			super.buttonMode = value;
			if (value == true){
				this.state = ButtonBase.NORMAL;
			}else{
				this.state = ButtonBase.DISABLED;
			}
			fresh();
		}
		
		//------------------------------------------------------------------------
		
		override protected function fresh():void{
			bgSprite.graphics.clear();
			
			preRender();
			render();
			
			drawRectHandler();
		}
		
		
		override protected function preRender():void{
			textField.autoSize = TextFieldAutoSize.CENTER;
			switch (_state){
				case MOUSE_OVER:
					textFormat.color = this._overTxtColor;
					break;
				case MOUSE_DOWN:
					textFormat.color = this._downTxtColor;
					break;
				case DISABLED:
					textFormat.color = parseInt(uiTxtColor,16);
					break;
				case NORMAL:
					textFormat.color = parseInt(uiTxtColor,16);
					break;
			}
			textField.setTextFormat(textFormat);
			textField.x = (uiWidth - textField.width) * 0.5;
			textField.y = (uiHeight - textField.height) * 0.5 + _txtOffsetV;
		}
		
		override protected function render():void{
			if(CtrlCenter.needShowApeFrame){
				this.bgSprite.graphics.lineStyle(1, 0xFF00FF00);
			}
			switch (_state){
				case MOUSE_OVER:
					if (this._stateOverBmd != null){
						this.bgSprite.graphics.beginBitmapFill(this._stateOverBmd, new Matrix(this.uiWidth / this._stateOverBmd.width, 0, 0, this.uiHeight / this._stateOverBmd.height), false, true);
						//this.bgSprite.graphics.beginBitmapFill(this._stateOverBmd);
					}else{
						this.bgSprite.graphics.beginFill(_uiBgColor);
					}
					break;
				case MOUSE_DOWN:
					if (this._stateDownBmd != null){
						this.bgSprite.graphics.beginBitmapFill(this._stateDownBmd, new Matrix(this.uiWidth / this._stateDownBmd.width, 0, 0, this.uiHeight / this._stateDownBmd.height), false, true);
						//this.bgSprite.graphics.beginBitmapFill(this._stateDownBmd);
					}else{
						this.bgSprite.graphics.beginFill(_uiBgColor);
					}
					break;
				case DISABLED:
					if (this._stateDisabledBmd != null){
						this.bgSprite.graphics.beginBitmapFill(this._stateDisabledBmd, new Matrix(this.uiWidth / this._stateDisabledBmd.width, 0, 0, this.uiHeight / this._stateDisabledBmd.height), false, true);
						//this.bgSprite.graphics.beginBitmapFill(this._stateDisabledBmd);
					}else{
						this.bgSprite.graphics.beginFill(_uiBgColor);
					}
					break;
				case NORMAL:
					super.render();
					break;
			}
			this.bgSprite.graphics.drawRect(0, 0, this.uiWidth, this.uiHeight);
			this.bgSprite.graphics.endFill();
		}
		

		//异步加载
		public function setStateSrc(srcPath:String, state:String):void{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(srcPath));
			switch(state){
				case MOUSE_OVER:
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onMouseOverLoaded);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onOverError);
					this._stateOverSrc = srcPath;
					break;
				case MOUSE_DOWN:
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onMouseDownLoaded);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onDownError);
					this._stateDownSrc = srcPath;
					break;
				case DISABLED:
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onDisableLoaded);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onDisabledError);
					this._stateDisabledSrc = srcPath;
					break;
			}
			fresh();
		}
		
		protected function onOverError(event:IOErrorEvent):void{
			this._stateOverBmd = null;
			this._stateOverSrc = "";
		}
		
		protected function onDownError(event:IOErrorEvent):void{
			this._stateDownBmd = null;
			this._stateDownSrc = "";
		}
		
		protected function onDisabledError(event:IOErrorEvent):void
		{
			this._stateDisabledBmd = null;
			this._stateDisabledSrc = "";
		}
		
		protected function onMouseOverLoaded(event:Event):void{
			var loader:Loader = event.target.loader;
			stateOverBmd = new BitmapData(loader.width, loader.height, true, 0x00FFFFFF);
			stateOverBmd.draw(loader);
			fresh();
		}
		
		protected function onMouseDownLoaded(event:Event):void{
			var loader:Loader = event.target.loader;
			stateDownBmd = new BitmapData(loader.width, loader.height, true, 0x00FFFFFF);
			stateDownBmd.draw(loader);
			fresh();
		}
		
		protected function onDisableLoaded(event:Event):void{
			var loader:Loader = event.target.loader;
			stateDisabledBmd = new BitmapData(loader.width, loader.height, true, 0x00FFFFFF);
			stateDisabledBmd.draw(loader);
			fresh();
		}
	}
}