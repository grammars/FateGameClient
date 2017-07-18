package net.msg
{
	import flash.utils.ByteArray;

	public class IMessage
	{
		/** [服务器框架核心]主消息号 */
		public static const FRAMEWORK_MID:int = 158000;
		/** [登录]主消息号 */
		public static const LOGIN_MID:int = 158001;
		/** [角色数据]主消息号 */
		public static const PLAYER_DATA_MID:int = 158002;
		/** [场景]主消息号 */
		public static const SCENE_MID:int = 158003;
		/** [玩家事件]主消息号 */
		public static const PLAYER_EVENT_MID:int = 158004;
		/** [战斗]主消息号 */
		public static const FIGHT_MID:int = 158005;
		/** [生物数据]主消息号 */
		public static const CREATURE_MID:int = 158006;
		/** [Buff]主消息号 */
		public static const BUFF_MID:int = 158007;
		/** [物品]主消息号 */
		public static const GOODS_MID:int = 158008;
		/** [技能]主消息号 */
		public static const SKILL_MID:int = 158009;
		/** [修炼]主消息号 */
		public static const PRACTICE_MID:int = 158010;
		/** [任务]主消息号 */
		public static const TASK_MID:int = 158011;
		/** [npc]主消息号 */
		public static const NPC_MID:int = 158012;
		/** [cd]主消息号 */
		public static const CD_MID:int = 158013;
		
		/** [通用]主消息号 */
		public static const COMMON_MID:int = 158998;
		/** [GM]主消息号 */
		public static const GM_MID:int = 158999;
		
		public function IMessage()
		{
		}
		
		/** 接收消息处理器 */
		public function handle(subId:int, bytes:ByteArray):void
		{
			
		}
		
	}
}