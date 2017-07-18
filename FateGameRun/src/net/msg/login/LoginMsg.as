package net.msg.login
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.struct.login.StAccountInfo;
	
	import flash.utils.ByteArray;
	
	import net.SidType;
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	
	import ui.view.login.CreateRolePane;
	import ui.view.login.SelectRolePane;
	
	public class LoginMsg extends IMessage
	{
		private static var instance:LoginMsg;
		public static function getInstance():LoginMsg
		{
			if(instance == null) { instance = new LoginMsg(); }
			return instance;
		}
		
		/** [登录]主消息号 */
		public static const MID:int = LOGIN_MID;
		
		/** client向login请求验证账号 */
		private static const ACCOUNT_VERIFY_REQ_C2L:int = 0;
		/** login向client回复验证账号的结果 */
		private static const ACCOUNT_VERIFY_RPL_L2C:int = 2;
		/** login向client发送的账号信息 */
		private static const ACCOUNT_INFO_L2C:int = 4;
		/** login向client发送的角色列表信息 */
		private static const PLAYER_LIST_L2C:int = 6;
		/** client向login请求新建角色 */
		private static const PLAYER_CREATE_REQ_C2L:int = 7;
		/** login向client发送的新建角色的结果 */
		private static const PLAYER_CREATE_RPL_L2C:int = 10;
		/** client向login请求选择角色进入 */
		private static const PLAYER_SELECT_REQ_C2L:int = 11;
		/** client向login请求删除角色 */
		private static const PLAYER_DELETE_REQ_C2L:int = 13;
		
		public function LoginMsg()
		{
			super();
		}
		
		override public function handle(subId:int, data:ByteArray):void
		{
			switch(subId)
			{
			case ACCOUNT_VERIFY_RPL_L2C:
				recvAccountVerifyRpl_L2C(data);
				break;
			case ACCOUNT_INFO_L2C:
				recvAccountInfo_L2C(data);
				break;
			case PLAYER_LIST_L2C:
				recvPlayerList_L2C(data);
				break;
			case PLAYER_CREATE_RPL_L2C:
				recvPlayerCreateRpl_L2C(data);
				break;
			}
		}
		
		/** send( client向login请求验证账号 ) */
		public function sendAccountVerifyReq_C2L(account:String, timestamp:String, sign:String):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, ACCOUNT_VERIFY_REQ_C2L, SidType.LOGIN);
			EndianFacade.writeMultiByte(mb.bytes, account);
			EndianFacade.writeMultiByte(mb.bytes, timestamp);
			EndianFacade.writeMultiByte(mb.bytes, sign);
			trace("account=" + account + " timestamp=" + timestamp + " sign=" + sign);
			mb.send();
		}
		
		/** recv( login向client回复验证账号的结果 ) */
		private function recvAccountVerifyRpl_L2C(data:ByteArray):void
		{
			var errorCode:int = EndianFacade.readInt(data);
			Centre.NET.clientBundleId = EndianFacade.readLong(data);
			LoginEC.print(errorCode);
		}
		
		/** recv( login向client发送的账号信息 ) */
		private function recvAccountInfo_L2C(data:ByteArray):void
		{
			var avo:StAccountInfo = new StAccountInfo();
			avo.readMsg(data);
			trace("recv( login向client发送的账号信息 ):" + avo);
		}
		
		/** recv( login向client发送的角色列表信息 ) */
		private function recvPlayerList_L2C(data:ByteArray):void
		{
			var pack:PlayerListPack = new PlayerListPack();
			pack.read(data);
			trace("recv( login向client发送的角色列表信息 )" + pack);
			Game.login.handlePlayerList(pack);
		}
		
		/** send( client向login请求新建角色 ) */
		public function sendPlayerCreateReq_C2L(account:String, name:String, sex:int):void
		{ 
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_CREATE_REQ_C2L, SidType.LOGIN);
			EndianFacade.writeMultiByte(mb.bytes, account);
			EndianFacade.writeMultiByte(mb.bytes, name);
			EndianFacade.writeByte(mb.bytes, sex);
			mb.send();
		}
		
		/** recv( login向client发送的新建角色的结果 ) */
		private function recvPlayerCreateRpl_L2C(data:ByteArray):void
		{
			var errorCode:int = EndianFacade.readInt(data);
			LoginEC.print(errorCode);
		}
		
		/** send( client向login请求选择角色进入 ) */
		public function sendPlayerSelectReq_C2L(playerUid:Long):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_SELECT_REQ_C2L, SidType.LOGIN);
			EndianFacade.writeLong(mb.bytes, playerUid);
			mb.send();
		}
		
		/** send( client向login请求删除角色 ) */
		public function sendPlayerDeleteReq_C2L(playerUid:Long):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_DELETE_REQ_C2L, SidType.LOGIN);
			EndianFacade.writeLong(mb.bytes, playerUid);
			mb.send();
		}
	}
}