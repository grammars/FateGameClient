package run.action.test
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import run.action.IAction;
	
	public class BingAction extends IAction
	{
		private var timeTag:uint;
		
		public function BingAction(block:Boolean=true)
		{
			super(block);
			type = IAction.TEST_BING;
		}
		
		override public function start():void
		{
			//done();
			//timeTag = setInterval(keepDoing, 2000);
			setTimeout(delayDo, 1500);
		}
		
		private function keepDoing():void
		{
			trace("BingAction 执行了");
		}
		
		private function delayDo():void
		{
			trace("BingAction 执行了delayDo");
			done();
		}
		
		override public function stop():void
		{
			clearInterval(timeTag);
		}
	}
}