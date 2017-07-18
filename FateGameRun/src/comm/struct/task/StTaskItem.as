package comm.struct.task
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class StTaskItem
	{
		/** 未接到这个任务 */
		public static const ST_NULL:int = 0;
		/** 已接到这个任务，正在进行中 */
		public static const ST_ING:int = 1;
		/** 已满足任务条件，但还没有交掉这个任务 */
		public static const ST_DONE:int = 2;
		/** 任务交掉，已完成 */
		public static const ST_OVER:int = 3;
		
		/** 任务id */
		public var taskId:int = 0;
		/** 任务状态 */
		public var state:int = 0;
		
		/** 是否跟npc对话过 */
		public var talkedNpc:Boolean = false;
		/** 已杀怪物数量 */
		public var killMonsterNum:int = 0;
		/** 获取物品数量 */
		public var gotGoodsNum:int = 0;
		/** 是否完成目标副本 */
		public var passZone:Boolean = false;
		
		public function StTaskItem()
		{
		}
		
		/** 从bytes读出 */
		public function read(bytes:ByteArray):void
		{
			taskId = EndianFacade.readInt(bytes);
			state = EndianFacade.readByte(bytes);
			talkedNpc = EndianFacade.readBoolean(bytes);
			killMonsterNum = EndianFacade.readInt(bytes);
			gotGoodsNum = EndianFacade.readInt(bytes);
			passZone = EndianFacade.readBoolean(bytes);
		}
		
	}
}