package run.fight.path
{
	import comm.component.skill.SkillItem;

	public class PathSkillHandler
	{
		private var skill:SkillItem;
		
		public function PathSkillHandler()
		{
		}
		
		public function setup():void
		{
			
		}
		
		public function useSkill(param:SkillItem):Boolean
		{
			skill = param;
			return true;
		}
	}
}