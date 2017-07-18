package run.fight
{
	import central.Centre;
	import central.Game;
	import central.View;
	
	import comm.L;
	import comm.component.skill.SkillItem;
	import comm.define.PkModeType;
	import comm.define.SpriteType;
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarRule;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.avatar.material.AvatarType;
	import gamekit.layer.Layer;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.utils.GeomUtils;
	import gamekit.utils.Utils;
	
	import net.msg.fight.FightMsg;
	
	import run.AbstractRunHandler;
	import run.fight.aim.AimSkillHandler;
	import run.fight.aoe.AoeSkillHandler;
	import run.fight.normal.NormalHitHandler;
	import run.fight.path.PathSkillHandler;
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.SpriteAvt;
	import run.scene.avatar.action.FightFollow;
	
	import ui.view.heroCorner.HeroCornerPane;
	
	/** 战斗相关 */
	public class FightRun extends AbstractRunHandler
	{
		public var hit:NormalHitHandler = new NormalHitHandler();
		public var aim:AimSkillHandler = new AimSkillHandler();
		public var aoe:AoeSkillHandler = new AoeSkillHandler();
		public var path:PathSkillHandler = new PathSkillHandler();
		
		private var pkMode:int = PkModeType.PEACE;
		/** set PK模式 */
		public function setPkMode(value:int):void
		{
			this.pkMode = value;
			View.heroCornerPane.setPkMode(this.pkMode);
		}
		/** get PK模式 */
		public function getPkMode():int { return this.pkMode; }
		
		private var visit:MonsterVisit = new MonsterVisit();
		
		public function FightRun()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			super.startup();
			hit.setup();
			aim.setup();
			aoe.setup();
			path.setup();
		}
		
		/** 普通攻击 */
		public function tryHit():Boolean
		{
			return hit.tryHit();
		}
		
		/** 施放(瞬时必中技能) */
		public function skillAim(si:SkillItem):Boolean
		{
			return aim.useSkill(si);
		}
		
		/** 施放(非瞬时AOE技能) */
		public function skillAoe(si:SkillItem):Boolean
		{
			return aoe.useSkill(si);
		}
		
		/** 施放(非瞬时轨迹技能) */
		public function skillPath(si:SkillItem):Boolean
		{
			return path.useSkill(si);
		}
		
		/** 访问怪物 */
		public function visitMonster(monsterId:int):void
		{
			visit.visit(monsterId);
		}
		
		/** 取消访问怪物 */
		private function cancelVisitMonster():void
		{
			visit.cancel();
		}
		
	}
}