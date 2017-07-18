package cfg
{
	import flash.utils.Dictionary;

	public class GoodsBaseCfg
	{
		public static const TYPE:String = "goods_base";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):GoodsBaseCfg
		{
			return cfgs[id];
		}
		
		/** id */
		public var id:int = 0;
		/** 物品名 */
		public var name:String = "";
		/** 类型 */
		public var type:int = 0;
		/** icon */
		public var icon:String = "";
		/** 要求等级下限 */
		public var reqLevMin:int = 0;
		/** 要求等级上限 */
		public var reqLevMax:int = 0;
		/** 要求职业 */
		public var reqVoc:int = 0;
		/** 说明 */
		public var desc:String = "";
		/** 最大堆叠数 */
		public var maxHeap:int = 1;
		/** 是否可召回 */
		public var canRecall:Boolean = true;
		/** 召回价 */
		public var recallPrice:int = 0;
		
		public function GoodsBaseCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:GoodsBaseCfg = new GoodsBaseCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["物品名"][i]);
				c.type = parseInt(dataDic["类型"][i]);
				c.icon =  (dataDic["icon"][i]);
				c.reqLevMin = parseInt(dataDic["要求等级下限"][i]);
				c.reqLevMax = parseInt(dataDic["要求等级上限"][i]);
				c.reqVoc = parseInt(dataDic["要求职业"][i]);
				c.desc = (dataDic["说明"][i]);
				c.maxHeap = parseInt(dataDic["最大堆叠数"][i]);
				c.canRecall = parseInt(dataDic["是否可召回"][i]) == 1;
				c.recallPrice = parseInt(dataDic["召回价"][i]);
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		public function toString():String
		{
			return "[GoodsBaseCfg] id:" + id + " name:" + name + " type=" + type
				+ " icon=" + icon + " reqLevMin=" + reqLevMin + " reqLevMax=" + reqLevMax
				+ " reqVoc=" + reqVoc + " desc=" + desc
				+ " maxHeap=" + maxHeap + " icanRecall" + canRecall + " recallPrice=" + recallPrice;
		}
		
	}
}