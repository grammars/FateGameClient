package run.action.test
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import run.action.IAction;
	
	public class GodAction extends IAction
	{
		private var timeTag:uint;
		
		public function GodAction(block:Boolean=true)
		{
			super(block);
			type = IAction.TEST_GOD;
		}
		
		override public function start():void
		{
			//done();
			//timeTag = setInterval(keepDoing, 2000);
			setTimeout(delayDo, 1500);
		}
		
		private function keepDoing():void
		{
			trace("GodAction 执行了");
		}
		
		private function delayDo():void
		{
			trace("GodAction 执行了delayDo");
			done();
		}
		
		override public function stop():void
		{
			clearInterval(timeTag);
		}
	}
}