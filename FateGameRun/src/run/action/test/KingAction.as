package run.action.test
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import run.action.IAction;
	
	public class KingAction extends IAction
	{
		private var timeTag:uint;
		
		public function KingAction(block:Boolean=true)
		{
			super(block);
			type = IAction.TEST_KING;
		}
		
		override public function start():void
		{
			//done();
			//timeTag = setInterval(keepDoing, 2000);
			setTimeout(delayDo, 1500);
		}
		
		private function keepDoing():void
		{
			trace("KingAction 执行了");
		}
		
		private function delayDo():void
		{
			trace("KingAction 执行了delayDo");
			done();
		}
		
		override public function stop():void
		{
			clearInterval(timeTag);
		}
		
		override public function fearTypes():Array
		{
			//return [IAction.TEST_GOD];
			return null;
		}
		
//		override public function killTypes():Array
//		{
//			return [IAction.TEST_BING, IAction.TEST_GUAN];
//		}
	}
}