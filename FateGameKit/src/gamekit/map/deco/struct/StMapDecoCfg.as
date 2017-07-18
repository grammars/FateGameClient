package gamekit.map.deco.struct
{
	/** 地图装饰配置 */
	public class StMapDecoCfg
	{
		/** 位于的 */
		public var mapId:int = 0;
		/** 位于的mapX */
		public var mapX:int = 0;
		/** 位于的mapY */
		public var mapY:int = 0;
		
		/** 资源swf的url */
		public var swfUrl:String;
		/** 资源的类连接名 */
		public var className:String;
		
		private static var UidCount:int = 0;
		private var _uid:int = 0;
		/** 自动生成的唯一id */
		public function get uid():int { return _uid; }
		
		public function StMapDecoCfg(mapId:int=0, mapX:int=0, mapY:int=0, swfUrl:String=null, className:String=null)
		{
			_uid = UidCount++;
			
			this.mapId = mapId;
			this.mapX = mapX;
			this.mapY = mapY;
			this.swfUrl = swfUrl;
			this.className = className;
		}
		
		/** 判断是否包含在当前视野内 */
		public function isInSight(pMapId:int, begGX:int, begGY:int, endGX:int, endGY:int):Boolean
		{
			if(pMapId != this.mapId) { return false; }
			if(this.mapX < begGX || this.mapX > endGX) { return false; }
			if(this.mapY < begGY || this.mapY > endGY) { return false; }
			return true;
		}
		
		public function toString():String
		{
			return "[StMapDecoCfg] mapId=" + mapId + " mapX=" + mapX + " mapY=" + mapY
				+ " swfUrl=" + swfUrl + " className=" + className;
		}
		
	}
}