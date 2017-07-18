package net.msg.player
{
	import central.Centre;
	import central.Game;
	import central.View;
	
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.component.data.HeroData;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	
	import run.scene.avatar.PlayerAvt;
	
	import ui.view.heroAttri.HeroAttriFrame;

	public class PlayerDataMsg extends IMessage
	{
		private static var instance:PlayerDataMsg;
		public static function getInstance():PlayerDataMsg
		{
			if(instance == null) { instance = new PlayerDataMsg(); }
			return instance;
		}
		
		/** [角色数据]主消息号 */
		public static const MID:int = PLAYER_DATA_MID;
		
		/** login向client通知 game已准备好角色数据,已表示登录成功,让client重连到GateServer */
		private static const PLAYER_DATA_RPL_L2C:int = 3;
		
		/** game向client发送玩家初始化数据 */
		private static const PLAYER_INIT_DATA_G2C:int = 10;
		/** game向client发送玩家职业改变 */
		private static const PLAYER_VOC_CHANGE_G2C:int = 11;
		/** game相client发送玩家等级改变 */
		private static const PLAYER_LEVEL_CHANGE_G2C:int = 12;
		
		public function PlayerDataMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case PLAYER_DATA_RPL_L2C:
				recvPlayerDataRpl_L2C(bytes);
				break;
			case PLAYER_INIT_DATA_G2C:
				recvPlayerInitData_G2C(bytes);
				break;
			case PLAYER_VOC_CHANGE_G2C:
				recvPlayerVocChange_G2C(bytes);
				break;
			case PLAYER_LEVEL_CHANGE_G2C:
				recvPlayerLevelChange_G2C(bytes);
				break;
			}
		}
		
		/** recv( login向client通知 game已准备好角色数据,已表示登录成功,让client重连到GateServer ) */
		private function recvPlayerDataRpl_L2C(bytes:ByteArray):void
		{
			var notice:String = EndianFacade.readMultiByte(bytes);
			trace("recvPlayerDataRpl_L2C==>" + notice);
			
			Game.login.dispose();
			Centre.NET.connectGateSrv();
		}
		
		/** recv( game向client发送玩家初始化数据 ) */
		private function recvPlayerInitData_G2C(bytes:ByteArray):void
		{
			Game.hero.tid = EndianFacade.readInt(bytes);
			Game.hero.read(bytes);
			Game.data.heroInit();
		}
		
		/** recv( game向client发送玩家职业改变 ) */
		private function recvPlayerVocChange_G2C(bytes:ByteArray):void
		{
			var voc:int = EndianFacade.readByte(bytes);
			Game.hero.voc = voc;
			View.heroAttriFrame.updateBaseInfo();
		}
		
		/** recv( game向client发送玩家等级改变 ) */
		private function recvPlayerLevelChange_G2C(bytes:ByteArray):void
		{
			var playerTid:int = EndianFacade.readInt(bytes);
			var level:int = EndianFacade.readInt(bytes);
			var player:PlayerAvt = Game.scene.getPlayer(playerTid);
			if(player)
			{
				player.playerVO.level = level;
			}
			if(Game.isHeroByTid(playerTid))
			{
				Game.hero.level = level;
				View.heroAttriFrame.updateBaseInfo();
			}
		}
		
	}
}