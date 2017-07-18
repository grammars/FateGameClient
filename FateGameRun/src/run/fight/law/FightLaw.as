package run.fight.law
{
	import central.Game;
	
	import cfg.SkillCfg;
	import cfg.SkillEffCfg;
	
	import comm.component.skill.SkillItem;
	import comm.define.PkModeType;
	import comm.define.SpriteType;
	
	import run.scene.avatar.CreatureAvt;

	public class FightLaw
	{
		public function FightLaw()
		{
		}
		
		/** 判定:关系 是否可以进行此次普通攻击 */
		public static function hitRelationAvailable(target:CreatureAvt):Boolean
		{
			var tarType:int = target.creatureVO.type;
			if(tarType == SpriteType.NPC) { return false; }
			if(tarType == SpriteType.PLAYER)
			{
				if(Game.hero.pkMode == PkModeType.PEACE)
				{
					Game.info.notice("你处于和平模式，不可以主动发起攻击！");
					return false;
				}
				if(target.playerVO.pkMode == PkModeType.PEACE) 
				{
					Game.info.notice("对方处于和平模式，不可以攻击他！");
					return false;
				}
			}
			return true;
		}
		
		/** 判定:关系 是否可以进行此次技能使用 */
		public static function skillRelationAvailable(target:CreatureAvt, si:SkillItem):Boolean
		{
			//si.config.effs[0].
			//	SkillEffCfg.
			return true;
		}
		
	}
}