package com.anstu.jui.build.ctrls.base
{	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ShellFrame extends Sprite
	{
		public static const WIDTH:int = 80;
		public static const HEIGHT:int = 80;
		
		public var frameName:String = "default";
		
		public var frameColor:uint = 0xff0000;
		public var frameThickness:int = 1;
		public var frameAlpha:Number = 1;
		
		public var selectedColor:uint = 0xaa3300;
		public var selectedThickness:int = 2;
		public var selectedAlpha:Number = 1;
		
		public var selectHandler:Function=null;
		
		private var over:Boolean = false;
		
		public function ShellFrame(frameName:String, 
								   frameColor:uint, frameThickness:int, frameAlpha:Number,
								   selectedColor:uint, selectedThickness:int, selectedAlpha:Number,
								   selectHandler:Function=null)
		{
			super();
			
			this.buttonMode = true;
			
			this.frameName = frameName;
			this.frameColor = frameColor;
			this.frameThickness = frameThickness;
			this.frameAlpha = frameAlpha;
			this.selectedColor = selectedColor;
			this.selectedThickness = selectedThickness;
			this.selectedAlpha = selectedAlpha;
			this.selectHandler = selectHandler;
			
			var label:JLabel = new JLabel(frameName);
			label.useStroke = true;
			label.textFormat.color = 0xa5dcdc;
			label.textFormat.size = 14;
			label.autoWrap = true;
			label.setSize(64, 64);
			label.align = JuiConst.CENTER;
			label.valign = JuiConst.MIDDLE;
			this.addChild(label);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, __mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, __mouseOut);
			this.addEventListener(MouseEvent.CLICK, __mouseClick);
		
			paint();
		}
		
		private function __mouseOver(e:MouseEvent):void
		{
			over = true;
			paint();
		}
		
		private function __mouseOut(e:MouseEvent):void
		{
			over = false;
			paint();
		}
		
		private function paint():void
		{
			this.graphics.clear();
			if(over)
			{
				this.graphics.lineStyle(selectedThickness, selectedColor, selectedAlpha);
				this.graphics.beginFill(0xb2b2b2);
				this.graphics.drawRoundRect(0, 0, 64, 64, 3, 3);
			}
			else
			{
				this.graphics.lineStyle(frameThickness, frameColor, frameAlpha);
				this.graphics.beginFill(0xb2b2b2);
				this.graphics.drawRoundRect(0, 0, 64, 64, 3, 3);
			}
		}
		
		private function __mouseClick(e:MouseEvent):void
		{
			if(selectHandler != null)
			{
				selectHandler(this);
			}
		}
		
	}
	
}