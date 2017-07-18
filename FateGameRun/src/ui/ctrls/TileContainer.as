package ui.ctrls{
	import ui.ctrls.Framework.CtrlCenter;
	
	import flash.geom.Matrix;
	
	public class TileContainer extends Ape{
		
		public function TileContainer(width:Number = 200, height:Number = 200){
			super(width, height);
			this.uiType 	= UIInfo.TYPE_CONTAINER;
			this.uiSubType 	= UIInfo.TILE_CONTAINER;
		}
		
		protected var _samplePtX:int = 0;
		/** 采样点x */
		public function set samplePtX(value:int):void{
			if(value != this._samplePtX){
				this._samplePtX = value;
				fresh();
			}
		}
		public function get samplePtX():int{
			return this._samplePtX;
		}
		
		protected var _samplePtY:int = 0;
		/** 采样点y */
		public function set samplePtY(value:int):void{
			if(value != this._samplePtY){
				this._samplePtY = value;
				fresh();
			}
		}
		public function get samplePtY():int{
			return this._samplePtY;
		}
		
		
		/**渲染方法【覆盖基类的渲染，为了实现平铺，所以取消基类的拉伸位图的功能】*/
		override protected function render():void{
			if(CtrlCenter.needShowApeFrame){
				bgSprite.graphics.lineStyle(1, 0xFFFFFF00);
			}
			if (uiBgBitmap != null){
				var mtx:Matrix = new Matrix();
				mtx.tx = -_samplePtX;
				mtx.ty = -_samplePtY;
				bgSprite.graphics.beginBitmapFill(uiBgBitmap, mtx, true, false);
			}
			else{
				bgSprite.graphics.beginFill(_uiBgColor);
			}
			bgSprite.graphics.drawRect(0, 0, uiWidth, uiHeight);
			bgSprite.graphics.endFill();
			bgSprite.alpha = uiAlpha;
		}
	}
}