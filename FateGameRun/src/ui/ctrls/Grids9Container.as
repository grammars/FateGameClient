package ui.ctrls{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Grids9Container extends Ape{
		
		private var gridsNine:BitmapScale9Grid;
		
		//----------------------------------------------------------------------
		
		/**根据背景图片路径加载背景图片完成之后的处理函数*/
		override protected function onBgLoaded(event:Event):void{trace("九宫容器onBgLoaded");
			var loader:Loader = event.target.loader;
			this.uiBgBitmap = new BitmapData(loader.width, loader.height, true, 0x00000000);
			uiBgBitmap.draw(loader);
			gridsNine.assign(uiBgBitmap);
			gridsNine.width = this._uiWidth;
			gridsNine.height = this._uiHeight;
			fresh();
		}
		
		//------------------------------------------------------------------------------
		
		[Bindable]
		override public function set uiWidth(value:uint):void{
			if (value >= 0 && this._uiWidth != value){
				this._uiWidth = value;
				if(gridsNine != null && uiBgBitmap != null){
					gridsNine.width = value;
				}
			}
			fresh();
		}
		
		override public function get uiWidth():uint{
			return this._uiWidth;
		}
		
		//------------------------------------------------------------------------------
		
		[Bindable]
		override public function set uiHeight(value:uint):void{
			if (value >= 0 && this._uiHeight != value){
				this._uiHeight = value;
				if(gridsNine != null && uiBgBitmap != null){
					gridsNine.height = value;
				}
			}
			fresh();
		}
		
		override public function get uiHeight():uint{
			return this._uiHeight;
		}
		
		//------------------------------------------------------------------------------	
		
		public function Grids9Container(width:Number = 230, height:Number = 320){
			gridsNine = new BitmapScale9Grid();
			super(width, height);
			this.uiType 	= UIInfo.TYPE_CONTAINER;
			this.uiSubType 	= UIInfo.GRIDS9CONTAINER;
			this.addChild(gridsNine);
		}
		
		
		
		
		/** 覆盖 刷新【重绘】 */
		override protected function fresh():void{
			gridsNine.graphics.clear();
			this.preRender();
			this.render();
		}
		
		/**预渲染*/
		override protected function preRender():void{
			//trace("hello");
		}
		
		
		/**渲染方法*/
		override protected function render():void{
			gridsNine.graphics.lineStyle(1, 0xFFFF00FF);
			if (uiBgBitmap != null){
				
			}else{
				gridsNine.graphics.beginFill(_uiBgColor);
			}
			gridsNine.graphics.drawRoundRect(0, 0, uiWidth, uiHeight, 5);
			gridsNine.graphics.endFill();
			gridsNine.alpha = uiAlpha;
		}
		
	}
}