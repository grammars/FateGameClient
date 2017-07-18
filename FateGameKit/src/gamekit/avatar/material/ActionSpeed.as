package gamekit.avatar.material
{
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarRule;

	/** 动作播放速度 */
	public class ActionSpeed
	{
		/** 速度改变之后的回调 */
		public var changeCall:Function = null;
		
		private var speed:Object = new Object();
		
		public function ActionSpeed()
		{
			speed[ActionType.STAND] = AvatarRule.getStdPlayTimeByAction(ActionType.STAND);
			speed[ActionType.RUN] = AvatarRule.getStdPlayTimeByAction(ActionType.RUN);
			speed[ActionType.WALK] = AvatarRule.getStdPlayTimeByAction(ActionType.WALK);
			speed[ActionType.HIT] = AvatarRule.getStdPlayTimeByAction(ActionType.HIT);
			speed[ActionType.BANG] = AvatarRule.getStdPlayTimeByAction(ActionType.BANG);
			speed[ActionType.JUMP_CUT] = AvatarRule.getStdPlayTimeByAction(ActionType.JUMP_CUT);
			speed[ActionType.MAGIC_SWEEP] = AvatarRule.getStdPlayTimeByAction(ActionType.MAGIC_SWEEP);
			speed[ActionType.MAGIC_SING] = AvatarRule.getStdPlayTimeByAction(ActionType.MAGIC_SING);
			speed[ActionType.BEATEN] = AvatarRule.getStdPlayTimeByAction(ActionType.BEATEN);
			speed[ActionType.DIE] = AvatarRule.getStdPlayTimeByAction(ActionType.DIE);
			speed[ActionType.SIT] = AvatarRule.getStdPlayTimeByAction(ActionType.SIT);
			speed[ActionType.EFFECT] = AvatarRule.getStdPlayTimeByAction(ActionType.EFFECT);
		}
		
		/** 设置动作播放耗时 */
		public function setActionTime(type:String, value:int):void
		{
			speed[type] = value;
			if(changeCall != null) { changeCall(); }
		}
		
		/** 获得动作播放耗时 */
		public function getActionTime(type:String):int
		{
			var value:int = speed[type];
			if(value <= 0)
			{
				value = AvatarRule.getStdPlayTimeByAction(type);
			}
			return value;
		}
		
		/** cloneFrom */
		public function cloneFrom(target:ActionSpeed):void
		{
			speed[ActionType.STAND] = target.getActionTime(ActionType.STAND);
			speed[ActionType.RUN] = target.getActionTime(ActionType.RUN);
			speed[ActionType.WALK] = target.getActionTime(ActionType.WALK);
			speed[ActionType.HIT] = target.getActionTime(ActionType.HIT);
			speed[ActionType.BANG] = target.getActionTime(ActionType.BANG);
			speed[ActionType.JUMP_CUT] = target.getActionTime(ActionType.JUMP_CUT);
			speed[ActionType.MAGIC_SWEEP] = target.getActionTime(ActionType.MAGIC_SWEEP);
			speed[ActionType.MAGIC_SING] = target.getActionTime(ActionType.MAGIC_SING);
			speed[ActionType.BEATEN] = target.getActionTime(ActionType.BEATEN);
			speed[ActionType.DIE] = target.getActionTime(ActionType.DIE);
			speed[ActionType.SIT] = target.getActionTime(ActionType.SIT);
			speed[ActionType.EFFECT] = target.getActionTime(ActionType.EFFECT);
			
			if(changeCall != null) { changeCall(); }
		}
		
	}
}