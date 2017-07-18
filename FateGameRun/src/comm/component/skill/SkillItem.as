package comm.component.skill
{
	import cfg.SkillCfg;
	
	import comm.struct.skill.StSkillItem;

	public class SkillItem extends StSkillItem
	{
		/** 技能配置 */
		public var config:SkillCfg;
		
		/** 施放距离 */
		public function useDistance():Number
		{
			return config.useDistance;
		}
		
		public function SkillItem()
		{
		}
		
		private function build():void
		{
			config = SkillCfg.get(this.id);
		}
		
		/** 导入结构数据 */
		public function importData(data:StSkillItem):void
		{
			this.id = data.id;
			this.level = data.level;
			build();
		}
		
	}
}