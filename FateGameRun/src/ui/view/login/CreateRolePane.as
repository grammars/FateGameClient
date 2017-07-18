package ui.view.login
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JRadioButton;
	
	import comm.L;
	
	import comm.define.SexType;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import net.msg.login.LoginMsg;
	
	import ui.TmpPane;
	import ui.ctrls.Ape;
	import ui.ctrls.Button;
	import ui.ctrls.LayoutStyle;
	import ui.ctrls.NormalInput;
	import ui.ctrls.StrokeLabel;
	
	public class CreateRolePane extends TmpPane
	{
		private var alertLabel:StrokeLabel;
		private var nameLabel:StrokeLabel;
		private var nameInput:NormalInput;
		private var createRoleBtn:Button;
		
		private var sexLabel:StrokeLabel;
		private var sexBoy:JRadioButton
		private var sexGirl:JRadioButton;
		
		public function CreateRolePane()
		{
			super();
			
			canvas = new Ape(290, 200);
			canvas.uiBgBitmap = new BitmapData(2, 2, true, 0x77dedede);
			canvas.drawRect();
			this.addChild(canvas);
			
			alertLabel = createLabel(L.T("创建角色"), 0, 0, 270);
			nameLabel = createLabel(L.T("角色名"), 0, 30, 70);
			nameInput = createInput(L.T("剑侠客"), 80, 30, 190);
			
			sexLabel = createLabel(L.T("性别:"), 0, 60, 70);
			sexBoy = new JRadioButton(L.T("男"), L.T("【男】"));
			sexGirl = new JRadioButton(L.T("女"), L.T("【女】"));
			var sexGroup:JRadioGroup = new JRadioGroup();
			sexGroup.add(sexBoy);
			sexGroup.add(sexGirl);
			sexBoy.x = 100+MARGIN_X;
			sexBoy.y = 60+MARGIN_Y;
			canvas.addChild(sexBoy);
			sexGirl.x = 140+MARGIN_X;
			sexGirl.y = 60+MARGIN_Y;
			canvas.addChild(sexGirl);
			sexBoy.selected = true;
			
			
			createRoleBtn = createBtn(L.T("创建"), 0, 150, __createRoleBtn);
		}
		
		
		private function __createRoleBtn(e:MouseEvent):void
		{
			var roleName:String = nameInput.content;
			if(roleName.length > 10)
			{
				alert(L.T("角色名长度不能大于10个字"));
			}
			else
			{
				alert("");
				var sex:int = SexType.NULL;
				if(sexBoy.selected)
				{
					sex = SexType.BOY;
				}
				else if(sexGirl.selected)
				{
					sex = SexType.GIRL;
				}
				LoginMsg.getInstance().sendPlayerCreateReq_C2L(Game.login.info.account, roleName, sex);
			}
		}
		
		public function alert(str:String):void
		{
			alertLabel.uiLabel = str;
		}
		
	}
}