package cfg
{
	
	import flash.utils.Dictionary;
	
	public class MapDoorCfg
	{
		public static const TYPE:String = "map_door";
		
		public static var cfgs:Vector.<MapDoorCfg> = new Vector.<MapDoorCfg>();
		/** 根据id获取单个配置 */
		public static function get(id:int):MapDoorCfg
		{
			for(var i:int = 0; i < cfgs.length; i++)
			{
				if(cfgs[i].id == id)
				{
					return cfgs[i];
				}
			}
			return null;
		}
		
		/** 获取通往指定地图的传送配置 */
		public static function getCfgsToMapId(mapId:int):Vector.<MapDoorCfg>
		{
			var doors:Vector.<MapDoorCfg> = new Vector.<MapDoorCfg>();
			for(var i:int = 0; i < cfgs.length; i++)
			{
				if(cfgs[i].toMapId == mapId)
				{
					doors.push( cfgs[i] );
				}
			}
			return doors;
		}
		
		/** 查找从地图到另一地图的的传送门配置 */
		public static function findDoor(fromMapId:int, toMapId:int):MapDoorCfg
		{
			for(var i:int = 0; i < cfgs.length; i++)
			{
				if(cfgs[i].fromMapId == fromMapId && cfgs[i].toMapId == toMapId)
				{
					return cfgs[i];
				}
			}
			return null;
		}
		
		/** id */
		public var id:int = 0;
		/** fromMapId */
		public var fromMapId:int = 0;
		/** fromMapX */
		public var fromMapX:int = 0;
		/** fromMapY */
		public var fromMapY:int = 0;
		/** toMapId */
		public var toMapId:int = 0;
		/** toMapX */
		public var toMapX:int = 0;
		/** toMapY */
		public var toMapY:int = 0;
		/** desc */
		public var desc:String = "";
		
		public function MapDoorCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:MapDoorCfg = new MapDoorCfg();
				c.id = parseInt(dataDic["id"][i]);
				c.fromMapId = parseInt(dataDic["fromMapId"][i]);
				c.fromMapX = parseInt(dataDic["fromMapX"][i]);
				c.fromMapY = parseInt(dataDic["fromMapY"][i]);
				c.toMapId = parseInt(dataDic["toMapId"][i]);
				c.toMapX = parseInt(dataDic["toMapX"][i]);
				c.toMapY = parseInt(dataDic["toMapY"][i]);
				c.desc = (dataDic["desc"][i]);
				//trace(c);
				cfgs.push(c);
			}
		}
		
		
		public function toString():String
		{
			return "[MapDoorCfg] id:" + id + " fromMapId:" + fromMapId
				+ " fromMapX:" + fromMapX + " fromMapY:" + fromMapY
				+ " toMapId:" + toMapId + " toMapX:" + toMapX
				+ " toMapY:" + toMapY + " desc:" + desc;
		}
	}
}