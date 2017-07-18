package net.msg.task
{
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.struct.task.StTaskItem;
	import comm.struct.task.StTaskList;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	
	public class TaskMsg extends IMessage
	{
		private static var instance:TaskMsg;
		public static function getInstance():TaskMsg
		{
			if(instance == null) { instance = new TaskMsg(); }
			return instance;
		}
		
		/** [任务]主消息号 */
		public static const MID:int = TASK_MID;
		
		/** game向client发送初始化任务列表 */
		private static const INIT_TASK_LIST_G2C:int = 1;
		/** game向client发送新增任务 */
		private static const ADD_TASK_G2C:int = 2;
		/** game向client发送删除任务 */
		private static const REMOVE_TASK_G2C:int = 3;
		/** game向client发送更新任务 */
		private static const UPDATE_TASK_G2C:int = 4;
		
		/** client向game请求接受任务 */
		private static const ACCEPT_TASK_REQ_C2G:int = 11;
		/** game向client发送接受任务的请求返回结果 */
		private static const ACCEPT_TASK_RPL_G2C:int = 13;
		/** client向game请求完成任务 */
		private static const FINISH_TASK_REQ_C2G:int = 12;
		/** game向client发送完成任务的请求返回结果 */
		private static const FINISH_TASK_RPL_G2C:int = 14;
		
		public function TaskMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case INIT_TASK_LIST_G2C:
				recvInitTaskList_G2C(bytes);
				break;
			case ADD_TASK_G2C:
				recvAddTask_G2C(bytes);
				break;
			case REMOVE_TASK_G2C:
				recvRemoveTask_G2C(bytes);
				break;
			case UPDATE_TASK_G2C:
				recvUpdateTask_G2C(bytes);
				break;
			case ACCEPT_TASK_RPL_G2C:
				recvAcceptTaskRpl_G2C(bytes);
				break;
			case FINISH_TASK_RPL_G2C:
				recvFinishTaskRpl_G2C(bytes);
				break;
			}
		}
		
		/** recv( game向client发送初始化任务列表 ) */
		private function recvInitTaskList_G2C(bytes:ByteArray):void
		{
			var data:StTaskList = new StTaskList();
			data.read(bytes);
			Game.task.initTaskList(data);
		}
		
		/** recv( game向client发送新增任务 ) */
		private function recvAddTask_G2C(bytes:ByteArray):void
		{
			var data:StTaskItem = new StTaskItem();
			data.read(bytes);
			Game.task.addTask(data);
		}
		
		/** recv( game向client发送删除任务 ) */
		private function recvRemoveTask_G2C(bytes:ByteArray):void
		{
			var taskId:int = EndianFacade.readInt(bytes);
			Game.task.removeTask(taskId);
		}
		
		/** recv( game向client发送更新任务 ) */
		private function recvUpdateTask_G2C(bytes:ByteArray):void
		{
			var data:StTaskItem = new StTaskItem();
			data.read(bytes);
			Game.task.updateTask(data);
		}
		
		
		/** send( client向game请求接受任务 ) */
		public function sendAcceptTaskReq_C2G(taskId:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, ACCEPT_TASK_REQ_C2G);
			EndianFacade.writeInt(mb.bytes, taskId);
			mb.send();
		}
		
		/** recv( game向client发送接受任务的请求返回结果 ) */
		private function recvAcceptTaskRpl_G2C(bytes:ByteArray):void
		{
			var errCode:int = EndianFacade.readByte(bytes);
		}
		
		/** client向game请求完成任务 */
		public function sendFinishTaskReq_C2G(taskId:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, FINISH_TASK_REQ_C2G);
			EndianFacade.writeInt(mb.bytes, taskId);
			mb.send();
		}
		
		/** recv( game向client发送完成任务的请求返回结果 ) */
		private function recvFinishTaskRpl_G2C(bytes:ByteArray):void
		{
			var errCode:int = EndianFacade.readByte(bytes);
			switch(errCode)
			{
			case 0: Game.info.notice("成功完成任务！"); break;
			case 1: Game.info.notice("这个任务还没有完成！"); break;
			}
		}
		
	}
}