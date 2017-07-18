package net.msg.common
{
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	
	public class CommonMsg extends IMessage
	{
		private static var instance:CommonMsg;
		public static function getInstance():CommonMsg
		{
			if(instance == null) { instance = new CommonMsg(); }
			return instance;
		}
		
		/** [通用]主消息号 */
		public static const MID:int = COMMON_MID;
		
		/** game向client发送提示消息 */
		private static const ALERT_G2C:int = 1;
		
		public function CommonMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case ALERT_G2C:
				recvAlert_G2C(bytes);
				break;
			}
		}
		
		/** recv( game向client发送提示消息 ) */
		private function recvAlert_G2C(bytes:ByteArray):void
		{
			var text:String = EndianFacade.readMultiByte(bytes);
			Game.info.notice(text);
		}
		
	}
}