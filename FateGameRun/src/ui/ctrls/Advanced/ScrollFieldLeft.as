package ui.ctrls.Advanced{
	import ui.ctrls.Ape;
	import ui.ctrls.ButtonBase;
	import ui.ctrls.UIInfo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	public class ScrollFieldLeft extends ScrollField{
		
		public function ScrollFieldLeft(width:Number = 300, height:Number = 200){
			super(width, height);
			this.uiSubType = UIInfo.SCROLL_FIELD_LEFT;
		}
		
		
		/** 改变默认参数 */
		override protected function changeDefault():void{
			barBg.uiX = 0;
			barBg.uiY = 0;
			upBtn.uiX = 0;
			upBtn.uiY = 0;
			downBtn.uiX = 0;
			downBtn.uiY = this.uiHeight - downBtn.uiHeight;
			barBtn.uiX = 0;
			barBtn.uiY = upBtn.uiHeight;
		}
		
		
		/** 处理upBtn downBtn barBtn 的位置 以及 barBtn 的 大小 */
		override protected function preRender():void{
			if(bounds == null){
				bounds = new Rectangle(0,24,0,119);
			}
			//
			barBg.uiX = 0;
			barBg.uiY = 0;
			upBtn.uiX = 0;
			upBtn.uiY = 0;
			downBtn.uiX = 0;
			downBtn.uiY = this.uiHeight - downBtn.uiHeight;
			barBtn.uiX = 0;
			//
			bounds.x = 0;
			bounds.height = this.uiHeight - upBtn.uiHeight - downBtn.uiHeight - barBtn.uiHeight;
		}
		
	}
}