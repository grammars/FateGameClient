package cfg
{
	import flash.utils.Dictionary;

	public class GoodsEquipCfg
	{
		public static const TYPE:String = "goods_equip";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):GoodsEquipCfg
		{
			return cfgs[id];
		}
		
		/** id */
		public var id:int = 0;
		/** 物品名 */
		public var name:String = "";
		/** 装备类型 */
		public var type:int = 0;
		/** 武器外观 */
		public var look:String = "";
		/** 基础生命值 */
		public var baseHp:int = 0;
		/** 基础魔法值 */
		public var baseMp:int = 0;
		/** 基础移动速度 */
		public var baseMoveSpeed:int = 0;
		/** 基础攻击力 */
		public var baseAttack:int = 0;
		/** 基础攻击速度 */
		public var baseAttackSpeed:Number = 0;
		/** 基础护甲值 */
		public var baseArmor:int = 0;
		/** 基础护甲穿透 */
		public var baseArmorPene:int = 0;
		/** 基础法术强度 */
		public var baseSpellPower:int = 0;
		/** 基础法术免疫 */
		public var baseSpellImmun:int = 0;
		/** 基础法术穿透 */
		public var baseSpellPene:int = 0;
		/** 宝石孔数 */
		public var gemHoleNum:int = 0;
		
		public function GoodsEquipCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:GoodsEquipCfg = new GoodsEquipCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["物品名"][i]);
				c.type = parseInt(dataDic["装备类型"][i]);
				c.look = (dataDic["武器外观"][i]);
				c.baseHp = parseInt(dataDic["基础生命值"][i]);
				c.baseMp = parseInt(dataDic["基础魔法值"][i]);
				c.baseMoveSpeed = parseInt(dataDic["基础移动速度"][i]);
				c.baseAttack = parseInt(dataDic["基础攻击力"][i]);
				c.baseAttackSpeed = parseFloat(dataDic["基础攻击速度"][i]);
				c.baseArmor = parseInt(dataDic["基础护甲值"][i]);
				c.baseArmorPene = parseInt(dataDic["基础护甲穿透"][i]);
				c.baseSpellPower = parseInt(dataDic["基础法术强度"][i]);
				c.baseSpellImmun = parseInt(dataDic["基础法术免疫"][i]);
				c.baseSpellPene = parseInt(dataDic["基础法术穿透"][i]);
				c.gemHoleNum = parseInt(dataDic["宝石孔数"][i]);
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		public function toString():String
		{
			return "[GoodsEquipCfg] id:" + id + " name=" + name + " type=" + type + " look=" + look
				+ " baseHp=" + baseHp + " baseMp=" + baseMp + " baseMoveSpeed=" + baseMoveSpeed 
				+ " baseAttack=" + baseAttack + " baseAttackSpeed=" + baseAttackSpeed
				+ " baseArmor=" + baseArmor + " baseArmorPene=" + baseArmorPene
				+ " baseSpellPower=" + baseSpellPower + " baseSpellImmun=" + baseSpellImmun
				+ " baseSpellPene=" + baseSpellPene + " gemHoleNum=" + gemHoleNum;
		}
	}
}