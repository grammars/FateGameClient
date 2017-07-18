package ui.view.debug
{
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JTitle;
	import com.anstu.jui.define.JuiConst;
	
	import flash.events.Event;
	
	import ui.skin.comboBox.DefaultComboBoxSkin;
	import ui.skin.font.DefaultFont;
	import ui.skin.pane.GreyShadowPaneSkin;
	
	public class GmParamGroup extends JPanel
	{
		private var titleLabel:JTitle;
		private var operCombo:JComboBox;
		
		private static const MARGIN:int = 5;
		
		public static const W:int = 248;
		public static const H:int = 33;
		
		public function GmParamGroup(title:String, cmds:Array)
		{
			super();
			
			GreyShadowPaneSkin.instance.apply(this);
			this.setSize(W, H);
			
			titleLabel = new JTitle(title);
			titleLabel.textFormat = DefaultFont.create();
			titleLabel.setSize(100, 20);
			titleLabel.move(MARGIN, MARGIN);
			titleLabel.valign = JuiConst.UP;
			this.addChild(titleLabel);
			
			operCombo = new JComboBox("请选择命令", cmds);
			DefaultComboBoxSkin.instance.apply(operCombo);
			operCombo.width = 180;
			operCombo.move(60, MARGIN);
			this.addChild(operCombo);
			operCombo.addEventListener(Event.SELECT, __operComboSelect);
		}
		
		private function __operComboSelect(e:Event):void
		{
			var cmd:GmParamCmd = operCombo.selectedItem as GmParamCmd;
			
			GmFrame.instance.mainCmdIdInput.text = cmd.mainCmdId.toString();
			GmFrame.instance.subCmdIdInput.text = cmd.subCmdId.toString();
			
			GmFrame.instance.byte0Label.text = cmd.byte0Label;
			GmFrame.instance.byte1Label.text = cmd.byte1Label;
			GmFrame.instance.int0Label.text = cmd.int0Label;
			GmFrame.instance.int1Label.text = cmd.int1Label;
			GmFrame.instance.int2Label.text = cmd.int2Label;
			GmFrame.instance.float0Label.text = cmd.float0Label;
			GmFrame.instance.double0Label.text = cmd.double0Label;
			GmFrame.instance.long0Label.text = cmd.long0Label;
			GmFrame.instance.long1Label.text = cmd.long1Label;
			GmFrame.instance.str0Label.text = cmd.str0Label;
			GmFrame.instance.str1Label.text = cmd.str1Label;
			
			GmFrame.instance.byte0Input.text = cmd.byte0Input;
			GmFrame.instance.byte1Input.text = cmd.byte1Input;
			GmFrame.instance.int0Input.text = cmd.int0Input;
			GmFrame.instance.int1Input.text = cmd.int1Input;
			GmFrame.instance.int2Input.text = cmd.int2Input;
			GmFrame.instance.float0Input.text = cmd.float0Input;
			GmFrame.instance.double0Input.text = cmd.double0Input;
			GmFrame.instance.long0Input.text = cmd.long0Input;
			GmFrame.instance.long1Input.text = cmd.long1Input;
			GmFrame.instance.str0Input.text = cmd.str0Input;
			GmFrame.instance.str1Input.text = cmd.str1Input;
		}
		
	}
}