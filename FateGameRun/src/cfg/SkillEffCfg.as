package cfg
{
	import flash.utils.Dictionary;

	public class SkillEffCfg
	{
		public static const TYPE:String = "skill_eff";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):SkillEffCfg
		{
			return cfgs[id];
		}
		
		/** 效果类型{伤害型} */
		public static const EFF_HARM:int = 0;
		/** 效果类型{治疗型} */
		public static const EFF_CURE:int = 1;
		
		/** 结算类型{真实伤害/治疗} */
		public static const CAL_REAL:int = 0;
		/** 结算类型{物理伤害} */
		public static const CAL_PHYSIC:int = 1;
		/** 结算类型{魔法伤害} */
		public static const CAL_MAGIC:int = 2;
		
		/** id */
		public var id:int = 0;
		/** 描述 */
		public var desc:String = "";
		/** 数值类型 */
		public var attriType:String = "";
		/** 结算类型 */
		public var calType:int = 0;
		/** 效果类型 */
		public var effType:int = 0;
		/** 效果基础值 */
		public var baseValue:int = 0;
		
		/** 效果因子施放者等级 */
		public var fUserLevel:Number = 0;
		/** 效果因子作用者等级 */
		public var fTarLevel:Number = 0;
		/** 效果因子技能等级 */
		public var fSkillLevel:Number = 0;
		
		/** 效果因子施放者当前生命值 */
		public var fUserCurHp:Number = 0;
		/** 效果因子作用者当前生命值 */
		public var fTarCurHp:Number = 0;
		/** 效果因子施放者生命值 */
		public var fUserHp:Number = 0;
		/** 效果因子作用者生命值 */
		public var fTarHp:Number = 0;
		
		/** 效果因子施放者当前魔法值 */
		public var fUserCurMp:Number = 0;
		/** 效果因子作用者当前魔法值 */
		public var fTarCurMp:Number = 0;
		/** 效果因子施放者魔法值 */
		public var fUserMp:Number = 0;
		/** 效果因子作用者魔法值 */
		public var fTarMp:Number = 0;
		
		/** 效果因子施放者攻击力 */
		public var fUserAttack:Number = 0;
		/** 效果因子作用者攻击力 */
		public var fTarAttack:Number = 0;
		/** 效果因子施放者攻击速度 */
		public var fUserAttackSpeed:Number = 0;
		/** 效果因子作用者攻击速度 */
		public var fTarAttackSpeed:Number = 0;
		/** 效果因子施放者护甲值 */
		public var fUserArmor:Number = 0;
		/** 效果因子作用者护甲值 */
		public var fTarArmor:Number = 0;
		/** 效果因子施放者护甲穿透 */
		public var fUserArmorPene:Number = 0;
		/** 效果因子作用者护甲穿透 */
		public var fTarArmorPene:Number = 0;
		/** 效果因子施放者法术强度 */
		public var fUserSpellPower:Number = 0;
		/** 效果因子作用者法术强度 */
		public var fTarSpellPower:Number = 0;
		/** 效果因子施放者法术免疫 */
		public var fUserSpellImmun:Number = 0;
		/** 效果因子作用者法术免疫 */
		public var fTarSpellImmun:Number = 0;
		/** 效果因子施放者法术穿透 */
		public var fUserSpellPene:Number = 0;
		/** 效果因子作用者法术穿透 */
		public var fTarSpellPene:Number = 0;
		
		public function SkillEffCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:SkillEffCfg = new SkillEffCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.desc = (dataDic["描述"][i]);
				c.attriType = (dataDic["数值类型"][i]);
				c.calType = parseInt(dataDic["结算类型"][i]);
				c.effType = parseInt(dataDic["效果类型"][i]);
				c.baseValue = parseInt(dataDic["效果基础值"][i]);
				c.fUserLevel = parseFloat(dataDic["效果因子施放者等级"][i]);
				c.fTarLevel = parseFloat(dataDic["效果因子作用者等级"][i]);
				c.fSkillLevel = parseFloat(dataDic["效果因子技能等级"][i]);
				c.fUserCurHp = parseFloat(dataDic["效果因子施放者当前生命值"][i]);
				c.fTarCurHp = parseFloat(dataDic["效果因子作用者当前生命值"][i]);
				c.fUserHp = parseFloat(dataDic["效果因子施放者生命值"][i]);
				c.fTarHp = parseFloat(dataDic["效果因子作用者生命值"][i]);
				c.fUserCurMp = parseFloat(dataDic["效果因子施放者当前魔法值"][i]);
				c.fTarCurMp = parseFloat(dataDic["效果因子作用者当前魔法值"][i]);
				c.fUserMp = parseFloat(dataDic["效果因子施放者魔法值"][i]);
				c.fTarMp = parseFloat(dataDic["效果因子作用者魔法值"][i]);
				c.fUserAttack = parseFloat(dataDic["效果因子施放者攻击力"][i]);
				c.fTarAttack = parseFloat(dataDic["效果因子作用者攻击力"][i]);
				c.fUserAttackSpeed = parseFloat(dataDic["效果因子施放者攻击速度"][i]);
				c.fTarAttackSpeed = parseFloat(dataDic["效果因子作用者攻击速度"][i]);
				c.fUserArmor = parseFloat(dataDic["效果因子施放者护甲值"][i]);
				c.fTarArmor = parseFloat(dataDic["效果因子作用者护甲值"][i]);
				c.fUserArmorPene = parseFloat(dataDic["效果因子施放者护甲穿透"][i]);
				c.fTarArmorPene = parseFloat(dataDic["效果因子作用者护甲穿透"][i]);
				c.fUserSpellPower = parseFloat(dataDic["效果因子施放者法术强度"][i]);
				c.fTarSpellPower = parseFloat(dataDic["效果因子作用者法术强度"][i]);
				c.fUserSpellImmun = parseFloat(dataDic["效果因子施放者法术免疫"][i]);
				c.fTarSpellImmun = parseFloat(dataDic["效果因子作用者法术免疫"][i]);
				c.fUserSpellPene = parseFloat(dataDic["效果因子施放者法术穿透"][i]);
				c.fTarSpellPene = parseFloat(dataDic["效果因子作用者法术穿透"][i]);
				
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		
		public function toString():String
		{
			return "[SkillEffCfg] id:" + id + " desc=" + desc + " attriType=" + attriType + 
				" calType=" + calType + " effType=" + effType + " baseValue=" + baseValue;
		}
	}
}