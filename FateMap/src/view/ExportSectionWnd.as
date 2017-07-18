package view
{
	import controller.MapPicCtrl;
	
	import model.WorkConfig;
	
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JSlider;
	import org.aswing.JTextField;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntRectangle;

	public class ExportSectionWnd
	{
		private static var _me:ExportSectionWnd;
		public static function me():ExportSectionWnd
		{
			if(_me == null) { _me = new ExportSectionWnd(); }
			return _me;
		}
		
		private var frame:JFrame;
		
		private const WND_W:int = 210;
		private const WND_H:int = 210;
		
		private var tileWInput:JTextField;
		private var tileHInput:JTextField;
		private var qualityLabel:JLabel;
		private var qualitySlider:JSlider;
		private var cmdBtn:JButton;
		
		private var quality:int = 80;
		
		public function ExportSectionWnd()
		{
			frame = new JFrame(Global.getMainFrm(), "导出切片", true);
			frame.setSizeWH(WND_W, WND_H);
			frame.setResizable(false);
			var content:JPanel = new JPanel();
			//content.setBorder(new LineBorder(null, ASColor.RED, 1));
			content.setLayout(new EmptyLayout());
			frame.getContentPane().append(content);
			
			var tileWLabel:JLabel = new JLabel("切片宽:");
			tileWLabel.setBounds(new IntRectangle(0, 10, 80, 24));
			content.append(tileWLabel);
			
			var tileHLabel:JLabel = new JLabel("切片宽:");
			tileHLabel.setBounds(new IntRectangle(0, 40, 80, 24));
			content.append(tileHLabel);
			
			tileWInput = new JTextField("320", 3);
			tileWInput.setBounds(new IntRectangle(90, 10, 80, 24));
			content.append(tileWInput);
			
			tileHInput = new JTextField("240", 3);
			tileHInput.setBounds(new IntRectangle(90, 40, 80, 24));
			content.append(tileHInput);
			
			qualityLabel = new JLabel("图像质量：80");
			qualityLabel.setBounds(new IntRectangle(5, 70, 100, 24));
			content.append(qualityLabel);
			
			qualitySlider = new JSlider(JSlider.HORIZONTAL, 0, 100, 80);
			qualitySlider.setBounds(new IntRectangle(20, 100, 100, 24));
			content.append(qualitySlider);
			qualitySlider.addStateListener(__qualityChange);
			
			cmdBtn = new JButton("执行");
			cmdBtn.setBounds(new IntRectangle(20, 130, 100, 24));
			content.append(cmdBtn);
			cmdBtn.addActionListener(__cmdBtnFired);
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
		
		private function __cmdBtnFired(e:AWEvent):void
		{
			var sw:int = parseInt(tileWInput.getText());
			var sh:int = parseInt(tileHInput.getText());
			if(sw <= 8 || sh <= 8)
			{
				AlertWnd.me().show("切片宽高不应该小于8像素");
			}
			else
			{
				WorkConfig.me().setTileW(sw);
				WorkConfig.me().setTileH(sh);
				
				close();
				MapPicCtrl.me().exportSection(sw, sh, quality);
			}
		}
		
		private function __qualityChange(e:InteractiveEvent):void
		{
			quality = qualitySlider.getValue();
			qualityLabel.setText("图像质量：" + quality);
		}
	}
}