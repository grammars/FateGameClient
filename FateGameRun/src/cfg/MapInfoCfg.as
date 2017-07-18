package cfg
{
	import flash.utils.Dictionary;

	public class MapInfoCfg
	{
		public static const TYPE:String = "map_info";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):MapInfoCfg
		{
			return cfgs[id];
		}
		
		private static var array:Array = new Array();
		public static function getAll():Array { return array; }
		
		/** 地图id */
		public var id:int = 0;
		/** 地图名称 */
		public var name:String = "";
		
		public function MapInfoCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:MapInfoCfg = new MapInfoCfg();
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["地图名称"][i]);
				trace(c);
				cfgs[c.id] = c;
				array.push(c);
			}
		}
		
		
		public function toString():String
		{
			return "[MapInfoConfig] id:" + id + " name:" + name;
		}
		
	}
}