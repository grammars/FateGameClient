package ui
{
	import central.Centre;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import gamekit.layer.Layer;
	
	import ui.ctrls.Ape;
	import ui.ctrls.Button;
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.NormalInput;
	import ui.ctrls.StrokeLabel;
	
	public class TmpPane extends Sprite
	{
		protected static const MARGIN_X:int = 10;
		protected static const MARGIN_Y:int = 10;
		
		protected var canvas:Ape;
		
		public function TmpPane()
		{
			super();
		}
		
		protected function createLabel(caption:String, px:int=0, py:int=0, pWidth:Object=null, pHeight:Object=null):StrokeLabel
		{
			var label:StrokeLabel = new StrokeLabel(100, 24);
			if(pWidth) { label.uiWidth = int(pWidth); }
			if(pHeight) { label.uiHeight = int(pHeight); }
			label.uiLabel = caption;
			label.uiTxtColor = "0xde7611";
			label.uiTxtSize = "16";
			label.drawRect();
			label.uiAlign = LayoutStyle.CENTER;
			label.x = px+MARGIN_X;
			label.y = py+MARGIN_Y;
			canvas.addChild(label);
			return label;
		}
		
		protected function createInput(caption:String, px:int=0, py:int=0, pWidth:Object=null, pHeight:Object=null):NormalInput
		{
			var input:NormalInput = new NormalInput(150, 24);
			if(pWidth) { input.uiWidth = int(pWidth); }
			if(pHeight) { input.uiHeight = int(pHeight); }
			input.content = caption;
			input.uiTxtColor = "0x4e4e4e";
			input.uiTxtSize = "16";
			input.uiTxtBold = "true";
			input.drawRect();
			input.x = px+MARGIN_X;
			input.y = py+MARGIN_Y;
			canvas.addChild(input);
			return input;
		}
		
		protected function createBtn(caption:String, px:int=0, py:int=0, callBack:Function=null, pWidth:Object=null, pHeight:Object=null):Button
		{
			var btn:Button = new Button(270, 30);
			if(pWidth) { btn.uiWidth = int(pWidth); }
			if(pHeight) { btn.uiHeight = int(pHeight); }
			btn.uiLabel = caption;
			btn.uiBgColor = "0x4e4e4e";
			btn.stateOverBmd = new BitmapData(2, 2, true, 0xaade7611);
			btn.uiTxtSize = "16";
			btn.drawRect();
			btn.x = px+MARGIN_X;
			btn.y = py+MARGIN_Y;
			canvas.addChild(btn);
			if(callBack != null)
			{
				btn.addEventListener(MouseEvent.CLICK, callBack);
			}
			return btn;
		}
		
		public function show(needCentre:Boolean=true):void
		{
			if(needCentre)
			{
				this.x = ( Centre.stage.stageWidth - this.width ) / 2 ;
				this.y = ( Centre.stage.stageHeight - this.height ) / 2 ;
			}
			Layer.ui.addChild(this);
		}
		
		public function hide():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
		
	}
}