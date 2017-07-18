package ui.ctrls{
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import ui.ctrls.Framework.CtrlCenter;
	
	
	/**基础控件*/
	public class Ape extends Sprite{
		
		protected var _uiName:String = "";
		protected var _uiType:String = "";
		protected var _uiSubType:String = "";
		protected var _uiWidth:uint = 0;
		protected var _uiHeight:uint = 0;
		protected var _uiAlpha:Number = 1;
		protected var _uiHLayout:String = LayoutStyle.NONE;
		protected var _uiVLayout:String = LayoutStyle.NONE;
		protected var _uiBgColor:uint = 0xffffff;
		protected var _uiBgBitmap:BitmapData = null;
		protected var _uiBgSrc:String = "";
		
		public var bgSprite:Sprite = new Sprite();
		
////////get & set////////////////////////////////////////////////////////////////////
		
		public function set uiName(value:String):void{
			if (value != null && _uiName != value){
				_uiName = value;
				UIDic.dic[_uiName] = this;
			}
		}
		
		public function get uiName():String{
			return this._uiName;
		}
		
	//------------------------------------------------------------------------------		
		
		public function set uiType(value:String):void{
			if (value != null && value != _uiType){
				this._uiType = value;
			}
		}
		
		public function get uiType():String{
			return this._uiType;
		}
		
	//------------------------------------------------------------------------------		
		
		public function set uiSubType(value:String):void{
			if (value != null && value != _uiSubType)
				this._uiSubType = value;
		}
		
		public function get uiSubType():String{
			return this._uiSubType;
		}
		
	//------------------------------------------------------------------------------
		
		public function set uiWidth(value:uint):void{
			if (value >= 0 && this._uiWidth != value){
				this._uiWidth = value;
				fresh();
			}
		}
		
		public function get uiWidth():uint{
			return this._uiWidth;
		}
		
	//------------------------------------------------------------------------------	
		
		public function set uiHeight(value:uint):void{
			if (value >= 0 && this._uiHeight != value){
				this._uiHeight = value;
				fresh();
			}
		}
		
		public function get uiHeight():uint{
			return this._uiHeight;
		}
	
	//------------------------------------------------------------------------------	
		
		public function set uiHLayout(value:String):void{
			this._uiHLayout = value;
		}
		
		public function get uiHLayout():String{
			return this._uiHLayout;
		}
	
	//------------------------------------------------------------------------------	
		
		public function set uiVLayout(value:String):void{
			this._uiVLayout = value;
		}
		
		public function get uiVLayout():String{
			return this._uiVLayout;
		}
		
	//------------------------------------------------------------------------------	
		
		public function set uiAlpha(value:Number):void{
			if (value >= 0 && value <=1 && this.alpha != value){
				this._uiAlpha = value;
				fresh();
			}
		}
		
		public function get uiAlpha():Number{
			return this._uiAlpha;
		}	
		
	//------------------------------------------------------------------------------
		
		public function set uiBgColor(value:String):void{
			if (this._uiBgColor.toString() != value){
				this._uiBgColor = parseInt(value,16);
				fresh();
			}
		}
		public function get uiBgColor():String{
			return this._uiBgColor.toString(16);
		}
		
	//------------------------------------------------------------------------------
		
		public function set uiBgBitmap(value:BitmapData):void{
			if (value != this._uiBgBitmap){
				this._uiBgBitmap = value;
				fresh();
			}
		}
		public function get uiBgBitmap():BitmapData{
			return this._uiBgBitmap;
		}
		
	//------------------------------------------------------------------------------
		
		public function set uiBgSrc(value:String):void{
			if (value != null && value != _uiBgSrc){
				_uiBgSrc = value;
				this.setBgSrc(_uiBgSrc);
				fresh();
			}
		}
		
		public function get uiBgSrc():String{
			return this._uiBgSrc;
		}
		
		
	//------------------------------------------------------------------------------
		
		public function set uiX(value:Number):void{
			if (value != this.x){
				this.x = value;
				fresh();
			}
		}
		public function get uiX():Number{
			return this.x;
		}
		
	//------------------------------------------------------------------------------
		
		public function set uiY(value:Number):void{
			if (this.y != value){
				this.y = value;
				fresh();
			}
		}
		public function get uiY():Number{
			return this.y;
		}
		
////////////////////////////////////////////////////////////////////////////////////	
		
		public function Ape(width:Number, height:Number){
			super();
			this.uiWidth = width;
			this.uiHeight = height;
			this.addChild(bgSprite);
			this.hitArea = bgSprite;
			bgSprite.mouseEnabled = false;
		}
		
		
		/** 强制重绘 */
		public function forceFresh():void{
			bgSprite.graphics.clear();
			preRender();
			render();
		}
		
		
		/** 刷新【重绘】 */
		protected function fresh():void{
			bgSprite.graphics.clear();
			
			drawRectHandler();
			
			preRender();
			render();
		}
		
		
		/**根据背景图片路径加载背景图片*/
		public function setBgSrc(path:String):void{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(path));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBgLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onBgLoadError);
			this._uiBgSrc = path;
		}
		
		
		/**根据背景图片路径加载背景图片时出错的处理*/
		protected function onBgLoadError(event:IOErrorEvent):void{
			this._uiBgSrc = "";
			this.uiBgBitmap = null;
		}
		
		
		/**根据背景图片路径加载背景图片完成之后的处理函数*/
		protected function onBgLoaded(event:Event):void{
			var loader:Loader = event.target.loader;
			if (this.uiBgBitmap == null){
				this.uiBgBitmap = new BitmapData(loader.content.width, loader.content.height, true, 0x00000000);
			}
			this.uiBgBitmap.draw(loader);
			fresh();
		}
		
		
		/**预渲染*/
		protected function preRender():void{
			//trace("hello");
		}
		
		
		/**渲染方法*/
		protected function render():void{
			if(CtrlCenter.needShowApeFrame){
				bgSprite.graphics.lineStyle(1, 0xFFFF0000);
			}
			bgSprite.alpha = 1;
			if (uiBgBitmap != null){
				bgSprite.graphics.beginBitmapFill(uiBgBitmap, new Matrix(this.uiWidth / uiBgBitmap.width, 0, 0, this.uiHeight / uiBgBitmap.height), false, false);
				bgSprite.alpha = uiAlpha;
			}
			else{
				bgSprite.graphics.beginFill(_uiBgColor, uiAlpha);
			}
			bgSprite.graphics.drawRect(0, 0, uiWidth, uiHeight);
			bgSprite.graphics.endFill();
		}
		
		protected var needDrawRect:Boolean = false;
		public function drawRect():void
		{
			needDrawRect = true;
			fresh();
		}
		protected function drawRectHandler():void
		{
			if(needDrawRect)
			{
				bgSprite.graphics.lineStyle(2, 0xde7611, 0.8);
				bgSprite.graphics.drawRoundRect(0, 0, this.uiWidth, this.uiHeight, 3, 3);
				bgSprite.graphics.lineStyle(1, 0x121211, 0.8);
				bgSprite.graphics.drawRoundRect(2, 2, this.uiWidth-4, this.uiHeight-4, 3, 3);
			}
		}
		
	}
}