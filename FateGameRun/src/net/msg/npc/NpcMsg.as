package net.msg.npc
{
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	
	import run.npc.NpcTalkContent;
	
	public class NpcMsg extends IMessage
	{
		private static var instance:NpcMsg;
		public static function getInstance():NpcMsg
		{
			if(instance == null) { instance = new NpcMsg(); }
			return instance;
		}
		
		/** [npc]主消息号 */
		public static const MID:int = NPC_MID;
		
		/** client向game请求跟npc对话  */
		private static const TALK_WITH_NPC_REQ_C2G:int = 1;
		/** game向client发送npc对话内容 */
		private static const NPC_TALK_CONTENT_G2C:int = 2;
		
		public function NpcMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case NPC_TALK_CONTENT_G2C:
				recvNpcTalkContent_G2C(bytes);
				break;
			}
		}
		
		/** send( client向game请求跟npc对话 ) */
		public function sendTalkWithNpcReq_C2G(npcCfgId:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, TALK_WITH_NPC_REQ_C2G);
			EndianFacade.writeInt(mb.bytes, npcCfgId);
			mb.send();
		}
		
		/** recv( game向client发送npc对话内容 ) */
		private function recvNpcTalkContent_G2C(bytes:ByteArray):void
		{
			var content:NpcTalkContent = new NpcTalkContent();
			content.read(bytes);
			Game.npc.openTalk(content);
		}
		
	}
}