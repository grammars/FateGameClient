package ui.view.debug
{
	import central.Game;
	import central.View;
	
	import com.anstu.jsock.utils.Long;
	import com.anstu.jui.JUIDemo;
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JImage;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	
	import comm.component.player.AttriSet;
	import comm.struct.cd.StCDInfo;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	
	import net.msg.IMessage;
	import net.msg.fight.FightMsg;
	import net.msg.gm.GmMsg;
	import net.msg.practice.PracticeMsg;
	
	import res.Res;
	
	import run.action.test.*;
	import run.scene.avatar.action.Traveller;
	
	import ui.parts.CDRender;
	import ui.skin.comboBox.DefaultComboBoxSkin;
	import ui.skin.font.DefaultFont;
	import ui.skin.pushButton.CommOrangeBtnSkin;
	import ui.skin.pushButton.PaneCloseBtnSkin;
	import ui.view.BaseFrame;
	import ui.view.debug.params.GmFightPC;
	import ui.view.debug.params.GmGoodsPC;
	import ui.view.debug.params.GmOthersPC;
	import ui.view.debug.params.GmPlayerPC;
	import ui.view.debug.params.GmTaskPC;
	
	public class GmFrame extends BaseFrame
	{
		private static var _instance:GmFrame;
		public static function get instance():GmFrame
		{
			if(_instance == null) { _instance = new GmFrame(); }
			return _instance;
		}
		
		public var mainCmdIdLabel:JLabel;
		public var mainCmdIdInput:JInputText;
		public var subCmdIdLabel:JLabel;
		public var subCmdIdInput:JInputText;
		public var byte0Label:JLabel;
		public var byte0Input:JInputText;
		public var byte1Label:JLabel;
		public var byte1Input:JInputText;
		public var int0Label:JLabel;
		public var int0Input:JInputText;
		public var int1Label:JLabel;
		public var int1Input:JInputText;
		public var int2Label:JLabel;
		public var int2Input:JInputText;
		public var float0Label:JLabel;
		public var float0Input:JInputText;
		public var double0Label:JLabel;
		public var double0Input:JInputText;
		public var long0Label:JLabel;
		public var long0Input:JInputText;
		public var long1Label:JLabel;
		public var long1Input:JInputText;
		public var str0Label:JLabel;
		public var str0Input:JInputText;
		public var str1Label:JLabel;
		public var str1Input:JInputText;
		
		public var paramCmdBtn:JPushButton;
		
		public function GmFrame()
		{
			super();
			this.layer = Layer.alert;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.setSize(600, 530);
			this.setTitle("GM控制台");
			
			const LABEL_X:int = 10;
			const INPUT_X:int = 90;
			var OFY:int = 10;
			
			mainCmdIdLabel = createLabel("mainCmdId=", LABEL_X, OFY);
			mainCmdIdInput = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			subCmdIdLabel = createLabel("subCmdId=", LABEL_X, OFY);
			subCmdIdInput = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			byte0Label = createLabel("byte0=", LABEL_X, OFY);
			byte0Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			byte1Label = createLabel("byte1=", LABEL_X, OFY);
			byte1Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			int0Label = createLabel("int0=", LABEL_X, OFY);
			int0Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			int1Label = createLabel("int1=", LABEL_X, OFY);
			int1Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			int2Label = createLabel("int2=", LABEL_X, OFY);
			int2Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			float0Label = createLabel("float0=", LABEL_X, OFY);
			float0Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			double0Label = createLabel("double0=", LABEL_X, OFY);
			double0Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			long0Label = createLabel("long0=", LABEL_X, OFY);
			long0Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			long1Label = createLabel("long1=", LABEL_X, OFY);
			long1Input = createInput("0", INPUT_X, OFY);
			OFY += 25;
			
			str0Label = createLabel("str0=", LABEL_X, OFY);
			str0Input = createInput("", INPUT_X, OFY);
			OFY += 25;
			
			str1Label = createLabel("str1=", LABEL_X, OFY);
			str1Input = createInput("", INPUT_X, OFY);
			OFY += 25;
			
			paramCmdBtn = new JPushButton("参数化GM命令", __paramCmdBtn);
			CommOrangeBtnSkin.instance.apply(paramCmdBtn);
			paramCmdBtn.setSize(180, 35);
			paramCmdBtn.move(LABEL_X, OFY);
			canvas.addChild(paramCmdBtn);
			
			var GPG_X:int = 200;
			var GPG_Y:int = 10;
			const gapH:int = 2;
			var gpg:GmParamGroup;
			
			gpg = new GmParamGroup("others", GmOthersPC.items());
			gpg.move(GPG_X, GPG_Y);
			canvas.addChild(gpg);
			GPG_Y += GmParamGroup.H+gapH;
			
			gpg = new GmParamGroup("player", GmPlayerPC.items());
			gpg.move(GPG_X, GPG_Y);
			canvas.addChild(gpg);
			GPG_Y += GmParamGroup.H+gapH;
			
			gpg = new GmParamGroup("fight", GmFightPC.items());
			gpg.move(GPG_X, GPG_Y);
			canvas.addChild(gpg);
			GPG_Y += GmParamGroup.H+gapH;
			
			gpg = new GmParamGroup("goods", GmGoodsPC.items());
			gpg.move(GPG_X, GPG_Y);
			canvas.addChild(gpg);
			GPG_Y += GmParamGroup.H+gapH;
			
			gpg = new GmParamGroup("task", GmTaskPC.items());
			gpg.move(GPG_X, GPG_Y);
			canvas.addChild(gpg);
			GPG_Y += GmParamGroup.H+gapH;
			
			setFastBtns();
			
			setFixBtns();
		}
		
		private function createLabel(text:String, px:int, py:int):JLabel
		{
			const W:int = 80;
			const H:int = 25;
			createItemBg(W, H, px, py);
			var label:JLabel = new JLabel(text);
			label.textFormat = DefaultFont.create();
			label.setSize(W, H);
			label.move(px, py);
			canvas.addChild(label);
			return label;
		}
		
		private function createInput(text:String, px:int, py:int):JInputText
		{
			const W:int = 100;
			const H:int = 25;
			createItemBg(W, H, px, py);
			var input:JInputText = new JInputText(text);
			input.textFormat = DefaultFont.create();
			input.setSize(W, H);
			input.move(px, py);
			canvas.addChild(input);
			return input;
		}
		
		private function createItemBg(w:int, h:int, px:int, py:int):JImage
		{
			var image:JImage = new JImage();
			JResource.fill(image.fillBackground, "bg_modern$png", Res.NS);
			image.setSize(w, h);
			image.move(px, py);
			canvas.addChild(image);
			return image;
		}
		
		private function createOrangeBtn(text:String, cb:Function, w:int, h:int, px:int, py:int):JPushButton
		{
			var fastBtn:JPushButton = new JPushButton(text, cb);
			fastBtn.setSize(w, h);
			fastBtn.move(px, py);
			CommOrangeBtnSkin.instance.apply(fastBtn);
			canvas.addChild(fastBtn);
			return fastBtn;
		}
		
		private function setFastBtns():void
		{
			const btnW:int = 180;
			const btnH:int = 30;
			createOrangeBtn("清理sprites", __fastBtn0, btnW, btnH, 10, 370);
			createOrangeBtn("提升修炼等级", __fastBtn1, btnW, btnH, 10, 400);
			createOrangeBtn("主角立刻停止移动", __fastBtn2, btnW, btnH, 10, 430);
		}
		
		private var cdr:CDRender = new CDRender();
		private function __fastBtn0(e:MouseEvent):void
		{
//			Layer.ui.putCentre(cdr);
//			var cdi:StCDInfo = new StCDInfo();
//			cdi.cdTime = 10000;
//			cdi.finishTime = new Date().time + 10000;
//			cdr.update(cdi);
			Game.scene.clearSprites();
		}
		
		private function __fastBtn1(e:MouseEvent):void
		{
			Game.action.pushAction(new KingAction());
			//PracticeMsg.getInstance().sendLevelUpReq_C2G();
			//Game.scene.hero.changeSelfLook("3004");
		}
		
		private function __fastBtn2(e:MouseEvent):void
		{
			//DebugFast.heroMoveStopRightNow();
			//Game.scene.hero.changeSelfLook("4004");
		}
		
		private function setFixBtns():void
		{
			const btnW:int = 115;
			const btnH:int = 35;
			createOrangeBtn("动作调试器", __actionDebugger, btnW, btnH, 455, 10);
			createOrangeBtn("UI展示", __uiDemo, btnW, btnH, 455, 50);
			createOrangeBtn("寻路到", __travel, btnW, btnH, 455, 90);
		}
		
		private function __actionDebugger(e:MouseEvent):void
		{
			ActionDebugger.instance.showOrHide();
		}
		
		private function __uiDemo(e:MouseEvent):void
		{
			if(JUIDemo.instance.parent)
			{
				JUIDemo.instance.parent.removeChild(JUIDemo.instance);
			}
			else
			{
				Layer.alert.addChild(JUIDemo.instance);
			}
		}
		
		private function __travel(e:MouseEvent):void
		{
			Traveller.getInstance().execute(1004, 14, 31);	
		}
		
		private function __paramCmdBtn(e:MouseEvent):void
		{
			var cmd:GmParamCmd = new GmParamCmd();
			cmd.mainCmdId = parseInt(mainCmdIdInput.text);
			cmd.subCmdId = parseInt(subCmdIdInput.text);
			
			cmd.byte0Input = byte0Input.text;
			cmd.byte1Input = byte1Input.text;
			cmd.int0Input = int0Input.text;
			cmd.int1Input = int1Input.text;
			cmd.int2Input = int2Input.text;
			cmd.float0Input = float0Input.text;
			cmd.double0Input = double0Input.text;
			cmd.long0Input = long0Input.text;
			cmd.long1Input = long1Input.text;
			cmd.str0Input = str0Input.text;
			cmd.str1Input = str1Input.text;
			
			GmMsg.getInstance().sendParamsCmd_C2G(cmd);
		}
		
	}
}