package net.msg.player
{
	import central.Centre;
	
	import flash.utils.ByteArray;
	
	import net.SidType;
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	import net.msg.scene.SceneMsg;
	
	public class PlayerEventMsg extends IMessage
	{
		private static var instance:PlayerEventMsg;
		public static function getInstance():PlayerEventMsg
		{
			if(instance == null) { instance = new PlayerEventMsg(); }
			return instance;
		}
		
		/** [玩家事件]主消息号 */
		public static const MID:int = PLAYER_EVENT_MID;
		
		/** client向gate发送玩家登录网关消息  */
		private static const PLAYER_LOGIN_GATE_REQ_C2G:int = 1;
		/** gate向client回复玩家登录网关成功消息  */
		private static const PLAYER_LOGIN_GATE_RPL_G2C:int = 2;
		
		public function PlayerEventMsg()
		{
			super();
		}
		
		override public function handle(subId:int, data:ByteArray):void
		{
			switch(subId)
			{
			case PLAYER_LOGIN_GATE_RPL_G2C:
				recvPlayerLoginGateRpl_G2C(data);
				break;
			}
		}
		
		/** send( client向gate发送玩家登录网关消息 )  */
		public function sendPlayerLoginGateReq_C2G():void
		{
			var msg:MsgBuffer = new MsgBuffer(MID, PLAYER_LOGIN_GATE_REQ_C2G, SidType.GATE);
			msg.send();
		}
		
		/** recv( gate向client回复玩家登录网关成功消息 ) */
		private function recvPlayerLoginGateRpl_G2C(bytes:ByteArray):void
		{
			SceneMsg.getInstance().sendSceneInfoReq_C2G();
		}
		
	}
}