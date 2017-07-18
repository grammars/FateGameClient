package view
{
	import controller.MainCtrl;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import model.WorkConfig;
	
	import org.aswing.BorderLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.event.AWEvent;

	public class OpenStdMapWnd
	{
		private static var _me:OpenStdMapWnd;
		public static function me():OpenStdMapWnd
		{
			if(_me == null) { _me = new OpenStdMapWnd(); }
			return _me;
		}
		
		private var frame:JFrame;
		
		private const WND_W:int = 330;
		private const WND_H:int = 220;
		
		private var browseBtn:JButton;
		
		private var dir:File;
		
		public function OpenStdMapWnd()
		{
			dir = new File();
			dir.addEventListener(Event.SELECT, __dirSelect);
			frame = new JFrame(Global.getMainFrm(), "打开标准地图", true);
			frame.setSizeWH(WND_W, WND_H);
			frame.setResizable(false);
			var label:JLabel = new JLabel("在切换一个工作空间之前，确保您已保存你的工作内容！");
			frame.getContentPane().append(label, BorderLayout.CENTER);
			browseBtn = new JButton("浏览本地磁盘打开地图文件夹");
			browseBtn.setPreferredHeight(80);
			frame.getContentPane().append(browseBtn, BorderLayout.SOUTH);
			browseBtn.addActionListener(__browseBtnFired);
		}
		
		public function open():void
		{
			var posX:int = Global.getMainFrm().getX() + (Global.getMainFrm().getWidth() - WND_W) / 2;
			var posY:int = Global.getMainFrm().getY() + (Global.getMainFrm().getHeight() - WND_H) / 2;
			frame.setLocationXY(posX, posY);
			frame.show();
		}
		
		public function close():void
		{
			frame.hide();
		}
		
		private function __browseBtnFired(e:AWEvent):void
		{
			dir.browseForDirectory("选择地图空间");
		}
		
		private function __dirSelect(e:Event):void
		{
			MainCtrl.me().clearWorkSpace();
			close();
			WorkConfig.me().setMapSpaceDir(dir.nativePath);
			MainCtrl.me().loadWorkSpace();
		}
		
	}
}