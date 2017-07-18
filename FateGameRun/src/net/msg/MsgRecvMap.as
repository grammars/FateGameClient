package net.msg
{
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.ByteBuffer;
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import net.msg.buff.BuffMsg;
	import net.msg.cd.CDMsg;
	import net.msg.common.CommonMsg;
	import net.msg.creature.CreatureMsg;
	import net.msg.fight.FightMsg;
	import net.msg.gm.GmMsg;
	import net.msg.goods.GoodsMsg;
	import net.msg.login.LoginMsg;
	import net.msg.npc.NpcMsg;
	import net.msg.player.PlayerDataMsg;
	import net.msg.player.PlayerEventMsg;
	import net.msg.practice.PracticeMsg;
	import net.msg.scene.SceneMsg;
	import net.msg.skill.SkillMsg;
	import net.msg.task.TaskMsg;
	
	import test.ctrls.GameConsole;

	public class MsgRecvMap
	{	
		/** 消息处理器map */
		private static var handlerMap:Dictionary = new Dictionary();
		/** 添加消息处理器 */
		public static function addHandler(mainId:int, handler:IMessage):void
		{
			handlerMap[mainId] = handler;
		}
		/** 移除消息处理器 */
		public static function removeHandler(mainId:int):void
		{
			delete handlerMap[mainId];
		}
		/** 获得消息处理器 */
		public static function getHandler(mainId:int):IMessage
		{
			return handlerMap[mainId];
		}
		
		public function MsgRecvMap()
		{
		}
		
		/** 初始化消息处理器 */
		public static function initHandlers():void
		{
			addHandler(LoginMsg.MID, LoginMsg.getInstance());
			addHandler(PlayerDataMsg.MID, PlayerDataMsg.getInstance());
			addHandler(PlayerEventMsg.MID, PlayerEventMsg.getInstance());
			addHandler(SceneMsg.MID, SceneMsg.getInstance());
			addHandler(FightMsg.MID, FightMsg.getInstance());
			addHandler(CreatureMsg.MID, CreatureMsg.getInstance());
			addHandler(BuffMsg.MID, BuffMsg.getInstance());
			addHandler(GoodsMsg.MID, GoodsMsg.getInstance());
			addHandler(SkillMsg.MID, SkillMsg.getInstance());
			addHandler(PracticeMsg.MID, PracticeMsg.getInstance());
			addHandler(TaskMsg.MID, TaskMsg.getInstance());
			addHandler(NpcMsg.MID, NpcMsg.getInstance());
			addHandler(CDMsg.MID, CDMsg.getInstance());
			addHandler(CommonMsg.MID, CommonMsg.getInstance());
			addHandler(GmMsg.MID, GmMsg.getInstance());
		}
		
		/** 处理消息分发 */
		public static function handle(message:ByteArray):void
		{
			GameConsole.getInstance().msgNumIncrease();
			if(message.bytesAvailable < 17)
			{
				Log.error("MsgRecvMap::handle 消息包长度错误 bytesAvailable=" + message.bytesAvailable);
				return;
			}
			var mainId:int = EndianFacade.readInt(message);
			var subId:int = EndianFacade.readInt(message);
			var target:int = EndianFacade.readByte(message);//服务器用的发送目标会话类型
			var clientBundleId:Long = EndianFacade.readLong(message);//服务器用的ClientBundleId
			Log.debug("MsgRecvMap::handle bId="+mainId+" subId="+subId);
			var handler:IMessage = getHandler(mainId);
			if(handler)
			{
				handler.handle(subId, message);
			}
			else
			{
				Log.error("MsgRecvMap::找不到对应的消息处理器,mainId="+mainId);
			}
		}
		
	}
}