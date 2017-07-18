package run.npc
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class NpcTalkContent
	{
		/** 对话主内容 */
		public var text:String = "";
		/** 关联任务id */
		public var taskId:int = 0;
		/** 是否有可交掉的任务 */
		public var hasDoneTask:Boolean = false;
		/** 是否有可接的任务 */
		public var hasAcceptableTask:Boolean = false;
		/** 是否正在做的任务 */
		public var hasDoingTask:Boolean = false;
		
		public function NpcTalkContent()
		{
		}
		
		public function read(bytes:ByteArray):void
		{
			taskId = EndianFacade.readInt(bytes);
			hasDoneTask = EndianFacade.readBoolean(bytes);
			hasAcceptableTask = EndianFacade.readBoolean(bytes);
			hasDoingTask = EndianFacade.readBoolean(bytes);
			text = EndianFacade.readMultiByte(bytes);
		}
	}
}