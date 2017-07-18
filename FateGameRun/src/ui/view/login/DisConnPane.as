package ui.view.login
{
	import central.Centre;
	
	import comm.L;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import ui.TmpPane;
	import ui.ctrls.Ape;
	import ui.ctrls.Button;
	import ui.ctrls.StrokeLabel;
	
	public class DisConnPane extends TmpPane
	{
		private var alertLabel:StrokeLabel;
		private var reloginBtn:Button;
		
		public function DisConnPane()
		{
			super();
			
			canvas = new Ape(290, 80);
			canvas.uiBgBitmap = new BitmapData(2, 2, true, 0x77de5ede);
			canvas.drawRect();
			this.addChild(canvas);
			
			alertLabel = createLabel(L.T("您已掉线"), 0, 0, 270);
			reloginBtn = createBtn(L.T("重新登录"), 0, 30, __reloginBtn);
		}
		
		private function __reloginBtn(e:MouseEvent):void
		{
			//
		}
		
	}
}