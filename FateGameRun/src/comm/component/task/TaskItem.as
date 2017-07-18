package comm.component.task
{
	import cfg.TaskCfg;
	
	import comm.struct.task.StTaskItem;
	
	public class TaskItem extends StTaskItem
	{
		/** 任务配置 */
		public var config:TaskCfg;
		
		public function TaskItem()
		{
			super();
		}
		
		private function build():void
		{
			config = TaskCfg.get(this.taskId);
		}
		
		/** 导入结构数据 */
		public function importData(data:StTaskItem):void
		{
			this.taskId = data.taskId;
			this.state = data.state;
			this.talkedNpc = data.talkedNpc;
			this.killMonsterNum = data.killMonsterNum;
			this.gotGoodsNum = data.gotGoodsNum;
			this.passZone = data.passZone;
			build();
		}
	}
}