package net.msg.gm
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;
	
	import net.SidType;
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	
	import ui.view.debug.GmParamCmd;
	
	public class GmMsg extends IMessage
	{
		private static var instance:GmMsg;
		public static function getInstance():GmMsg
		{
			if(instance == null) { instance = new GmMsg(); }
			return instance;
		}
		
		/** [GM]主消息号 */
		public static const MID:int = GM_MID;
		
		/** client向game请求执行参数化的GM命令 */
		private static const PARAMS_CMD_C2G:int = 0;
		
		public function GmMsg()
		{
			super();
		}
		
		override public function handle(subId:int, data:ByteArray):void
		{
			switch(subId)
			{
			}
		}
		
		/** send( client向game请求执行参数化的GM命令 ) */
		public function sendParamsCmd_C2G(cmd:GmParamCmd):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PARAMS_CMD_C2G, SidType.GAME);
			EndianFacade.writeInt(mb.bytes, cmd.mainCmdId);
			EndianFacade.writeInt(mb.bytes, cmd.subCmdId);
			EndianFacade.writeByte(mb.bytes, parseInt(cmd.byte0Input));
			EndianFacade.writeByte(mb.bytes, parseInt(cmd.byte1Input));
			EndianFacade.writeInt(mb.bytes, parseInt(cmd.int0Input));
			EndianFacade.writeInt(mb.bytes, parseInt(cmd.int1Input));
			EndianFacade.writeInt(mb.bytes, parseInt(cmd.int2Input));
			EndianFacade.writeFloat(mb.bytes, parseFloat(cmd.float0Input));
			EndianFacade.writeDouble(mb.bytes, parseFloat(cmd.double0Input));
			new Long().fromString(cmd.long0Input).writeTo(mb.bytes);
			new Long().fromString(cmd.long1Input).writeTo(mb.bytes);
			EndianFacade.writeMultiByte(mb.bytes, cmd.str0Input);
			EndianFacade.writeMultiByte(mb.bytes, cmd.str1Input);
			mb.send();
		}
		
	}
}