package ui.ctrls.Advanced{
	
	import ui.ctrls.BitmapScale9Grid;
	import ui.ctrls.ButtonBase;
	import ui.ctrls.StrokeLabel;
	import ui.ctrls.UIInfo;
	
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
	
	public class ScaleButton extends ButtonBase{
		
		/** 四角拉伸保持的维持量 */
		protected var _keepSize:Number = 10; 
		
		protected var scale:BitmapScale9Grid = new BitmapScale9Grid();
		
		public function ScaleButton(width:Number=75, height:Number=23){
			super(width, height);
			this.addChild(scale);
			this.setChildIndex(scale, 1);
		}
		
		
		override protected function initButton():void{
			this.uiSubType = UIInfo.SCALE_BUTTON;
		}
		
		//------------------------------------------------------------------------------
		
		override public function set uiWidth(value:uint):void{
			this._uiWidth = value;
			fresh();
		}
		
		//------------------------------------------------------------------------------	
		
		override public function set uiHeight(value:uint):void{
			this._uiHeight = value;
			fresh();
		}
		
		//-------------------------------------------------------------------------------
		
		override protected function render():void{
			if(CtrlCenter.needShowApeFrame){
				this.bgSprite.graphics.lineStyle(1, 0xcccccc);
			}
			switch (_state){
				case MOUSE_OVER:
					if (this._stateOverBmd != null){
						scale.assign(_stateOverBmd);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(_uiBgColor);
					}
					break;
				case MOUSE_DOWN:
					if (this._stateDownBmd != null){
						scale.assign(_stateDownBmd);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(_uiBgColor);
					}
					break;
				case DISABLED:
					if (this._stateDisabledBmd != null){
						scale.assign(_stateDisabledBmd);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(_uiBgColor);
					}
					break;
				case NORMAL:
					if (this._uiBgBitmap != null){
						scale.assign(_uiBgBitmap);
						scale.width = this.uiWidth;
						scale.height = this.uiHeight;
					}else{
						this.bgSprite.graphics.beginFill(_uiBgColor);
					}
					break;
			}
			this.bgSprite.graphics.drawRect(0, 0, this.uiWidth, this.uiHeight);
			this.bgSprite.graphics.endFill();
		}
		
		
	}
}