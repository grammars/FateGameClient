package run.fight.formula
{
	import central.Game;
	
	import cfg.SkillCfg;
	
	import comm.component.skill.SkillItem;

	public class SkillCostForm
	{
		/** 默认消耗 */
		private static const T_NULL:String = "null";
		/** 固定消耗 hp */
		private static const T_FIXED_4_HP:String = "fixed4hp";
		/** 固定消耗 mp */
		private static const T_FIXED_4_MP:String = "fixed4mp";
		/** 根据 人物等级 消耗 hp */
		private static const T_LEVEL_4_HP:String = "level4hp";
		/** 根据 人物等级 消耗 mp */
		private static const T_LEVEL_4_MP:String = "level4mp";
		/** 根据 人物等级 消耗 hp,mp */
		private static const T_LEVEL_4_HPMP:String = "level4hpmp";
		/** 根据 技能等级 消耗 hp */
		private static const T_SKLV_4_HP:String = "sklv4hp";
		/** 根据 技能等级 消耗 mp */
		private static const T_SKLV_4_MP:String = "sklv4mp";
		/** 根据 技能等级 消耗 hp,mp */
		private static const T_SKLV_4_HPMP:String = "sklv4hpmp";
		
		public function SkillCostForm()
		{
		}
		
		/** 消耗hp值 */
		public static function costHp(si:SkillItem):int
		{
			var c:SkillCfg = si.config;
			switch(c.costType)
			{
			case T_FIXED_4_HP:
				return c.costParams[0];
				break;
			case T_LEVEL_4_HP:
				return c.costParams[0]*Game.hero.level+c.costParams[1];
				break;
			case T_LEVEL_4_HPMP:
				return c.costParams[0]*Game.hero.level+c.costParams[1];
				break;
			case T_SKLV_4_HP:
				return c.costParams[0]*si.level+c.costParams[1];
				break;
			case T_SKLV_4_HPMP:
				return c.costParams[0]*si.level+c.costParams[1];
				break;
			}
			return 0;
		}
		
		/** 消耗mp值 */
		public static function costMp(si:SkillItem):int
		{
			var c:SkillCfg = si.config;
			switch(c.costType)
			{
			case T_FIXED_4_MP:
				return c.costParams[0];
				break;
			case T_LEVEL_4_MP:
				return c.costParams[0]*Game.hero.level+c.costParams[1];
				break;
			case T_LEVEL_4_HPMP:
				return c.costParams[2]*Game.hero.level+c.costParams[3];
				break;
			case T_SKLV_4_MP:
				return c.costParams[0]*si.level+c.costParams[1];
				break;
			case T_SKLV_4_HPMP:
				return c.costParams[2]*si.level+c.costParams[3];
				break;
			}
			return 0;
		}
		
	}
}