package run.info
{
	import central.Centre;
	
	import flash.events.MouseEvent;
	
	import run.AbstractRunHandler;
	
	public class InfoRun extends AbstractRunHandler
	{
		public function InfoRun()
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
		
		/** 向玩家进行信息提示 */
		public function notice(content:String):void
		{
			var ifn:InfoNotice = new InfoNotice();
			ifn.show(content);
			trace("INFO::" + content);
		}
		
	}
}