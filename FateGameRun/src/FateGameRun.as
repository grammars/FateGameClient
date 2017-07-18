package
{
	import central.Centre;
	
	import com.anstu.jcommon.framework.WebAppStartup;
	import com.anstu.jcommon.log.Log;
	import com.anstu.jcommon.log.LogLevel;
	
	import comm.L;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import run.action.GotoNpcAction;
	
	[SWF(backgroundColor = "#2B2B2B", frameRate = "60")]
	public class FateGameRun extends Sprite
	{
		public function FateGameRun()
		{
			new WebAppStartup(this, initialize);
		}
		
		private function initialize():void
		{
			Log.setAddTime(true);
			Log.setLevel(LogLevel.INFO);
			var sameDomain:Boolean = this.stage.loaderInfo.parameters["sameDomain"]=="true"?true:false;
			L.initialize();
			Centre.startup(stage, sameDomain);
		}
		
	}
}