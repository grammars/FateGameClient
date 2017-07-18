package ui.ctrls.Advanced{
	
	import ui.ctrls.NoScaleApe;
	import ui.ctrls.UIInfo;
	
	public class ComboScaleButton extends ScaleButton{
		
		/** 封面图层 */
		public var cover:NoScaleApe = new NoScaleApe();
		
		//-----------------------------------------------------------------------
		/** 封面图层图片地址 */
		protected var _coverSrc:String = "";
		
		public function set coverSrc(value:String):void{
			this._coverSrc = value;
			cover.uiBgSrc = value;
		}
		
		public function get coverSrc():String{
			return _coverSrc;
		}
		//-----------------------------------------------------------------------
		
		
		public function ComboScaleButton(width:Number=75, height:Number=23){
			super(width, height);
		}
		
		
		override protected function initButton():void{
			this.uiSubType = UIInfo.COMBO_SCALE_BUTTON;
			this.addChild(cover);
		}
		
		
		override protected function render():void{
			coverAjust();
			super.render();
		}
		
		
		/** 调整封面位置 */
		protected function coverAjust():void{
			if(cover.uiBgBitmap != null){
				cover.x = (this.uiWidth - cover.uiBgBitmap.width) / 2;
				cover.y = (this.uiHeight - cover.uiBgBitmap.height) / 2;
			}
		}
		
		
	}
}