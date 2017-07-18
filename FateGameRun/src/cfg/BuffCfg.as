package cfg
{
	import flash.utils.Dictionary;

	public class BuffCfg
	{
		public static const TYPE:String = "buff";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):BuffCfg
		{
			return cfgs[id];
		}
		
		/** 立即生效的buff */
		public static const TYPE_IMM:int = 0;
		/** 逐步生效的buff */
		public static const TYPE_GRAD:int = 1;
		
		/** id */
		public var id:int = 0;
		/** 名称 */
		public var name:String = "";
		/** 类型 */
		public var type:int = 0;
		/** 是否存储 */
		public var needStore:Boolean = false;
		/** 最大叠加数 */
		public var maxStack:int = 0;
		/** 描述 */
		public var desc:String = "";
		
		/** 持续时间 */
		public var duration:int = 0;
		/** 作用延迟 */
		public var delay:int = 0;
		/** 作用间隔 */
		public var interval:int = 0;
		/** icon */
		public var icon:String = "";
		/** 身上特效 */
		public var effect:String = "";
		
		/** 比例当前生命值 */
		public var ratCurHp:Number = 0;
		/** 绝对当前生命值 */
		public var absCurHp:Number = 0;
		/** 比例当前魔法值 */
		public var ratCurMp:Number = 0;
		/** 绝对当前魔法值 */
		public var absCurMp:Number = 0;
		/** 比例生命值 */
		public var ratHp:Number = 0;
		/** 绝对生命值 */
		public var absHp:Number = 0;
		/** 比例魔法值 */
		public var ratMp:Number = 0;
		/** 绝对魔法值 */
		public var absMp:Number = 0;
		/** 比例移动速度 */
		public var ratMoveSpeed:Number = 0;
		/** 绝对移动速度 */
		public var absMoveSpeed:Number = 0;
		/** 比例攻击力 */
		public var ratAttack:Number = 0;
		/** 绝对攻击力 */
		public var absAttack:Number = 0;
		/** 比例攻击速度 */
		public var ratAttackSpeed:Number = 0;
		/** 绝对攻击速度 */
		public var absAttackSpeed:Number = 0;
		/** 比例护甲值 */
		public var ratArmor:Number = 0;
		/** 绝对护甲值 */
		public var absArmor:Number = 0;
		/** 比例护甲穿透 */
		public var ratArmorPene:Number = 0;
		/** 绝对护甲穿透 */
		public var absArmorPene:Number = 0;
		/** 比例法术强度 */
		public var ratSpellPower:Number = 0;
		/** 绝对法术强度 */
		public var absSpellPower:Number = 0;
		/** 比例法术免疫 */
		public var ratSpellImmun:Number = 0;
		/** 绝对法术免疫 */
		public var absSpellImmun:Number = 0;
		/** 比例法术穿透 */
		public var ratSpellPene:Number = 0;
		/** 绝对法术穿透 */
		public var absSpellPene:Number = 0;
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:BuffCfg = new BuffCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["名称"][i]);
				c.type = parseInt(dataDic["类型"][i]);
				c.needStore = parseInt(dataDic["是否存储"][i]) == 1;
				c.maxStack =  parseInt(dataDic["最大叠加数"][i]);
				c.desc = (dataDic["描述"][i]);
				c.duration = parseInt(dataDic["持续时间"][i]);
				c.delay = parseInt(dataDic["作用延迟"][i]);
				c.interval = parseInt(dataDic["作用间隔"][i]);
				c.icon = (dataDic["icon"][i]);
				c.effect = (dataDic["身上特效"][i]);
				c.ratCurHp = parseFloat(dataDic["比例当前生命值"][i]);
				c.absCurHp = parseFloat(dataDic["绝对当前生命值"][i]);
				c.ratCurMp = parseFloat(dataDic["比例当前魔法值"][i]);
				c.absCurMp = parseFloat(dataDic["绝对当前魔法值"][i]);
				c.ratHp = parseFloat(dataDic["比例生命值"][i]);
				c.absHp = parseFloat(dataDic["绝对生命值"][i]);
				c.ratMp = parseFloat(dataDic["比例魔法值"][i]);
				c.absMp = parseFloat(dataDic["绝对魔法值"][i]);
				c.ratMoveSpeed = parseFloat(dataDic["比例移动速度"][i]);
				c.absMoveSpeed = parseFloat(dataDic["绝对移动速度"][i]);
				c.ratAttack = parseFloat(dataDic["比例攻击力"][i]);
				c.absAttack = parseFloat(dataDic["绝对攻击力"][i]);
				c.ratAttackSpeed = parseFloat(dataDic["比例攻击速度"][i]);
				c.absAttackSpeed = parseFloat(dataDic["绝对攻击速度"][i]);
				c.ratArmor = parseFloat(dataDic["比例护甲值"][i]);
				c.absArmor = parseFloat(dataDic["绝对护甲值"][i]);
				c.ratArmorPene = parseFloat(dataDic["比例护甲穿透"][i]);
				c.absArmorPene = parseFloat(dataDic["绝对护甲穿透"][i]);
				c.ratSpellPower = parseFloat(dataDic["比例法术强度"][i]);
				c.absSpellPower = parseFloat(dataDic["绝对法术强度"][i]);
				c.ratSpellImmun = parseFloat(dataDic["比例法术免疫"][i]);
				c.absSpellImmun = parseFloat(dataDic["绝对法术免疫"][i]);
				c.ratSpellPene = parseFloat(dataDic["比例法术穿透"][i]);
				c.absSpellPene = parseFloat(dataDic["绝对法术穿透"][i]);
				//trace(c);
				cfgs[c.id] = c;
			}
		}
				
		public function toString():String
		{
			return "[BuffCfg] id:" + id + " name:" + name + " needStore=" + needStore
				+ " maxStack=" + maxStack + " desc=" + desc + " duration=" + duration
				+ " interval=" + interval + " icon=" + icon + " effect=" + effect
				+ " ratCurHp=" + ratCurHp + " absCurHp=" + absCurHp
				+ " ratCurMp=" + ratCurMp + " absCurMp=" + absCurMp
				+ " ratHp=" + ratHp + " absHp=" + absHp + " ratMp=" + ratMp + " absMp=" + absMp
				+ " ratMoveSpeed=" + ratMoveSpeed + " absMoveSpeed=" + absMoveSpeed 
				+ " ratAttack=" + ratAttack + " absAttack=" + absAttack
				+ " ratAttackSpeed=" + ratAttackSpeed + " absAttackSpeed=" + absAttackSpeed 
				+ " ratArmor=" + ratArmor + " absArmor=" + absArmor
				+ " ratArmorPene=" + ratArmorPene + " absArmorPene=" + absArmorPene
				+ " ratSpellPower=" + ratSpellPower + " absSpellPower=" + absSpellPower
				+ " ratSpellImmun=" + ratSpellImmun + " absSpellImmun=" + absSpellImmun
				+ " ratSpellPene=" + ratSpellPene + " absSpellPene=" + absSpellPene;
		}
	}
}