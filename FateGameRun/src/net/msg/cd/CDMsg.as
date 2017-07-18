package net.msg.cd
{
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.struct.cd.StCDInfo;
	import comm.struct.cd.StCDUint;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	
	public class CDMsg extends IMessage
	{
		private static var instance:CDMsg;
		public static function getInstance():CDMsg
		{
			if(instance == null) { instance = new CDMsg(); }
			return instance;
		}
		
		/** [cd]主消息号 */
		public static const MID:int = CD_MID;
		
		/** game向client通知初始化cd信息 */
		private static const INIT_CD_G2C:int = 1;
		/** game向client通知添加cd信息 */
		private static const ADD_CD_G2C:int = 2;
		/** game向client通知移除cd信息 */
		private static const REMOVE_CD_G2C:int = 3;
		
		public function CDMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case INIT_CD_G2C:
				recvInitCD_G2C(bytes);
				break;
			case ADD_CD_G2C:
				recvAddCD_G2C(bytes);
				break;
			case REMOVE_CD_G2C:
				recvRemoveCD_G2C(bytes);
				break;
			}
		}
		
		/** recv( game向client通知初始化cd信息 ) */
		private function recvInitCD_G2C(bytes:ByteArray):void
		{
			var data:StCDUint = new StCDUint();
			data.read(bytes);
			Game.cd.initCD(data);
		}
		
		/** recv( game向client通知添加cd信息 ) */
		private function recvAddCD_G2C(bytes:ByteArray):void
		{
			var info:StCDInfo = new StCDInfo();
			info.read(bytes);
			Game.cd.addCD(info);
		}
		
		/** recv( game向client通知移除cd信息 ) */
		private function recvRemoveCD_G2C(bytes:ByteArray):void
		{
			var type:int = EndianFacade.readByte(bytes);
			var id:int = EndianFacade.readInt(bytes);
			Game.cd.removeCD(type, id);
		}
		
	}
}