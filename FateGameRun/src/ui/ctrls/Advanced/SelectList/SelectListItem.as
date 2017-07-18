package ui.ctrls.Advanced.SelectList
{
	import ui.ctrls.Label;
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.StrokeLabel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SelectListItem extends Sprite
	{
		private var _label:StrokeLabel;
		/** 标签内容 */
		private var _content:String = "default";
		public function set content(value:String):void
		{
			_content = value;
			if(_label)
			{
				_label.uiLabel = value;
			}
		}
		public function get content():String
		{
			return _content;
		}
		
		/** 对应序列 */
		public var index:int = 0;
		
		/** 背景宽度 */
		private var bgWidth:int = 100;
		
		/** 背景高度 */
		private var bgHeight:int = 20;
		
		/** 所属组件的uiName */
		private var ownerName:String = "";
		
		
		public function SelectListItem(contentStr:String , bgWidth:int = 100 , bgHeight:int = 20, ownerName:String = "", index:int=0)
		{
			super();
			this.ownerName = ownerName;
			this.index = index;
			this.bgWidth = bgWidth;
			this.bgHeight = bgHeight;
			this._label = new StrokeLabel(bgWidth, bgHeight);
			this._label.uiAlign = LayoutStyle.CENTER;
			this._label.mouseEnabled = false;
			this._label.uiTxtColor = "0xffffff";
			this._label.uiTxtStrokeColor = "0x000000";
			this._label.uiTxtSize = "12";
			this.addChild(this._label);
			this.content = contentStr;
			drawItem(0xFFFFFF , 0x050705);
			this.addEventListener(MouseEvent.MOUSE_OVER , mouse_over);
			this.addEventListener(MouseEvent.MOUSE_OUT , mouse_out);
			this.addEventListener(MouseEvent.CLICK, mouse_click);
		}
		
		
		/** 鼠标经过 */
		private function mouse_over(event:MouseEvent):void
		{
			drawItem(0xFFFFFF , 0x818600);
			event.stopImmediatePropagation();
			//event.stopPropagation();
		}
		
		
		/** 鼠标移出 */
		private function mouse_out(event:MouseEvent):void
		{
			drawItem(0xFFFFFF , 0x050705);
			event.stopImmediatePropagation();
			//event.stopPropagation();
		}
		
		
		/** 鼠标点击 */
		private function mouse_click(event:MouseEvent):void
		{
			var data:Object = new Object();
			data.uiName = ownerName;
			data.index = index;
			data.content = content;
			new SelectListEvent(SelectListEvent.SELECT_LIST_ITEM_CLICK, data).dispatch();
		}
		
		
		/** 绘制 */
		private function drawItem(lineColor:uint , fillColor:uint):void
		{
			this.graphics.clear();
			//this.graphics.lineStyle(1 , lineColor , 1);
			this.graphics.beginFill(fillColor , 0.8);
			this.graphics.drawRect(0 , 0 , bgWidth , bgHeight);
			this.graphics.endFill();
		}
		
	}
}