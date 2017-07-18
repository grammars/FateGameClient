package comm.define
{
	public class SpriteType
	{
		/** 抽象类型 */
		public static const NULL : int = 0;
		/** 玩家 */
		public static const PLAYER : int = 1;
		/** NPC */
		public static const NPC : int = 2;
		/** 怪物 */
		public static const MONSTER : int = 3;
		/** 传送门 */
		public static const DOOR : int = 4;	
		/** 掉落的物品 */
		public static const DROP : int = 5;
		/** 场景特效 */
		public static const EFFECT : int = 6;
		/** Aoe技能 */
		public static const AOE_SKILL : int = 7;
		/** Path技能 */
		public static const PATH_SKILL : int = 8;
		
		public function SpriteType()
		{
		}
	}
}