package run
{
	import central.AbstractManage;
	import central.Centre;
	import central.Game;
	
	import com.anstu.jcommon.log.Log;
	
	import comm.events.FrameworkEvent;
	import comm.events.FrameworkListener;
	
	import gamekit.FateGameKit;
	
	import run.fight.FightRun;
	import run.login.LoginRun;
	import run.scene.SceneRun;
	
	/** 管理游戏逻辑 */
	public class RunManage extends AbstractManage
	{
		public function RunManage()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			Log.print("RunManage::startup()");
			super.startup();
			
			Game.startup();
			
			startupComplete();
		}
		
		
	}
}