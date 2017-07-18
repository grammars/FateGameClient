package ui.ctrls.Advanced.ListButton{
	
	import ui.ctrls.Label;
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.StrokeLabel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import ui.ctrls.LayoutStyle;
	
	public class ListButtonItem extends Sprite{
		
		/** 显示标识 */
		private var label:String = "默认Label";
		
		/** 对应序列 */
		public var index:int = 0;
		
		/** 背景宽度 */
		private var bgWidth:int = 100;
		
		/** 背景高度 */
		private var bgHeight:int = 20;
		
		/** 标识文本 */
		private var labelTxt:StrokeLabel = new StrokeLabel();
		
		public function ListButtonItem(label:String , bgWidth:int = 100 , bgHeight:int = 20){
			super();
			this.label = label;
			this.bgWidth = bgWidth;
			this.bgHeight = bgHeight;
			this.labelTxt.uiAlign = LayoutStyle.CENTER;
			this.labelTxt.mouseEnabled = false;
			this.labelTxt.uiLabel = label;
			this.labelTxt.uiWidth = bgWidth;
			this.labelTxt.uiHeight = bgHeight;
			this.labelTxt.uiTxtColor = "0xffffff";
			this.labelTxt.uiTxtStrokeColor = "0x000000";
			this.labelTxt.uiTxtSize = "12";
			labelTxt.y = (bgHeight - 16)/2;
			this.addChild(labelTxt);
			drawItem(0xFFFFFF , 0x050705);
			this.addEventListener(MouseEvent.MOUSE_OVER , mouse_over);
			this.addEventListener(MouseEvent.MOUSE_OUT , mouse_out);
			
		}
		
		
		/** 鼠标经过 */
		private function mouse_over(event:MouseEvent):void{
			drawItem(0xFFFFFF , 0x818600);
			event.stopImmediatePropagation();
			//event.stopPropagation();
		}
		
		
		/** 鼠标移出 */
		private function mouse_out(event:MouseEvent):void{
			drawItem(0xFFFFFF , 0x050705);
			event.stopImmediatePropagation();
			//event.stopPropagation();
		}
		
		
		
		/** 绘制 */
		private function drawItem(lineColor:uint , fillColor:uint):void{
			this.graphics.clear();
			//this.graphics.lineStyle(1 , lineColor , 1);
			this.graphics.beginFill(fillColor , 0.8);
			this.graphics.drawRect(0 , 0 , bgWidth , bgHeight);
			this.graphics.endFill();
		}
		
	}
}