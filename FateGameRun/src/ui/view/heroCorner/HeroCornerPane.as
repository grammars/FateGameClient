package ui.view.heroCorner
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JImage;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.skin.JComboBoxSkin;
	
	import comm.component.buff.Buff;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import gamekit.layer.Layer;
	
	import net.msg.fight.FightMsg;
	
	import test.ctrls.GameConsole;
	
	import ui.skin.comboBox.DefaultComboBoxSkin;
	import ui.view.IBasePane;
	import ui.view.ViewWnd;
	import ui.view.buff.BuffBar;
	
	public class HeroCornerPane extends ViewWnd
	{
		/** StPkMode[] */
		private var pkOptions:Array = StPkMode.options();
		
		private var hpLine:JImage;
		private var mpLine:JImage;
		private var expLine:JImage;
		private var cover:JImage;
		private var nameLabel:JLabel;
		private var pkModeCombo:JComboBox;
		
		/** Buff组信息条 */
		private var buffBar:BuffBar = new BuffBar(4);
		
		public function HeroCornerPane()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("hero_cornor");
			pane = uiPack.getCtrl("root");
			hpLine = uiPack.getImage("hpLine");
			mpLine = uiPack.getImage("mpLine");
			expLine = uiPack.getImage("expLine");
			cover = uiPack.getImage("cover");
			nameLabel = uiPack.getLabel("nameLabel");
			pkModeCombo = uiPack.getComboBox("pkModeCombo");
			
			pkModeCombo.items = pkOptions;
			pkModeCombo.addEventListener(Event.SELECT, __pkModeChange);
			buffBar.move(94, 80);
			pane.addChild(buffBar);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = 0;
				pane.y = 0;
			}
		}
		
		/** PK模式切换 */
		private function __pkModeChange(e:Event):void
		{
			var pkm:StPkMode = pkModeCombo.selectedItem as StPkMode;
			//GameConsole.getInstance().log(pkm.label, true);
			FightMsg.getInstance().sendChangePkModeReq_C2G(pkm.type);
		}
		
		/** 设置PK模式 */
		public function setPkMode(mode:int):void
		{
			if(mode >= 0 && mode < pkOptions.length)
			{
				GameConsole.getInstance().log("pk="+pkOptions[mode].label, true);
				pkModeCombo.changeSelectedItem(pkOptions[mode], false);
			}
		}
		
		/** heroInit */
		public function heroInit():void
		{
			initBuff();
		}
		
		/** 初始化buff */
		private function initBuff():void
		{
			var list:Vector.<Buff> = Game.hero.buffs.getBuffs();
			for(var i:int = 0; i < list.length; i++)
			{
				var buff:Buff = list[i];
				buffBar.addBuff(buff);
			}
		}
		
		/** 添加buff */
		public function addBuff(buff:Buff):void
		{
			buffBar.addBuff(buff);
		}
		
		/** 移除buff */
		public function removeBuff(buffId:int):void
		{
			buffBar.removeBuff(buffId);
		}
		
	}
}