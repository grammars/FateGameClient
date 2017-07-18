package run.task
{
	import central.Game;
	import central.View;
	
	import comm.component.task.TaskItem;
	import comm.struct.task.StTaskItem;
	import comm.struct.task.StTaskList;
	
	import run.AbstractRunHandler;
	
	public class TaskRun extends AbstractRunHandler
	{
		public function TaskRun()
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
		
		/** 初始化任务列表 */
		public function initTaskList(data:StTaskList):void
		{
			Game.hero.task.importData(data);
			View.taskFrame.initTaskList();
		}
		
		/** 新增任务 */
		public function addTask(data:StTaskItem):void
		{
			var item:TaskItem = Game.hero.task.addTask(data);
			View.taskFrame.addTask(item);
		}
		
		/** 删除任务 */
		public function removeTask(taskId:int):void
		{
			Game.hero.task.removeTask(taskId);
			View.taskFrame.removeTask(taskId);
		}
		
		/** 更新任务 */
		public function updateTask(data:StTaskItem):void
		{
			var item:TaskItem = Game.hero.task.updateTask(data);
			View.taskFrame.updateTask(item);
		}
		
	}
}