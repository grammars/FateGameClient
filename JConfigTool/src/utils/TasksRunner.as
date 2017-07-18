package utils
{
	import flash.utils.setTimeout;
	
	import manage.CentreManage;
	import manage.MainManage;
	
	import mx.controls.Alert;
	import data.FileInfo;

	public class TasksRunner
	{
		protected var curFileInfo:FileInfo;
		
		/** 当前任务总数量 */
		private var taskTotalNum:int = 0;
		/** 当前已完成任务数 */
		private var taskDoneNum:int = 0;
		
		public function TasksRunner()
		{
		}
		
		public function run(recall:Boolean=false):void
		{
			if(recall == false)
			{
				taskDoneNum = 0;
				taskTotalNum = MainManage.getTasks().length;
			}
			if(MainManage.getTasks().length > 0)
			{
				setTimeout(execute, 30);
			}
			updateProgress();
		}
		
		/** 获取接受的文件后缀 */
		protected function getAcceptExt():String
		{
			return "needOverride";
		}
		
		/** 创建新文件名 */
		protected function createNewFileName():String
		{
			return "newFileName.newFileType";
		}
		
		protected function execute():void
		{
			curFileInfo = MainManage.getTasks().removeItemAt(0) as FileInfo;
			
			if(curFileInfo.extension != getAcceptExt())
			{
				curTaskDone();
				return;
			}
			
			work();
		}
		
		protected function work():void
		{
			//actual do sth
		}
		
		protected function curTaskDone():void
		{
			MainManage.removeTask(curFileInfo);
			curFileInfo = null;
			taskDoneNum++;
			updateProgress();
			if(taskDoneNum < taskTotalNum)
			{
				run(true);
			}
			else
			{
				allTasksDone();
			}
		}
		
		/** 当前所有任务已完成 */
		protected function allTasksDone():void
		{
			trace("当前所有任务已完成");
			taskDoneNum = taskTotalNum;
			CentreManage.updateProjSpace();
		}
		
		/** 更新进度 */
		protected function updateProgress():void
		{
			var label:String;
			if(taskDoneNum == taskTotalNum)
			{
				label = "已完成";
			}
			else
			{
				label = "正在处理";
			}
			MainManage.updateProgress(taskDoneNum, taskTotalNum, label);
		}
		
		/** 通知错误 */
		protected function error(msg:String="错误"):void
		{
			Alert.show(msg, "错误警告");
		}
		
	}
}