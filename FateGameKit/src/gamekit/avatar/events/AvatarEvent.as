package gamekit.avatar.events
{
	import flash.events.Event;
	
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.map.material.AStarNode;
	
	public class AvatarEvent extends Event
	{
		/** avatar开始行走产生的路径[携带有效参数：avatar,isWalking] */
		public static const WALK_PATH:String = "AvatarEvent.WALK_PATH";
		/** avatar行走时候产生的步点[携带有效参数：avatar,walkStep] */
		public static const WALK_STEP:String = "AvatarEvent.WALK_STEP";
		/** avatar走路停止时候[携带有效参数：avatar] */
		public static const WALK_STOP:String = "AvatarEvent.WALK_STOP";
		/** avatar动作播放完一遍的时候[携带有效参数：avatar,curAction] */
		public static const ACTION_ONCE_DONE:String = "AvatarEvent.ACTION_ONCE_DONE";
		
		/** dispatchWalkPathEvent */
		public static function dispatchWalkPathEvent(src:AvatarDisplay, path:Array, isWalking:Boolean):void
		{
			var evt:AvatarEvent = new AvatarEvent(AvatarEvent.WALK_PATH, src);
			evt.cloneWalkPath(path);
			evt.isWalking = isWalking;
			src.dispatchEvent(evt);
		}
		
		/** dispatchWalkStepEvent */
		public static function dispatchWalkStepEvent(src:AvatarDisplay, step:AStarNode):void
		{
			var evt:AvatarEvent = new AvatarEvent(AvatarEvent.WALK_STEP, src);
			evt.walkStep = step;
			src.dispatchEvent(evt);
		}
		
		/** dispatchWalkStopEvent */
		public static function dispatchWalkStopEvent(src:AvatarDisplay):void
		{
			var evt:AvatarEvent = new AvatarEvent(AvatarEvent.WALK_STOP, src);
			src.dispatchEvent(evt);
		}
		
		/** dispatchActionOnceDone */
		public static function dispatchActionOnceDone(src:AvatarDisplay, action:String):void
		{
			var evt:AvatarEvent = new AvatarEvent(AvatarEvent.ACTION_ONCE_DONE, src);
			evt.curAction = action;
			src.dispatchEvent(evt);
		}
		
		public var avatar:AvatarDisplay;
		public var walkPath:Array;
		public var isWalking:Boolean;
		public var walkStep:AStarNode;
		public var curAction:String;
		
		/** AvatarEvent */
		public function AvatarEvent(type:String, avatar:AvatarDisplay, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.avatar = avatar;
		}
		
		/** cloneWalkPath */
		public function cloneWalkPath(path:Array):Array
		{
			walkPath = new Array();
			for(var i:int = 0; i < path.length; i++)
			{
				walkPath.push(path[i]);
			}
			return walkPath;
		}
		
		/** 获取路径目标点 */
		public function destPoint():AStarNode
		{
			if(walkPath && walkPath.length > 0)
			{
				return walkPath[walkPath.length-1];
			}
			return null;
		}
		
	}
}