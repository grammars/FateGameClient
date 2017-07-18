package view
{
	import controller.MainCtrl;
	import controller.MapPicCtrl;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	
	import model.WorkConfig;
	
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.AsWingConstants;
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	import org.aswing.WindowLayout;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntRectangle;

	public class CreateStdMapWnd
	{
		private static var _me:CreateStdMapWnd;
		public static function me():CreateStdMapWnd
		{
			if(_me == null) { _me = new CreateStdMapWnd(); }
			return _me;
		}
		
		private var frame:JFrame;
		
		private const WND_W:int = 330;
		private const WND_H:int = 220;
		
		private var mapNameInput:JTextField;
		private var mapIdInput:JTextField;
		private var gridWInput:JTextField;
		private var gridHInput:JTextField;
		private var mapPicInput:JTextField;
		private var mapPicBtn:JButton;
		private var mapSpaceInput:JTextField;
		private var mapSpaceBtn:JButton;
		private var sureBtn:JButton;
		private var cancelBtn:JButton;
		
		public function CreateStdMapWnd()
		{
			frame = new JFrame(Global.getMainFrm(), "创建标准地图", true);
			frame.setSizeWH(WND_W, WND_H);
			frame.setResizable(false);
			var content:JPanel = new JPanel();
			//content.setBorder(new LineBorder(null, ASColor.RED, 1));
			content.setLayout(new EmptyLayout());
			frame.getContentPane().append(content);
			
			var mapNameLabel:JLabel = new JLabel("地图名字:");
			mapNameLabel.setBounds(new IntRectangle(0, 10, 80, 24));
			content.append(mapNameLabel);
			
			mapNameInput = new JTextField("新手村");
			mapNameInput.setBounds(new IntRectangle(90, 10, 190, 24));
			content.append(mapNameInput);
			
			var mapIdLabel:JLabel = new JLabel("地图ID:");
			mapIdLabel.setBounds(new IntRectangle(0, 40, 80, 24));
			content.append(mapIdLabel);
			
			mapIdInput = new JTextField("1001");
			mapIdInput.setBounds(new IntRectangle(90, 40, 190, 24));
			content.append(mapIdInput);
			
			var gridWLabel:JLabel = new JLabel("格子宽:");
			gridWLabel.setBounds(new IntRectangle(15, 70, 50, 24));
			content.append(gridWLabel);
			
			gridWInput = new JTextField("72");
			gridWInput.setBounds(new IntRectangle(90, 70, 60, 24));
			content.append(gridWInput);
			
			var gridHLabel:JLabel = new JLabel("格子高:");
			gridHLabel.setBounds(new IntRectangle(160, 70, 50, 24));
			content.append(gridHLabel);
			
			gridHInput = new JTextField("54");
			gridHInput.setBounds(new IntRectangle(220, 70, 60, 24));
			content.append(gridHInput);
			
			var mapPicLabel:JLabel = new JLabel("地图图片:");
			mapPicLabel.setBounds(new IntRectangle(0, 100, 80, 24));
			content.append(mapPicLabel);
			
			mapPicInput = new JTextField("大地图图片本地地址");
			mapPicInput.setBounds(new IntRectangle(90, 100, 190, 24));
			content.append(mapPicInput);
			
			mapPicBtn = new JButton("...");
			mapPicBtn.setBounds(new IntRectangle(282, 100, 24, 24));
			content.append(mapPicBtn);
			
			var mapSpaceLabel:JLabel = new JLabel("地图空间:");
			mapSpaceLabel.setBounds(new IntRectangle(0, 130, 80, 24));
			content.append(mapSpaceLabel);
			
			mapSpaceInput = new JTextField("地图编辑空间");
			mapSpaceInput.setBounds(new IntRectangle(90, 130, 190, 24));
			content.append(mapSpaceInput);
			
			mapSpaceBtn = new JButton("...");
			mapSpaceBtn.setBounds(new IntRectangle(282, 130, 24, 24));
			content.append(mapSpaceBtn);
			
			sureBtn = new JButton("确定");
			sureBtn.setBounds(new IntRectangle(90, 160, 50, 24));
			content.append(sureBtn);
			
			cancelBtn = new JButton("取消");
			cancelBtn.setBounds(new IntRectangle(180, 160, 50, 24));
			content.append(cancelBtn);
			
			mapPicBtn.addActionListener(__mapPicBtnFired);
			mapSpaceBtn.addActionListener(__mapSpaceBtnFired);
			sureBtn.addActionListener(__sureBtnFired);
			cancelBtn.addActionListener(__cancelBtnFired);
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
		
		private function __mapPicBtnFired(e:AWEvent):void
		{
			var f:File = new File();
			f.addEventListener(Event.SELECT, __mapPicAddrSelected);
			f.browse([new FileFilter("图片文件", "*.jpg;*.jpeg;*.png;*.gif")]);
		}
		
		private function __mapPicAddrSelected(e:Event):void
		{
			var f:File = e.target as File;
			WorkConfig.me().setMapPicAddr(f.nativePath);
			mapPicInput.setText(WorkConfig.me().getMapPicAddr());
		}
		
		private function __mapSpaceBtnFired(e:AWEvent):void
		{
			var f:File = new File();
			f.addEventListener(Event.SELECT, __mapSpaceAddrSelected);
			f.browseForDirectory("地图配置输出");
		}
		
		private function __mapSpaceAddrSelected(e:Event):void
		{
			var f:File = e.target as File;
			WorkConfig.me().setMapSpaceDir(f.nativePath);
			mapSpaceInput.setText(WorkConfig.me().getMapSpaceDir());
		}
		
		private function __sureBtnFired(e:AWEvent):void
		{
			MainCtrl.me().clearWorkSpace();
			//
			WorkConfig.me().setMapName(mapNameInput.getText());
			WorkConfig.me().setMapId(mapIdInput.getText());
			WorkConfig.me().setGridW(gridWInput.getText());
			WorkConfig.me().setGridH(gridHInput.getText());
			WorkConfig.me().setMapPicAddr(mapPicInput.getText());
			WorkConfig.me().setMapSpaceDir(mapSpaceInput.getText());
			mapNameInput.setText(WorkConfig.me().getMapName());
			mapIdInput.setText(WorkConfig.me().getMapId().toString());
			gridWInput.setText(WorkConfig.me().getGridW().toString());
			gridHInput.setText(WorkConfig.me().getGridH().toString());
			mapPicInput.setText(WorkConfig.me().getMapPicAddr());
			mapSpaceInput.setText(WorkConfig.me().getMapSpaceDir());
			if(WorkConfig.me().isLegal())
			{
				close();
				MainCtrl.me().saveWorkSpace();
				MapPicCtrl.me().loadMapPic();
			}
			else
			{
				AlertWnd.me().show("工作空间设置不合法");
			}
		}
		
		private function __cancelBtnFired(e:AWEvent):void
		{
			close();
		}
		
	}
}