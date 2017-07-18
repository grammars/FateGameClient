package comm.component.task
{
	import comm.struct.task.StTaskItem;
	import comm.struct.task.StTaskList;

	public class TaskList
	{
		/** 已完成的任务id们 */
		public var finishIds:Array = new Array();
		/** 任务项 */
		public var items:Vector.<TaskItem> = new Vector.<TaskItem>();
		
		public function TaskList()
		{
		}
		
		/** 新增任务 */
		public function addTask(data:StTaskItem):TaskItem
		{
			var item:TaskItem = new TaskItem();
			item.importData(data);
			items.push(item);
			return item;
		}
		
		/** 删除任务 */
		public function removeTask(taskId:int):TaskItem
		{
			for(var i:int = items.length-1; i >= 0; i--)
			{
				var item:TaskItem = items[i];
				if(item.taskId == taskId)
				{
					items.splice(i,1);
					return item; 
				}
			}
			return null;
		}
		
		/** 更新任务 */
		public function updateTask(data:StTaskItem):TaskItem
		{
			for(var i:int = items.length-1; i >= 0; i--)
			{
				var item:TaskItem = items[i];
				if(item.taskId == data.taskId)
				{
					item.importData(data);
					return item; 
				}
			}
			return null;
		}
		
		/** 导入结构数据 */
		public function importData(data:StTaskList):void
		{
			this.finishIds = data.finishIds;
			items.length = 0;
			var num:int = data.items.length;
			for(var i:int = 0; i < num; i++)
			{
				var st:StTaskItem = data.items[i];
				var item:TaskItem = new TaskItem();
				item.importData(st);
				items.push(item);
			}
		}
		
	}
}