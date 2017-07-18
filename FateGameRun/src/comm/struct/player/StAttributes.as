package comm.struct.player
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class StAttributes
	{
		/** 属性类型{当前生命值} */
		public static const TYPE_CUR_HP:String = "curHp";
		/** 属性类型{当前魔法值} */
		public static const TYPE_CUR_MP:String = "curMp";
		/** 属性类型{生命值} */
		public static const TYPE_HP:String = "hp";
		/** 属性类型{魔法值} */
		public static const TYPE_MP:String = "mp";
		/** 属性类型{移动速度} */
		public static const TYPE_MOVE_SPEED:String = "moveSpeed";
		/** 属性类型{攻击力} */
		public static const TYPE_ATTACK:String = "attack";
		/** 属性类型{攻击速度} */
		public static const TYPE_ATTACK_SPEED:String = "attackSpeed";
		/** 属性类型{护甲值} */
		public static const TYPE_ARMOR:String = "armor";
		/** 属性类型{护甲穿透} */
		public static const TYPE_ARMOR_PENE:String = "armorPene";
		/** 属性类型{法术强度} */
		public static const TYPE_SPELL_POWER:String = "spellPower";
		/** 属性类型{法术免疫} */
		public static const TYPE_SPELL_IMMUN:String = "spellImmun";
		/** 属性类型{法术穿透} */
		public static const TYPE_SPELL_PENE:String = "spellPene";
		
		
		/** 生命值 */
		public var hp:int;
		/** 魔法值 */
		public var mp:int;
		
		/** 移动速度 */
		public var moveSpeed:int;
		
		/** 攻击力 */
		public var attack:int;
		/** 攻击速度 */
		public var attackSpeed:Number;
		/** 护甲值 */
		public var armor:int;
		/** 护甲穿透 */
		public var armorPene:int;
		
		/** 法术强度 */
		public var spellPower:int;
		/** 法术免疫 */
		public var spellImmun:int;
		/** 法术穿透 */
		public var spellPene:int;
		
		public function StAttributes()
		{
		}
		
		/** 从IoBuffer读出 */
		public function read(bytes:ByteArray):void
		{
			hp = EndianFacade.readInt(bytes);
			mp = EndianFacade.readInt(bytes);
			
			moveSpeed = EndianFacade.readInt(bytes);
			
			
			attack = EndianFacade.readInt(bytes);
			attackSpeed = EndianFacade.readFloat(bytes);
			armor = EndianFacade.readInt(bytes);
			armorPene = EndianFacade.readInt(bytes);
			
			spellPower = EndianFacade.readInt(bytes);
			spellImmun = EndianFacade.readInt(bytes);
			spellPene = EndianFacade.readInt(bytes);
		}
		
		/** clone */
		public function clone(vo:StAttributes):void
		{
			this.hp = vo.hp;
			this.mp = vo.mp;
			
			this.moveSpeed = vo.moveSpeed;
			
			this.attack = vo.attack;
			this.attackSpeed = vo.attackSpeed;
			this.armor = vo.armor;
			this.armorPene = vo.armorPene;
			
			this.spellPower = vo.spellPower;
			this.spellImmun = vo.spellImmun;
			this.spellPene = vo.spellPene;
		}
		
		public function toString():String
		{
			return "[AttriAbility] hp=" + hp + " mp=" + mp +
				" moveSpeed=" + moveSpeed + 
				" attack=" + attack + " attackSpeed=" + attackSpeed +
				" armor=" + armor + " armorPenetration=" + armorPene + 
				" spellPower=" + spellPower + " spellImmunity=" + spellImmun +
				" spellPenetration=" + spellPene;
		}
		
	}
}