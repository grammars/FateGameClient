package cfg
{
	import flash.utils.Dictionary;

	public class GoodsDrugCfg
	{
		public static const TYPE:String = "goods_drug";
		
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
		/** CD时间 */
		public var cdTime:int = 0;
		/** 比例生命值 */
		public var ratHp:Number = 0;
		/** 绝对生命值 */
		public var absHp:int = 0;
		/** 比例魔法值 */
		public var ratMp:Number = 0;
		/** 绝对魔法值 */
		public var absMp:int = 0;
		/** 增加Buff */
		public var addBuff:int = 0;
		
		public function GoodsDrugCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:GoodsDrugCfg = new GoodsDrugCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["物品名"][i]);
				c.cdTime = parseInt(dataDic["CD时间"][i]);
				c.ratHp = parseFloat(dataDic["比例生命值"][i]);
				c.absHp = parseInt(dataDic["绝对生命值"][i]);
				c.ratMp = parseFloat(dataDic["比例魔法值"][i]);
				c.absMp = parseInt(dataDic["绝对魔法值"][i]);
				c.addBuff = parseInt(dataDic["增加Buff"][i]);
				
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		public function toString():String
		{
			return "[GoodsDrugCfg] id:" + id + " name=" + name + " cdTime=" + cdTime
				+ " ratHp=" + ratHp + " absHp=" + absHp + " ratMp=" + ratMp 
				+ " absMp=" + absMp + " addBuff=" + addBuff;
		}
	}
}