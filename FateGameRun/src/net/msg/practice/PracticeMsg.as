package net.msg.practice
{
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.practice.PracticeOperEnum;
	import comm.struct.practice.StPracticeData;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	
	public class PracticeMsg extends IMessage
	{
		private static var instance:PracticeMsg;
		public static function getInstance():PracticeMsg
		{
			if(instance == null) { instance = new PracticeMsg(); }
			return instance;
		}
		
		/** [修炼]主消息号 */
		public static const MID:int = PRACTICE_MID;
		
		/** game向client通知修炼信息初始化 */
		private static const INIT_DATA_G2C:int = 1;
		/** client向game请求提升修炼等级 */
		private static const LEVEL_UP_REQ_C2G:int = 2;
		/** game向client返回提升修炼等级结果 */
		private static const LEVEL_UP_RPL_G2C:int = 3;
		
		public function PracticeMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case INIT_DATA_G2C:
				recvInitData_G2C(bytes);
				break;
			case LEVEL_UP_RPL_G2C:
				recvLevelUpRpl_G2C(bytes);
				break;
			}
		}
		
		/** recv( game向client通知修炼信息初始化 ) */
		private function recvInitData_G2C(bytes:ByteArray):void
		{
			var data:StPracticeData = new StPracticeData();
			data.read(bytes);
			Game.hero.practice.importData(data);
			Game.info.notice("当前修炼等级为" + data.lev);
		}
		
		/** send( client向game请求提升修炼等级 ) */
		public function sendLevelUpReq_C2G():void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, LEVEL_UP_REQ_C2G);
			mb.send();
		}
		
		/** recv( game向client返回提升修炼等级结果 ) */
		private function recvLevelUpRpl_G2C(bytes:ByteArray):void
		{
			var errCode:int = EndianFacade.readByte(bytes);
			switch(errCode)
			{
			case PracticeOperEnum.SUCC:
				Game.info.notice("提升修炼等级成功");
				break;
			case PracticeOperEnum.REACH_TOP:
				Game.info.notice("已到最高修炼等级");
				break;
			case PracticeOperEnum.EXP_NOT_ENOUGH:
				Game.info.notice("升级经验不够");
				break;
			}
		}
		
	}
}