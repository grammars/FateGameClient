package gamekit.avatar
{
	public class ActionType
	{
		/** 动作类型：站立 */
		public static const STAND:String = "stand";
		
		/** 动作类型：玩家行走 */
		public static const RUN:String = "run";
		
		/** 动作类型：怪物行走 */
		public static const WALK:String = "walk";
		
		/** 动作类型：轻砍 */
		public static const HIT:String = "fight_qingkan";
		
		/** 动作类型：重击 */
		public static const BANG:String = "fight_zhongkan";
		
		/** 动作类型：跳砍 */
		public static const JUMP_CUT:String = "fight_tiaokan";
		
		/** 动作类型：魔法技 横推 */
		public static const MAGIC_SWEEP:String = "magic_hengtui";
		
		/** 动作类型：魔法技 上举 */
		public static const MAGIC_SING:String = "magic_shangju";
		
		/** 动作类型：受伤 */
		public static const BEATEN:String = "beaten";
		
		/** 动作类型：死亡 */
		public static const DIE:String = "die";
		
		/** 动作类型：打坐 */
		public static const SIT:String = "dazuo";
		
		/** 动作类型：特效 */
		public static const EFFECT:String = "effect";
		
		public function ActionType()
		{
		}
		
		/** 获取优先级【值越高，优先级越大】 */
		public static function getPriority(type:String):int
		{
			switch(type)
			{
				case STAND:
					return 1;
				case RUN:
					return 3;
				case WALK:
					return 3;
				case HIT:
					return 4;
				case BANG:
					return 5;
				case JUMP_CUT:
					return 6;
				case BEATEN:
					return 2;
				case DIE:
					return 2;
				case SIT:
					return 2;
				default:
					return 0;	
			}
		}
	}
}