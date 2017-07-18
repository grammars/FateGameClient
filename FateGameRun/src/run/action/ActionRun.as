package run.action
{
	import run.AbstractRunHandler;
	
	public class ActionRun extends AbstractRunHandler
	{
		/** 并发的行为 */
		private var multiQueue:Vector.<IAction> = new Vector.<IAction>();
		/** 顺序的行为 */
		private var seqQueue:Vector.<IAction> = new Vector.<IAction>();
		
		/** 当前运行的顺序行为 */
		private var runningSeqAction:IAction;
		
		public function ActionRun()
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
		
		/** 推入一个并发行为 */
		public function pushMultiAction(action:IAction):void
		{
			var i:int = 0;
			var ma:IAction;
			if(action.fearTypes() != null)
			{
				for(i = multiQueue.length-1; i >= 0; i--)
				{
					ma = multiQueue[i];
					if( -1 != action.fearTypes().indexOf(ma.type) )
					{
						return;
					}
				}
			}
			if(action.killTypes() != null)
			{
				for(i = multiQueue.length-1; i >= 0; i--)
				{
					ma = multiQueue[i];
					if( -1 != action.killTypes().indexOf(ma.type) )
					{
						ma.stop();
						multiQueue.splice(i, 1);
					}
				}
			}
			multiQueue.push(action);
			action.start();
		}
		
		/** 推入一个顺序行为 */
		public function pushSeqAction(action:IAction):void
		{
			var i:int = 0;
			var ma:IAction;
			if(action.fearTypes() != null)
			{
				for(i = seqQueue.length-1; i >= 0; i--)
				{
					ma = seqQueue[i];
					if( -1 != action.fearTypes().indexOf(ma.type) )
					{
						return;
					}
				}
			}
			if(action.killTypes() != null)
			{
				for(i = seqQueue.length-1; i >= 0; i--)
				{
					ma = seqQueue[i];
					if( -1 != action.killTypes().indexOf(ma.type) )
					{
						ma.stop();
						seqQueue.splice(i, 1);
					}
				}
			}
			seqQueue.push(action);
			nextInSeq();
		}
		
		public function pushAction(action:IAction):void
		{
			if(action.isBlock)
			{
				pushSeqAction(action);
			}
			else
			{
				pushMultiAction(action);
			}
		}
		
		public function removeAction(actionId:int):IAction
		{
			var i:int = 0;
			var running:IAction;
			var waiting:IAction;
			for(i = multiQueue.length-1; i >= 0; i--)
			{
				running = multiQueue[i];
				if( running.id == actionId )
				{
					running.stop();
					multiQueue.splice(i, 1);
					//trace("移除了multi行为"+actionId);
					return running;
				}
			}
			for(i = seqQueue.length-1; i >= 0; i--)
			{
				waiting = seqQueue[i];
				if( waiting.id == actionId )
				{
					seqQueue.splice(i, 1);
					//trace("移除了seq行为"+actionId);
					return waiting;
				}
			}
			return null;
		}
		
		/** 运行下一个顺序行为[被block的IAction调用] */
		public function nextInSeq():void
		{
			if(runningSeqAction && !runningSeqAction.isOver) { return; }
			if(seqQueue.length <= 0) { return; }
			runningSeqAction = seqQueue.shift();
			runningSeqAction.start();
		}
		
	}
}