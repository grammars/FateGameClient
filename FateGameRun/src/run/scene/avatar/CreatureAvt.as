package run.scene.avatar
{
	import central.Centre;
	import central.Game;
	
	import cfg.VocCfg;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.player.AttriSet;
	import comm.component.skill.SkillSet;
	import comm.define.SexType;
	import comm.effects.EffectFilters;
	import comm.struct.skill.StSkillSet;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarRule;
	import gamekit.map.MapFacade;
	
	import comm.component.buff.BuffSet;
	
	import test.ctrls.GameConsole;
	
	import ui.view.topTar.TopTarPane;

	public class CreatureAvt extends SpriteAvt
	{
		public function getAlive():Boolean { return creatureVO.alive; }
		public function getName():String { return creatureVO.name; }
		
		protected var namePart:AvtNamePart;
		protected var barPart:AvtBarPart;
		
		public function CreatureAvt()
		{
			super();
		}
		
		/** 构造部件 */
		override protected function createParts():void
		{
			super.createParts();
			
			usePreAvatar = true;
			
			namePart = new AvtNamePart();
			namePart.x = -int(AvtNamePart.W/2);
			namePart.y = 0;
			addChild(namePart);
			
			barPart = new AvtBarPart();
			barPart.x = -int(AvtBarPart.W/2);
			barPart.y = 20;
			addChild(barPart);
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
			updateName();
			updateAttri();
		}
		
		/** 更新名字 */
		public function updateName():void
		{
			namePart.changeName(creatureVO.name);
		}
		
		/** 更新HpMp条 */
		public function updateBar():void
		{
			barPart.curHp = creatureVO.attris.curHp();
			barPart.maxHp = creatureVO.attris.hp();
			barPart.curMp = creatureVO.attris.curMp();
			barPart.maxMp = creatureVO.attris.mp();
			barPart.repaint();
		}
		
		/** 更新生物属性 */
		public function updateAttri():void
		{
			updateBar();
			
			this.setSpeed(creatureVO.attris.moveSpeed());
			
			var runTime:int = AvatarRule.getStdPlayTimeByAction(ActionType.RUN) * AvatarRule.BASE_MOVE_SPEED / creatureVO.attris.moveSpeed();
			this.actionSpeed.setActionTime(ActionType.RUN, runTime);
			
			var hitTime:int = AvatarRule.getStdPlayTimeByAction(ActionType.HIT);
			if(creatureVO.attris.attackSpeed() > AvatarRule.BASE_HIT_SPEED)
			{
				hitTime = AvatarRule.getStdPlayTimeByAction(ActionType.HIT) * AvatarRule.BASE_HIT_SPEED / creatureVO.attris.attackSpeed();
			}
			this.actionSpeed.setActionTime(ActionType.HIT, hitTime);
		}
		
		/** 实体被点到了，排除了透明部分 */
		override public function clickHandler(e:MouseEvent):void
		{
			super.clickHandler(e);
			
			if( Game.scene.getSltTar() == this )
			{
				heroDo();
			}
			
			Game.scene.setSltTar(this);
		}
		
		/** 主角对此物作出的行为 */
		public function heroDo():void
		{
			Game.scene.hero.towards(this);
		}
		
		/** 死亡处理 */
		public function dead():void
		{
			creatureVO.alive = false;
			this.playAction(ActionType.DIE);
		}
		
	}
}