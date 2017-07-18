package run.scene.avatar
{
	import flash.display.Sprite;
	
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.StrokeLabel;
	
	public class AvtNamePart extends Sprite
	{
		public static const W:int = 100;
		public static const H:int = 20;
		
		private var label:StrokeLabel = new StrokeLabel(W, H);
		
		public function AvtNamePart()
		{
			super();
			
			this.graphics.beginFill(0xfefe38, 0.001);
			this.graphics.drawRoundRect(0, 0, W, H, 5, 5);
			this.graphics.endFill();
			
			label.uiTxtSize = "12";
			label.uiTxtColor = "0x12de12";
			label.uiTxtStrokeStrength = "2";
			label.uiAlign = LayoutStyle.CENTER;
			//label.drawRect();
			this.addChild(label);
		}
		
		public function changeName(name:String):void
		{
			label.uiLabel = name;
		}
		
	}
}