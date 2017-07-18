package view
{
	import org.aswing.BoxLayout;
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;

	public class AlertWnd
	{
		private static var _me:AlertWnd;
		public static function me():AlertWnd
		{
			if(_me == null) { _me = new AlertWnd(); }
			return _me;
		}
		
		private var frame:JFrame;
		private var infoLabel:JLabel;
		private var cmdBtn:JButton;
		
		private const WND_W:int = 300;
		private const WND_H:int = 160;
		
		public function AlertWnd()
		{
			frame = new JFrame(null, "通知", true);
			frame.getContentPane().setLayout(new EmptyLayout());
			infoLabel = new JLabel("信息");
			infoLabel.setBounds(new IntRectangle(0, 0, 290, 70));
			frame.getContentPane().append(infoLabel);
			cmdBtn = new JButton("确 定");
			cmdBtn.setBounds(new IntRectangle(105, 70, 80, 30));
			frame.getContentPane().append(cmdBtn);
			cmdBtn.addActionListener(__cmdBtnFired);
		}
		
		public function show(msg:String=null):void
		{
			if(msg != null) { infoLabel.setText(msg); }
			frame.setSizeWH(WND_W, WND_H);
			var posX:int = (Global.getStage().stageWidth-WND_W)/2;
			var posY:int = (Global.getStage().stageHeight-WND_H)/2;
			frame.setLocationXY(posX, posY);
			frame.show();
		}
		
		public function hide():void
		{
			frame.hide();
		}
		
		private function __cmdBtnFired(e:AWEvent):void
		{
			hide();
		}
		
	}
}