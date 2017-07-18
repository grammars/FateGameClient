package run.skill
{
	import central.Game;
	import central.View;
	
	import comm.struct.skill.StSkillSet;
	
	import run.AbstractRunHandler;
	
	import ui.view.operate.OperPane;
	
	public class SkillRun extends AbstractRunHandler
	{
		public function SkillRun()
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
		}
		
		public function initSkillSet():void
		{
			View.operPane.heroInit();
		}
		
	}
}