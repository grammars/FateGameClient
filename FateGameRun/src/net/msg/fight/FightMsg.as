package net.msg.fight
{
	import central.Centre;
	import central.Game;
	
	import cfg.SkillCfg;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.skill.SkillItem;
	import comm.define.DeathCause;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import gamekit.avatar.ActionType;
	import gamekit.layer.Layer;
	
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	import net.msg.scene.SceneMsgUtils;
	
	import res.Res;
	
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.EffectAvt;
	import run.scene.avatar.SpriteAvt;
	import run.scene.avatar.action.HpChangeEffect;
	
	import test.ctrls.GameConsole;

	public class FightMsg extends IMessage
	{
		private static var instance:FightMsg;
		public static function getInstance():FightMsg
		{
			if(instance == null) { instance = new FightMsg(); }
			return instance;
		}
		
		/** [战斗]主消息号 */
		public static const MID:int = FIGHT_MID;
		
		/** client向game请求改变PK模式  */
		private static const CHANGE_PKMODE_REQ_C2G:int = 1;
		/** game向client通知改变PK模式  */
		private static const PKMODE_INFO_G2C:int = 2;

		/** client向game通知预备普通攻击 */
		private static const PLAYER_HIT_PREPARE_C2G:int = 11;
		/** game向client通知预备普通攻击 */
		private static const CRET_HIT_PREPARE_G2C:int = 12;
		/** client向game通知执行普通攻击 */
		private static const PLAYER_HIT_EXECUTE_C2G:int = 13;
		/** game向client通知执行普通攻击 */
		private static const CRET_HIT_EXECUTE_G2C:int = 14;
		
		/** client向game通知预备Aim技能 */
		private static const PLAYER_SKILL_AIM_PREPARE_C2G:int = 21;
		/** game向client通知预备Aim技能 */
		private static const CRET_SKILL_AIM_PREPARE_G2C:int = 22;
		/** client向game通知执行Aim技能 */
		private static const PLAYER_SKILL_AIM_EXECUTE_C2G:int = 23;
		/** game向client通知执行Aim技能 */
		private static const CRET_SKILL_AIM_EXECUTE_G2C:int = 24;
		
		/** client向game请求施放Aoe技能 */
		private static const PLAYER_SKILL_AOE_FIRE_C2G:int = 25;
		
		/** game向client通知技能完成了一次作用 */
		private static const SKILL_EFFECT_G2C:int = 30;
		/** game向client发送技能不满足施放条件的提示 */
		private static const PLAYER_SKILL_UNAVAILABLE:int = 39;
		
		/** game向client发送Creature死亡通知 */
		private static const CRET_DEAD_INFO_G2C:int = 40;
		/** game向client发送Player死亡通知 */
		private static const PLAYER_DEAD_INFO_G2C:int = 41;
		/** client向game发送Player复活的请求 */
		private static const PLAYER_REBIRTH_REQ_C2G:int = 42;
		/** game向client发送Player复活的结果 */
		private static const PLAYER_REBIRTH_RPL_G2C:int = 43;
		
		public function FightMsg()
		{
			super();
		}
		
		override public function handle(subId:int, data:ByteArray):void
		{
			switch(subId)
			{
			case PKMODE_INFO_G2C:
				recvPkModeInfo_G2C(data);
				break;

			case CRET_HIT_PREPARE_G2C:
				recvCretHitPrepare_G2C(data);
				break;
			case CRET_HIT_EXECUTE_G2C:
				recvCretHitExecute_G2C(data);
				break;
			
			case CRET_SKILL_AIM_PREPARE_G2C:
				recvCretSkillAimPrepare_G2C(data);
				break;
			case CRET_SKILL_AIM_EXECUTE_G2C:
				recvSkillAimExecute_G2C(data);
				break;
			
			case SKILL_EFFECT_G2C:
				recvSkillEffect_G2C(data);
				break;
			case PLAYER_SKILL_UNAVAILABLE:
				recvPlayerSkillUnavailable(data);
				break;
			
			case CRET_DEAD_INFO_G2C:
				recvCretDeadInfo_G2C(data);
				break;
			case PLAYER_DEAD_INFO_G2C:
				recvPlayerDeadInfo_G2C(data);
				break;
			case PLAYER_REBIRTH_RPL_G2C:
				recvPlayerRebirthRpl_G2C(data);
				break;
			}
		}
		
		/** send( client向game请求改变PK模式 ) */
		public function sendChangePkModeReq_C2G(mode:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, CHANGE_PKMODE_REQ_C2G);
			EndianFacade.writeInt(mb.bytes, mode);
			mb.send();
		}
		
		/** recv( game向client通知改变PK模式 ) */
		private function recvPkModeInfo_G2C(data:ByteArray):void
		{
			var mode:int = EndianFacade.readInt(data);
			Game.fight.setPkMode(mode);
		}
		
		/** send( client向game通知预备普通攻击 ) */
		public function sendPlayerHitPrepare_C2G(tarId:int, face:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_HIT_PREPARE_C2G);
			EndianFacade.writeInt(mb.bytes, tarId);
			EndianFacade.writeByte(mb.bytes, face);
			mb.send();
		}
		
		/** recv( game向client通知预备普通攻击 ) */
		private function recvCretHitPrepare_G2C(data:ByteArray):void
		{
			var attackerId:int = EndianFacade.readInt(data);
			var face:int = EndianFacade.readByte(data);
			var attacker:CreatureAvt = Game.scene.getCreature(attackerId);
			if(attacker)
			{
				attacker.setDirection(face);
				attacker.playAction(ActionType.HIT, true);
			}
		}
		
		/** send( client向game通知执行普通攻击 ) */
		public function sendPlayerHitExecute_C2G(tarId:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_HIT_EXECUTE_C2G);
			EndianFacade.writeInt(mb.bytes, tarId);
			mb.send();
		}
		
		/** recv( game向client通知执行普通攻击 ) */
		private function recvCretHitExecute_G2C(data:ByteArray):void
		{
			var attackerId:int = EndianFacade.readInt(data);
			var targetId:int = EndianFacade.readInt(data);
			Game.fight.hit.playHitFly(attackerId, targetId);
		}
		
		/** client向game通知预备Aim技能 */
		public function sendPlayerSkillAimPrepare_C2G(si:SkillItem, face:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_SKILL_AIM_PREPARE_C2G);
			EndianFacade.writeInt(mb.bytes, si.id);
			EndianFacade.writeByte(mb.bytes, face);
			mb.send();
		}
		
		/** recv( game向client通知预备Aim技能 ) */
		private function recvCretSkillAimPrepare_G2C(data:ByteArray):void
		{
			var userId:int = EndianFacade.readInt(data);
			var face:int = EndianFacade.readByte(data);
			var user:CreatureAvt = Game.scene.getCreature(userId);
			if(user)
			{
				user.setDirection(face);
				user.playAction(ActionType.MAGIC_SING, true);
			}
		}
		
		/** send( client向game通知执行Aim技能 ) */
		public function sendPlayerSkillAimExecute_C2G(skillId:int, tarTid:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_SKILL_AIM_EXECUTE_C2G);
			EndianFacade.writeInt(mb.bytes, skillId);
			EndianFacade.writeInt(mb.bytes, tarTid);
			mb.send();
		}
		
		/** recv( game向client通知执行Aim技能 ) */
		private function recvSkillAimExecute_G2C(data:ByteArray):void
		{
			var userTid:int = EndianFacade.readInt(data);
			var targetCount:int = EndianFacade.readInt(data);
			var tarIds:Array = new Array();
			for(var i:int = 0; i < targetCount; i++)
			{
				tarIds.push( EndianFacade.readInt(data) ); 
			}
			var skillId:int = EndianFacade.readInt(data);
			
			Game.fight.aim.playSkillFly(userTid, tarIds, skillId);
		}
		
		/** client向game请求施放Aoe技能 */
		public function sendPlayerSkillAoeFire_C2G(skillId:int, fireGX:int, fireGY:int, face:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_SKILL_AOE_FIRE_C2G);
			EndianFacade.writeInt(mb.bytes, skillId);
			EndianFacade.writeInt(mb.bytes, fireGX);
			EndianFacade.writeInt(mb.bytes, fireGY);
			EndianFacade.writeByte(mb.bytes, face);
			mb.send();
		}
		
		/** recv( game向client通知技能完成了一次作用 ) */
		private function recvSkillEffect_G2C(data:ByteArray):void
		{
			Game.info.notice("技能完成了一次作用");
			var tarTid:int = EndianFacade.readInt(data);
			var skillId:int = EndianFacade.readInt(data);
			var skillLev:int = EndianFacade.readInt(data);
			var target:CreatureAvt = Game.scene.getCreature(tarTid);
			if(target)
			{
				var skillCfg:SkillCfg = SkillCfg.get(skillId);
				
				if(skillCfg.extAim && !Res.isNull(skillCfg.extAim.aimHitEffect))
				{
					var hitEff:EffectAvt = new EffectAvt(true);
					hitEff.changeSkillEffect(skillCfg.extAim.aimHitEffect);
					target.addChild(hitEff);
				}
			}
		}
		
		/** recv( game向client发送技能不满足施放条件的提示 ) */
		private function recvPlayerSkillUnavailable(data:ByteArray):void
		{
			Game.info.notice("不满足技能释放条件");
			Game.fight.aim.killUse();
		}
		
		/** recv( game向client发送Creature死亡通知 ) */
		private function recvCretDeadInfo_G2C(data:ByteArray):void
		{
			var deadTid:int = EndianFacade.readInt(data);
			var src:SpriteAvt = Game.scene.getSprite(deadTid);
			if(src && src.isCreature)
			{
				var cret:CreatureAvt = src as CreatureAvt;
				cret.dead();
			}
		}
		
		/** recv( game向client发送Player死亡通知 ) */
		private function recvPlayerDeadInfo_G2C(bytes:ByteArray):void
		{
			var deathCause:int = EndianFacade.readByte(bytes);
			var killerName:String = EndianFacade.readMultiByte(bytes);
			switch(deathCause)
			{
			case DeathCause.DEFAULT:
				Game.data.heroBeenKilled(killerName);
				break;
			default:
				Game.data.heroBeenKilled(killerName);
				break;
			}
		}
		
		/** send( client向game发送Player复活的请求 ) */
		public function sendPlayerRebirthReq_C2G(rebirthWay:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PLAYER_REBIRTH_REQ_C2G);
			EndianFacade.writeByte(mb.bytes, rebirthWay);
			mb.send();
		}
		
		/** recv( game向client发送Player复活的结果 ) */
		private function recvPlayerRebirthRpl_G2C(data:ByteArray):void
		{
			var srcTid:int = EndianFacade.readInt(data);
			var errCode:int = EndianFacade.readByte(data);
			Game.rebirth.rebirthResult(srcTid, errCode);
		}
		
	}
}