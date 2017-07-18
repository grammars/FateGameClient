package run.action
{
	import cfg.MapDoorCfg;

	public class MapRouteNode
	{
//		public var pre:MapRouteNode;
//		public var next:MapRouteNode;
//		
//		public var door:MapDoorCfg;
		
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
		
		public function MapRouteNode()
		{
			//
		}
		
		public function copy(c:MapDoorCfg):void
		{
			this.fromMapId = c.fromMapId;
			this.fromMapX = c.fromMapX;
			this.fromMapY = c.fromMapY;
			this.toMapId = c.toMapId;
			this.toMapX = c.toMapX;
			this.toMapY = c.toMapY;
		}
		
//		public function MapRouteNode(door:MapDoorCfg)
//		{
//			this.door = door;
//		}
		
//		public static function link(from:MapRouteNode, to:MapRouteNode):void
//		{
//			from.next = to;
//			to.pre = from;
//		}
		
	}
}