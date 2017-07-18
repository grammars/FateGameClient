package net.msg.buff
{
	import central.Game;
	
	import cfg.SkillCfg;
	
	import comm.struct.buff.StBuff;
	
	import flash.utils.ByteArray;
	
	import gamekit.layer.Layer;
	
	import net.msg.IMessage;
	
	import res.Res;
	
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.EffectAvt;
	
	import ui.view.topTar.TopTarPane;
	
	public class BuffMsg extends IMessage
	{
		private static var instance:BuffMsg;
		public static function getInstance():BuffMsg
		{
			if(instance == null) { instance = new BuffMsg(); }
			return instance;
		}
		
		/** [Buff]主消息号 */
		public static const MID:int = BUFF_MID;
		
		/** game向client通知添加buff */
		private static const ADD_BUFF_G2C:int = 1;
		/** game向client通知移除buff */
		private static const REMOVE_BUFF_G2C:int = 2;
		/** game向client通知buff的一次作用 */
		private static const BUFF_USE_G2C:int = 5;
		
		public function BuffMsg()
		{
			super();
		}
		
		override public function handle(subId:int, data:ByteArray):void
		{
			switch(subId)
			{
			case ADD_BUFF_G2C:
				recvAddBuff_G2C(data);
				break;
			case REMOVE_BUFF_G2C:
				recvRemoveBuff_G2C(data);
				break;
			case BUFF_USE_G2C:
				recvBuffUse_G2C(data);
				break;
			}
		}
		
		/** recv( game向client通知添加buff ) */
		private function recvAddBuff_G2C(bytes:ByteArray):void
		{
			var buff:StBuff = new StBuff();
			buff.read(bytes);
			Game.buff.buffAdded(buff);
		}
		
		/** recv( game向client通知移除buff ) */
		private function recvRemoveBuff_G2C(bytes:ByteArray):void
		{
			var buff:StBuff = new StBuff();
			buff.read(bytes);
			Game.buff.buffRemoved(buff);
		}
		
		/** recv( game向client通知buff的一次作用 ) */
		private function recvBuffUse_G2C(bytes:ByteArray):void
		{
			var buff:StBuff = new StBuff();
			buff.read(bytes);
			
			//Game.info.notice("Buff作用 " + buff.causeSkillId);
//			var target:CreatureAvt = Game.scene.getCreature(buff.targetTid);
//			if(target)
//			{
//				var skillCfg:SkillCfg = SkillCfg.get(buff.causeSkillId);
//				
//				if(skillCfg.extAim && !Res.isNull(skillCfg.extAim.aimHitEffect))
//				{
//					var hitEff:EffectAvt = new EffectAvt(true);
//					hitEff.changeSkillEffect(skillCfg.extAim.aimHitEffect);
//					target.addChild(hitEff);
//				}
//			}
		}
		
	}
}