package ui.view.login
{
	import central.Centre;
	import central.Game;
	
	import comm.L;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.TmpPane;
	import ui.ctrls.Ape;
	import ui.ctrls.Button;
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.NormalInput;
	import ui.ctrls.StrokeLabel;
	
	public class LoginPane extends TmpPane
	{
		private var alertLabel:StrokeLabel;
		private var usernameLabel:StrokeLabel;
		private var usernameInput:NormalInput;
		private var ipLabel:StrokeLabel;
		private var ipInput:NormalInput;
		private var portLabel:StrokeLabel;
		private var portInput:NormalInput;
		private var enterBtn:Button;
		
		public function LoginPane()
		{
			super();
			
			canvas = new Ape(290, 200);
			canvas.uiBgBitmap = new BitmapData(2, 2, true, 0x77dedede);
			canvas.drawRect();
			this.addChild(canvas);
			
			alertLabel = createLabel(L.T("命运")+Centre.VERSION, 0, 0, 270);
			usernameLabel = createLabel(L.T("用户名"), 0, 30);
			usernameInput = createInput("10086", 120, 30);
			ipLabel = createLabel("ip", 0, 90);
			ipInput = createInput("127.0.0.1", 120, 90);
			portLabel = createLabel("port", 0, 120);
			portInput = createInput("8003", 120, 120);
			enterBtn = createBtn(L.T("进入游戏"), 0, 150, __enterBtn);
		}
		
		private function __enterBtn(e:MouseEvent):void
		{
			Game.login.info.account = usernameInput.content;
			Game.login.info.srvIP = ipInput.content;
			Game.login.info.srvPort = parseInt(portInput.content);
			Centre.NET.connect(Game.login.info.srvIP, Game.login.info.srvPort);
		}
		
		public function alert(msg:String):void
		{
			alertLabel.uiLabel = msg;
		}
		
	}
}