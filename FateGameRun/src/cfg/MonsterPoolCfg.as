package cfg
{
	import flash.utils.Dictionary;
	
	public class MonsterPoolCfg
	{
		public static const TYPE:String = "monster_pool";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):MonsterPoolCfg
		{
			return cfgs[id];
		}
		
		private static var arr:Array = new Array();
		/** 获得能够产生指定怪物的怪物池 */
		public static function getForMonster(monsterId:int):MonsterPoolCfg
		{
			for(var i:int = 0; i < arr.length; i++)
			{
				var c:MonsterPoolCfg = arr[i];
				if(c.monsterId == monsterId) { return c; }
			}
			return null;
		}
		
		/** id */
		public var id:int = 0;
		/** 地图id */
		public var mapId:int = 0;
		/** 地图x */
		public var mapX:int = 0;
		/** 地图y */
		public var mapY:int = 0;
		/** 范围半径x */
		public var rX:int = 0;
		/** 范围半径y */
		public var rY:int = 0;
		/** 刷新频率 */
		public var frequency:int = 0;
		/** 怪物id */
		public var monsterId:int = 0;
		/** 最大数量 */
		public var maxCount:int = 0;
		
		public function MonsterPoolCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:MonsterPoolCfg = new MonsterPoolCfg();
				c.id = parseInt(dataDic["id"][i]);
				c.mapId = parseInt(dataDic["地图id"][i]);
				c.mapX = parseInt(dataDic["地图x"][i]);
				c.mapY = parseInt(dataDic["地图y"][i]);
				c.rX = parseInt(dataDic["范围半径x"][i]);
				c.rY = parseInt(dataDic["范围半径y"][i]);
				c.frequency = parseInt(dataDic["刷新频率"][i]);
				c.monsterId = parseInt(dataDic["怪物id"][i]);
				c.maxCount = parseInt(dataDic["最大数量"][i]);
				
				trace(c);
				cfgs[c.id] = c;
				arr.push(c);
			}
		}
		
		
		public function toString():String
		{
			return "[MonsterPoolCfg] id:" + id + " mapId:" + mapId + " mapX=" + mapX + " mapY=" + mapY
				+ " rX=" + rX + " rY=" + rY + " frequency=" + frequency
				+ " monsterId=" + monsterId + " maxCount=" + maxCount;
		}
	}
}