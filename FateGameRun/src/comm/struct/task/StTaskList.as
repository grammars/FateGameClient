package comm.struct.task
{
	import com.anstu.jload.JLoader;
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;
	
	import gamekit.utils.StrParser;

	public class StTaskList
	{
		/** 已完成的任务id们 */
		public var finishIds:Array = new Array();
		/** 任务项 */
		public var items:Vector.<StTaskItem> = new Vector.<StTaskItem>();
		
		public function StTaskList()
		{
			//
		}
		
		/** 从bytes读出 */
		public function read(bytes:ByteArray):StTaskList
		{
			var i:int = 0;
			
			var finishIdsNum:int = EndianFacade.readInt(bytes);
			finishIds.length = 0;
			for(i = 0; i < finishIdsNum; i++)
			{
				finishIds.push( EndianFacade.readInt(bytes) );
			}
			
			items.length = 0;
			var num:int = EndianFacade.readInt(bytes);
			for(i = 0; i < num; i++)
			{
				var item:StTaskItem = new StTaskItem();
				item.read(bytes);
				items.push(item);
			}
			return this;
		}
		
	}
}