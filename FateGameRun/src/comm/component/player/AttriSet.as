package comm.component.player
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.struct.player.StAttriSet;
	import comm.struct.player.StAttributes;
	
	import flash.utils.ByteArray;

	public class AttriSet extends StAttriSet
	{
		//==属性统计BEGIN=========
		
		/** 当前生命值 */
		public function curHp():int { return current.hp; }
		/** 当前魔法值 */
		public function curMp():int { return current.mp; }
		
		/** 生命值 */
		public function hp():int { return ( base.hp + equip.hp + skill.hp + buff.hp ); }
		/** 魔法值 */
		public function mp():int { return ( base.mp + equip.mp + skill.mp + buff.mp ); }
		
		/** 移动速度 */
		public function moveSpeed():int { return ( base.moveSpeed + equip.moveSpeed + skill.moveSpeed + buff.moveSpeed ); }
		
		/** 攻击力 */
		public function attack():int { return ( base.attack + equip.attack + skill.attack + buff.attack ); }
		/** 攻击速度 */
		public function attackSpeed():Number { return ( base.attackSpeed + equip.attackSpeed + skill.attackSpeed + buff.attackSpeed ); }
		/** 护甲值  */
		public function armor():int { return ( base.armor + equip.armor + skill.armor + buff.armor ); }
		/** 护甲穿透  */
		public function armorPene():int { return ( base.armorPene + equip.armorPene + skill.armorPene + buff.armorPene ); }
		
		/** 法术强度 */
		public function spellPower():int { return ( base.spellPower + equip.spellPower + skill.spellPower + buff.spellPower ); }
		/** 法术免疫 */
		public function spellImmun():int { return ( base.spellImmun + equip.spellImmun + skill.spellImmun + buff.spellImmun ); }
		/** 法术穿透 */
		public function spellPene():int { return ( base.spellPene + equip.spellPene + skill.spellPene + buff.spellPene ); }
		
		//===========属性统计END==
		
		public function AttriSet()
		{
		}
		
		/** 根据属性源类型获得属性 */
		private function getAttri(src:int):StAttributes
		{
			switch(src)
			{
			case SRC_BASE: return base;
			case SRC_EQUIP: return equip;
			case SRC_SKILL: return skill;
			case SRC_BUFF: return buff;
			}
			return null;
		}
		
		//===属性改变BEG==============
		
		/** 改变当前生命值 */
		public function changeCurHp(delt:int):void
		{
			current.hp += delt;
			if(current.hp >= hp()) { current.hp = hp(); }
		}
		public function changeCurHpTo(value:int):void
		{
			var delt:int = value - current.hp;
			changeCurHp(delt);
		}
		
		/** 改变当前魔法值 */
		public function changeCurMp(delt:int):void
		{
			current.mp += delt;
			if(current.mp >= mp()) { current.mp = mp(); }
		}
		public function changeCurMpTo(value:int):void
		{
			var delt:int = value - current.mp;
			changeCurMp(delt);
		}
		
		/** 改变生命值 */
		public function changeHp(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.hp += delt;
		}
		public function changeHpTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).hp;
			changeHp(delt, src);
		}
		
		/** 改变魔法值 */
		public function changeMp(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.mp += delt;
		}
		public function changeMpTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).mp;
			changeMp(delt, src);
		}
		
		/** 改变移动速度 */
		public function changeMoveSpeed(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.moveSpeed += delt;
		}
		public function changeMoveSpeedTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).moveSpeed;
			changeMoveSpeed(delt, src);
		}
		
		/** 改变攻击力 */
		public function changeAttack(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.attack += delt;
		}
		public function changeAttackTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).attack;
			changeAttack(delt, src);
		}
		
		/** 改变攻击速度 */
		public function changeAttackSpeed(delt:Number, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.attackSpeed += delt;
		}
		public function changeAttackSpeedTo(value:Number, src:int):void
		{
			var delt:Number = value - getAttri(src).attackSpeed;
			changeAttackSpeed(delt, src);
		}
		
		/** 改变护甲值 */
		public function changeArmor(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.armor += delt;
		}
		public function changeArmorTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).armor;
			changeArmor(delt, src);
		}
		
		/** 改变护甲穿透 */
		public function changeArmorPene(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.armorPene += delt;
		}
		public function changeArmorPeneTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).armorPene;
			changeArmorPene(delt, src);
		}
		
		/** 改变法术强度 */
		public function changeSpellPower(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.spellPower += delt;
		}
		public function changeSpellPowerTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).spellPower;
			changeSpellPower(delt, src);
		}
		
		/** 改变法术免疫 */
		public function changeSpellImmun(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.spellImmun += delt;
		}
		public function changeSpellImmunTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).spellImmun;
			changeSpellImmun(delt, src);
		}
		
		/** 改变法术穿透 */
		public function changeSpellPene(delt:int, src:int):void
		{
			var attri:StAttributes = getAttri(src);
			attri.spellPene += delt;
		}
		public function changeSpellPeneTo(value:int, src:int):void
		{
			var delt:int = value - getAttri(src).spellPene;
			changeSpellPene(delt, src);
		}
		
		//==============属性改变END===
		
		
		
	}
}