package view
{
	import model.WorkConfig;
	
	import org.aswing.BoxLayout;
	import org.aswing.JButton;
	import org.aswing.JCheckBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JSlider;
	import org.aswing.JTextField;
	import org.aswing.SoftBoxLayout;
	import org.aswing.border.TitledBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;

	public class SidePanel
	{
		private static var _me:SidePanel;
		public static function me():SidePanel
		{
			if(_me == null) { _me = new SidePanel(); }
			return _me;
		}
		
		private var root:JPanel;
		public function getRootPane():JPanel { return root; }
		
		private var blockBrushCheck:JCheckBox;
		private var maskBrushCheck:JCheckBox;
		private var stallBrushCheck:JCheckBox;
		private var deliverBrushCheck:JCheckBox;
		private var deliverInput:JTextField;
		private var numTagBrushCheck:JCheckBox;
		private var numTagInput:JTextField;
		
		private var brushSizeSlider:JSlider;
		private var brushSizeLabel:JLabel;
		
		private var drawAlphaSlider:JSlider;
		private var drawAlphaLabel:JLabel;
		
		public function SidePanel()
		{
			root = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 10));
			var brushPane:JPanel = new JPanel(new BoxLayout(BoxLayout.Y_AXIS, 10));
			brushPane.setBorder(new TitledBorder(null, "刷子", 1, 0, 0, 3));
			
			blockBrushCheck = new JCheckBox("阻碍点笔刷");
			brushPane.append(blockBrushCheck);
			
			maskBrushCheck = new JCheckBox("遮罩点笔刷");
			brushPane.append(maskBrushCheck);
			
			stallBrushCheck = new JCheckBox("摆摊点笔刷");
			brushPane.append(stallBrushCheck);
			
			var deliverBox:JPanel = new JPanel();
			deliverBrushCheck = new JCheckBox("传送点笔刷");
			deliverBox.append(deliverBrushCheck);
			deliverInput = new JTextField("0", 5);
			deliverBox.append(deliverInput);
			brushPane.append(deliverBox);
			
			var numTagBox:JPanel = new JPanel();
			numTagBrushCheck = new JCheckBox("数字标识笔刷");
			numTagBox.append(numTagBrushCheck);
			numTagInput = new JTextField("0", 5);
			numTagBox.append(numTagInput);
			brushPane.append(numTagBox);
			
			root.append(brushPane);
			
			var configPane:JPanel = new JPanel(new BoxLayout(BoxLayout.Y_AXIS, 10));
			configPane.setBorder(new TitledBorder(null, "设置", 1, 0, 0, 3));
			
			brushSizeLabel = new JLabel("笔刷大小:0");
			configPane.append(brushSizeLabel);
			brushSizeSlider = new JSlider(JSlider.HORIZONTAL, 0, 32, 0);
			brushSizeSlider.setToolTipText("笔刷大小");
			configPane.append(brushSizeSlider);
			brushSizeSlider.addStateListener(__brushSizeChange);
			
			drawAlphaLabel = new JLabel("绘制透明度:默认");
			configPane.append(drawAlphaLabel);
			drawAlphaSlider = new JSlider(JSlider.HORIZONTAL, 0, 100, 60);
			configPane.append(drawAlphaSlider);
			drawAlphaSlider.addStateListener(__drawAlphaChange);
			
			root.append(configPane);
			
			var operPane:JPanel = new JPanel(new BoxLayout(BoxLayout.Y_AXIS, 10));
			operPane.setBorder(new TitledBorder(null, "操作", 1, 0, 0, 3));
			var paintBtn:JButton = new JButton("重绘");
			paintBtn.addActionListener(__paintBtnFired);
			operPane.append(paintBtn);
			root.append(operPane);
			
			blockBrushCheck.addActionListener(__brushChecked);
			maskBrushCheck.addActionListener(__brushChecked);
			stallBrushCheck.addActionListener(__brushChecked);
			deliverBrushCheck.addActionListener(__brushChecked);
			deliverInput.addEventListener(AWEvent.FOCUS_LOST, __inputDone);
			numTagBrushCheck.addActionListener(__brushChecked);
			numTagInput.addEventListener(AWEvent.FOCUS_LOST, __inputDone);
		}
		
		private function __brushChecked(e:AWEvent):void
		{
			WorkConfig.me().IS_BLOCK_BRUSH = blockBrushCheck.getModel().isSelected();
			WorkConfig.me().IS_MASK_BRUSH = maskBrushCheck.getModel().isSelected();
			WorkConfig.me().IS_STALL_BRUSH = stallBrushCheck.getModel().isSelected();
			WorkConfig.me().IS_DELIVER_BRUSH = deliverBrushCheck.getModel().isSelected();
			WorkConfig.me().IS_NUM_TAG_BRUSH = numTagBrushCheck.getModel().isSelected();
		}
		
		private function __inputDone(e:AWEvent):void
		{
			WorkConfig.me().DELIVER_BRUSH_VAL = parseInt(deliverInput.getText());
			WorkConfig.me().NUM_TAG_BRUSH_VAL = parseInt(numTagInput.getText());
		}
		
		private function __brushSizeChange(e:InteractiveEvent):void
		{
			WorkConfig.me().BRUSH_SIZE = brushSizeSlider.getValue();
			brushSizeLabel.setText("笔刷大小:"+brushSizeSlider.getValue());
		}
		
		private function __drawAlphaChange(e:InteractiveEvent):void
		{
			WorkConfig.me().DRAW_ALPHA = drawAlphaSlider.getValue()/100;
			drawAlphaLabel.setText("绘制透明度:"+drawAlphaSlider.getValue());
			CanvasPanel.me().paint();
		}
		
		private function __paintBtnFired(e:AWEvent):void
		{
			CanvasPanel.me().paint();
		}
		
	}
}