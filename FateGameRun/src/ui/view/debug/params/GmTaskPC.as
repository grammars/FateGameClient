package ui.view.debug.params
{
	import ui.view.debug.GmParamCmd;
	
	public class GmTaskPC extends GmParamCmd
	{
		/** 添加任务 */
		private static const ADD_TASK:int = 1;
		/** 清空任务 */
		private static const CLEAR_TASKS:int = 2;
		
		public function GmTaskPC(label:String="", mainCmdId:int=0, subCmdId:int=0)
		{
			super(label, mainCmdId, subCmdId);
		}
		
		override protected function cmdHandler():void
		{
			switch(subCmdId)
			{
			case ADD_TASK:
				int0Label = "任务id:";
				int0Input = "2000";
				break;
			case CLEAR_TASKS:
				break;
			}
		}
		
		
		/** 获得所有选项值 */
		public static function items():Array
		{
			var arr:Array = [];
			arr.push(new GmTaskPC("添加任务", GmParamCmd.TYPE_TASK, ADD_TASK));
			arr.push(new GmTaskPC("清空任务", GmParamCmd.TYPE_TASK, CLEAR_TASKS));
			return arr;
		}
	}
}