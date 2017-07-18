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
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	
	public class Link extends Label{
		
		protected var _state:String = ButtonBase.NORMAL;
		
		protected var _overTxtColor:uint = 0xff0000;
		protected var _downTxtColor:uint = 0x00ff00;
		
		public function Link(width:Number = 75, height:Number = 23){
			super(width, height);
			this.uiLabel = "链接";
			this.mouseEnabled 	= true;
			//this.mouseChildren 	= false;
			this.buttonMode 	= true;
			this.uiType			= UIInfo.TYPE_CONTROL;
			
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			initLink();
		}
		
		
		protected function initLink():void{
			this.uiSubType		= UIInfo.LINK;
			this.uiTxtUnderline = "true";
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
			if(CtrlCenter.needShowApeFrame){
				this.bgSprite.graphics.lineStyle(1, 0xcccccc);
			}
			//this.bgSprite.graphics.beginFill(0x000000, 0.5);
			this.bgSprite.graphics.drawRect(0, 0, this.uiWidth, this.uiHeight);
			this.bgSprite.graphics.endFill();
			preRender();
		}
		
		
		override protected function preRender():void{
			switch (_state){
				case ButtonBase.MOUSE_OVER:
					textFormat.color = this._overTxtColor;
					super.preRender();
					break;
				case ButtonBase.MOUSE_DOWN:
					textFormat.color = this._downTxtColor;
					super.preRender();
					break;
				case ButtonBase.DISABLED:
					textFormat.color = parseInt(uiTxtColor,16);
					super.preRender();
					break;
				case ButtonBase.NORMAL:
					textFormat.color = parseInt(uiTxtColor,16);
					super.preRender();
					break;
			}
		}
		
		
		
	}
}