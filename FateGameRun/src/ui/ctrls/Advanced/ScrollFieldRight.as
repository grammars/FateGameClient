package ui.ctrls.Advanced{
	import ui.ctrls.Ape;
	import ui.ctrls.ButtonBase;
	import ui.ctrls.UIInfo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	public class ScrollFieldRight extends ScrollField{
		
		public function ScrollFieldRight(width:Number = 300, height:Number = 200){
			super(width, height);
			this.uiSubType = UIInfo.SCROLL_FIELD_RIGHT;
		}
		
		
		/** 改变默认参数 */
		override protected function changeDefault():void{
			barBg.uiX = this.uiWidth - barBg.uiWidth;
			barBg.uiY = 0;
			upBtn.uiX = this.uiWidth - upBtn.uiWidth;
			upBtn.uiY = 0;
			downBtn.uiX = this.uiWidth - downBtn.uiWidth;
			downBtn.uiY = this.uiHeight - downBtn.uiHeight;
			barBtn.uiX = this.uiWidth - barBtn.uiWidth;
			barBtn.uiY = upBtn.uiHeight;
		}
		
		
		/** 处理upBtn downBtn barBtn 的位置 以及 barBtn 的 大小 */
		override protected function preRender():void{
			if(bounds == null){
				bounds = new Rectangle(286,24,0,119);
			}
			//
			barBg.uiX = this.uiWidth - barBg.uiWidth;
			barBg.uiY = 0;
			upBtn.uiX = this.uiWidth - upBtn.uiWidth;
			upBtn.uiY = 0;
			downBtn.uiX = this.uiWidth - downBtn.uiWidth;
			downBtn.uiY = this.uiHeight - downBtn.uiHeight;
			barBtn.uiX = this.uiWidth - barBtn.uiWidth;
			//
			bounds.x = this.uiWidth - barBtn.uiWidth;
			bounds.height = this.uiHeight - upBtn.uiHeight - downBtn.uiHeight - barBtn.uiHeight;
		}
		
	}
}