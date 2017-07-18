package ui.view.heroAttri
{
	import central.Game;
	
	import cfg.VocCfg;
	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	
	import comm.struct.player.StAttributes;
	
	import comm.define.SexType;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import ui.view.BaseFrame;
	import ui.view.ViewWnd;
	
	public class HeroAttriFrame extends ViewWnd
	{
		private var closeBtn:JPushButton;
		private var playerNameLabel:JLabel;
		private var vocLabel:JLabel;
		private var sexLabel:JLabel;
		private var levLabel:JLabel;
		private var hpLabel:JLabel;
		private var mpLabel:JLabel;
		private var moveSpeedLabel:JLabel;
		private var attackLabel:JLabel;
		private var attackSpeedLabel:JLabel;
		private var armorLabel:JLabel;
		private var armorPeneLabel:JLabel;
		private var spellPowerLabel:JLabel;
		private var spellImmunityLabel:JLabel;
		private var spellPeneLabel:JLabel;
		
		/** 主角属性窗体 */
		public function HeroAttriFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("hero_attri_pane");
			pane = uiPack.getCtrl("root");
			closeBtn = uiPack.getPushButton("closeBtn");
			playerNameLabel = uiPack.getLabel("playerNameLabel");
			vocLabel = uiPack.getLabel("vocLabel");
			sexLabel = uiPack.getLabel("sexLabel");
			levLabel = uiPack.getLabel("levLabel");
			hpLabel = uiPack.getLabel("hpLabel");
			mpLabel = uiPack.getLabel("mpLabel");
			moveSpeedLabel = uiPack.getLabel("moveSpeedLabel");
			attackLabel = uiPack.getLabel("attackLabel");
			attackSpeedLabel = uiPack.getLabel("attackSpeedLabel");
			armorLabel = uiPack.getLabel("armorLabel");
			armorPeneLabel = uiPack.getLabel("armorPeneLabel");
			spellPowerLabel = uiPack.getLabel("spellPowerLabel");
			spellImmunityLabel = uiPack.getLabel("spellImmunityLabel");
			spellPeneLabel = uiPack.getLabel("spellPeneLabel");
			canDrag(true);
			canBringTop(true);
			
			pane.addEventListener(MouseEvent.CLICK, __paneClick);
		}
		
		private function __paneClick(e:MouseEvent):void
		{
			switch(e.target)
			{
			case closeBtn:
				hide();
				break;
			}
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
		/** heroInit */
		public function heroInit():void
		{
			updateBaseInfo();
			updateAttris();
		}
		
		/** 更新基础信息 */
		public function updateBaseInfo():void
		{
			playerNameLabel.text = Game.hero.name;
			vocLabel.text = VocCfg.getVocName(Game.hero.voc);
			sexLabel.text = SexType.Str(Game.hero.sex);
			levLabel.text = Game.hero.level.toString();
		}
		
		/** 更新属性
		 * @param type:String Attributes.TYPE_XXX */
		public function updateAttri(type:String):void
		{
			switch(type)
			{
			case StAttributes.TYPE_CUR_HP:
			case StAttributes.TYPE_HP:
				hpLabel.text = Game.hero.attris.curHp() + " / " + Game.hero.attris.hp();
				break;
			case StAttributes.TYPE_CUR_MP:
			case StAttributes.TYPE_MP:
				mpLabel.text = Game.hero.attris.curMp() + " / " + Game.hero.attris.mp();
				break;
			case StAttributes.TYPE_MOVE_SPEED:
				moveSpeedLabel.text = "" + Game.hero.attris.moveSpeed();
				break;
			case StAttributes.TYPE_ATTACK:
				attackLabel.text = "" + Game.hero.attris.attack();
				break;
			case StAttributes.TYPE_ATTACK_SPEED:
				attackSpeedLabel.text = "" + Game.hero.attris.attackSpeed().toFixed(3);
				break;
			case StAttributes.TYPE_ARMOR:
				armorLabel.text = "" + Game.hero.attris.armor();
				break;
			case StAttributes.TYPE_ARMOR_PENE:
				armorPeneLabel.text = "" + Game.hero.attris.armorPene();
				break;
			case StAttributes.TYPE_SPELL_POWER:
				spellPowerLabel.text = "" + Game.hero.attris.spellPower();
				break;
			case StAttributes.TYPE_SPELL_IMMUN:
				spellImmunityLabel.text = "" + Game.hero.attris.spellImmun();
				break;
			case StAttributes.TYPE_SPELL_PENE:
				spellPeneLabel.text = "" + Game.hero.attris.spellPene();
				break;
			}
		}
		
		/** 更新所有属性 */
		public function updateAttris():void
		{
			updateAttri(StAttributes.TYPE_HP);
			updateAttri(StAttributes.TYPE_MP);
			updateAttri(StAttributes.TYPE_MOVE_SPEED);
			updateAttri(StAttributes.TYPE_ATTACK);
			updateAttri(StAttributes.TYPE_ATTACK_SPEED);
			updateAttri(StAttributes.TYPE_ARMOR);
			updateAttri(StAttributes.TYPE_ARMOR_PENE);
			updateAttri(StAttributes.TYPE_SPELL_POWER);
			updateAttri(StAttributes.TYPE_SPELL_IMMUN);
			updateAttri(StAttributes.TYPE_SPELL_PENE);
		}
		
	}
}