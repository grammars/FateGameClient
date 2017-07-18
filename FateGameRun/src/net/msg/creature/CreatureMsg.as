package net.msg.creature
{
	import central.Game;
	import central.View;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.struct.player.StAttributes;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.action.HpChangeEffect;
	
	import ui.view.heroAttri.HeroAttriFrame;
	
	public class CreatureMsg extends IMessage
	{
		private static var instance:CreatureMsg;
		public static function getInstance():CreatureMsg
		{
			if(instance == null) { instance = new CreatureMsg(); }
			return instance;
		}
		
		/** [生物数据]主消息号 */
		public static const MID:int = CREATURE_MID;
		
		/** game发送给client 改变当前生命值 */
		private static const CHANGE_CUR_HP_G2C:int = 1;
		/** game发送给client 改变当前魔法值 */
		private static const CHANGE_CUR_MP_G2C:int = 2;
		/** game发送给client 改变生命值 */
		private static const CHANGE_HP_G2C:int = 3;
		/** game发送给client 改变魔法值 */
		private static const CHANGE_MP_G2C:int = 4;
		/** game发送给client 改变移动速度 */
		private static const CHANGE_MOVE_SPEED_G2C:int = 5;
		/** game发送给client 改变攻击力 */
		private static const CHANGE_ATTACK_G2C:int = 6;
		/** game发送给client 改变攻击速度 */
		private static const CHANGE_ATTACK_SPEED_G2C:int = 7;
		/** game发送给client 改变护甲值 */
		private static const CHANGE_ARMOR_G2C:int = 8;
		/** game发送给client 改变护甲穿透 */
		private static const CHANGE_ARMOR_PENETRATION_G2C:int = 9;
		/** game发送给client 改变法术强度 */
		private static const CHANGE_SPELL_POWER_G2C:int = 10;
		/** game发送给client 改变法术免疫 */
		private static const CHANGE_SPELL_IMMUNITY_G2C:int = 11;
		/** game发送给client 改变法术穿透 */
		private static const CHANGE_SPELL_PENETRATION_G2C:int = 12;
		
		public function CreatureMsg()
		{
			super();
		}
		
		override public function handle(subId:int, data:ByteArray):void
		{
			switch(subId)
			{
			case CHANGE_CUR_HP_G2C:
				recvChangeCurHp_G2C(data);
				break;
			case CHANGE_CUR_MP_G2C:
				recvChangeCurMp_G2C(data);
				break;
			case CHANGE_HP_G2C:
				recvChangeHp_G2C(data);
				break;
			case CHANGE_MP_G2C:
				recvChangeMp_G2C(data);
				break;
			case CHANGE_MOVE_SPEED_G2C:
				recvChangeMoveSpeed_G2C(data);
				break;
			case CHANGE_ATTACK_G2C:
				recvChangeAttack_G2C(data);
				break;
			case CHANGE_ATTACK_SPEED_G2C:
				recvChangeAttackSpeed_G2C(data);
				break;
			case CHANGE_ARMOR_G2C:
				recvChangeArmor_G2C(data);
				break;
			case CHANGE_ARMOR_PENETRATION_G2C:
				recvChangeArmorPenetration_G2C(data);
				break;
			case CHANGE_SPELL_POWER_G2C:
				recvChangeSpellPower_G2C(data);
				break;
			case CHANGE_SPELL_IMMUNITY_G2C:
				recvChangeSpellImmunity_G2C(data);
				break;
			case CHANGE_SPELL_PENETRATION_G2C:
				recvChangeSpellPenetration_G2C(data);
				break;
			}
		}
		
		/** recv( game发送给client 改变当前生命值 ) */
		private function recvChangeCurHp_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeCurHpTo(value);
				cret.updateAttri();
				HpChangeEffect.show(cret, delt);
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeCurHpTo(value);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_CUR_HP);
			}
		}
		
		/** recv( game发送给client 改变当前魔法值 ) */
		private function recvChangeCurMp_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeCurMpTo(value);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeCurMpTo(value);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_CUR_MP);
			}
		}
		
		/** recv( game发送给client 改变生命值 ) */
		private function recvChangeHp_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeHpTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeHpTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_HP);
			}
		}
		
		/** recv( game发送给client 改变魔法值 ) */
		private function recvChangeMp_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeMpTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeMpTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_MP);
			}
		}
		
		/** recv( game发送给client 改变移动速度 ) */
		private function recvChangeMoveSpeed_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeMoveSpeedTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeMoveSpeedTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_MOVE_SPEED);
			}
		}
		
		/** recv( game发送给client 改变攻击力 ) */
		private function recvChangeAttack_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeAttackTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeAttackTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_ATTACK);
			}
		}
		
		/** recv( game发送给client 改变攻击速度 ) */
		private function recvChangeAttackSpeed_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:Number = EndianFacade.readFloat(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeAttackSpeedTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeAttackSpeedTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_ATTACK_SPEED);
			}
		}
		
		/** recv( game发送给client 改变护甲值 ) */
		private function recvChangeArmor_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeArmorTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeArmorTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_ARMOR);
			}
		}
		
		/** recv( game发送给client 改变护甲穿透 ) */
		private function recvChangeArmorPenetration_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeArmorPeneTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeArmorPeneTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_ARMOR_PENE);
			}
		}
		
		/** recv( game发送给client 改变法术强度 ) */
		private function recvChangeSpellPower_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeSpellPowerTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeSpellPowerTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_SPELL_POWER);
			}
		}
		
		/** recv( game发送给client 改变法术免疫 ) */
		private function recvChangeSpellImmunity_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeSpellImmunTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeSpellImmunTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_SPELL_IMMUN);
			}
		}
		
		/** recv( game发送给client 改变法术穿透 ) */
		private function recvChangeSpellPenetration_G2C(data:ByteArray):void
		{
			var spriteId:int = EndianFacade.readInt(data);
			var src:int = EndianFacade.readByte(data);
			var value:int = EndianFacade.readInt(data);
			var delt:int = EndianFacade.readInt(data);
			var cret:CreatureAvt = Game.scene.getCreature(spriteId);
			if(cret)
			{
				cret.creatureVO.attris.changeSpellPeneTo(value, src);
				cret.updateAttri();
			}
			if(Game.isHeroByTid(spriteId))
			{
				Game.hero.attris.changeSpellPeneTo(value, src);
				View.heroAttriFrame.updateAttri(StAttributes.TYPE_SPELL_PENE);
			}
		}
		
	}
}