package ui.ctrls{
	import ui.ctrls.Framework.CtrlCenter;
	
	public class NoScaleApe extends Ape{
		
		public function NoScaleApe(width:Number = 10, height:Number = 10){
			super(width, height);
		}
		
		
		/**渲染方法*/
		override protected function render():void{
			if(CtrlCenter.needShowApeFrame){
				bgSprite.graphics.lineStyle(1, 0xFFFF0000);
			}
			if (uiBgBitmap != null){
				this.uiWidth = uiBgBitmap.width;
				this.uiHeight = uiBgBitmap.height;
				bgSprite.graphics.beginBitmapFill(uiBgBitmap , null , false , false);
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