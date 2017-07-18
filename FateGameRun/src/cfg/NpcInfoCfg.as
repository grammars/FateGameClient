package cfg
{
	import flash.utils.Dictionary;

	public class NpcInfoCfg
	{
		public static const TYPE:String = "npc_info";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):NpcInfoCfg
		{
			return cfgs[id];
		}
		
		/** npcId */
		public var id:int = 0;
		/** 名字 */
		public var name:String = "";
		/** 外观id */
		public var look:String = "";
		/** mapId */
		public var mapId:int = 0;
		/** mapX */
		public var mapX:int = 0;
		/** mapY */
		public var mapY:int = 0;
		/** 方向 */
		public var direction:int = 0;
		/** 对话内容 */
		public var talkContent:String = "";
		
		public function NpcInfoCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:NpcInfoCfg = new NpcInfoCfg();
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["名字"][i]);
				c.look = (dataDic["外观id"][i]);
				c.mapId = parseInt(dataDic["mapId"][i]);
				c.mapX = parseInt(dataDic["mapX"][i]);
				c.mapY = parseInt(dataDic["mapY"][i]);
				c.direction = parseInt(dataDic["方向"][i]);
				c.talkContent = (dataDic["对话内容"][i]);
				trace(c);
				cfgs[c.id] = c;
			}
		}
		
		
		public function toString():String
		{
			return "[NpcInfoCfg] id:" + id + " name:" + name
				+ " look=" + look + " map=" + mapId + "(" + mapX + "," + mapY + ")"
				+ " direction=" + direction;
		}
	}
}