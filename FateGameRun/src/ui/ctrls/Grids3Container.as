package ui.ctrls{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Grids3Container extends Ape{
		
		private var gridsThree:BitmapScale3Grid;
		
		//----------------------------------------------------------------------
		
		/**根据背景图片路径加载背景图片完成之后的处理函数*/
		override protected function onBgLoaded(event:Event):void{
			var loader:Loader = event.target.loader;
			this.uiBgBitmap = new BitmapData(loader.width, loader.height, true, 0x00000000);
			uiBgBitmap.draw(loader);	
			gridsThree.assign(uiBgBitmap);
			gridsThree.width = this._uiWidth;
			gridsThree.height = this._uiHeight;
			fresh();
		}
		
		//------------------------------------------------------------------------------
		
		[Bindable]
		override public function set uiWidth(value:uint):void{
			//trace("setWidth:" + value);
			if (value >= 0 && this._uiWidth != value){
				this._uiWidth = value;
				if(gridsThree != null && uiBgBitmap != null){
					gridsThree.width = value;
				}
			}
			fresh();
		}
		
		override public function get uiWidth():uint{
			return this._uiWidth;
		}
		
		//------------------------------------------------------------------------------
		
		
		
		//------------------------------------------------------------------------------	
		
		public function Grids3Container(width:Number = 80, height:Number = 30){
			gridsThree = new BitmapScale3Grid();
			super(width, height);
			this.uiType 	= UIInfo.TYPE_CONTAINER;
			this.uiSubType 	= UIInfo.GRIDS3CONTAINER;
			this.addChild(gridsThree);
		}
		
		
		
		
		/** 覆盖 刷新【重绘】 */
		override protected function fresh():void{
			gridsThree.graphics.clear();
			this.preRender();
			this.render();
		}
		
		/**预渲染*/
		override protected function preRender():void{
			//trace("hello");
		}
		
		
		/**渲染方法*/
		override protected function render():void{
			gridsThree.graphics.lineStyle(1, 0xFFFF00FF);
			if (uiBgBitmap != null){
				
			}else{
				gridsThree.graphics.beginFill(_uiBgColor);
			}
			gridsThree.graphics.drawRoundRect(0, 0, uiWidth, uiHeight, 5);
			gridsThree.graphics.endFill();
			gridsThree.alpha = uiAlpha;
		}
		
	}
}