package run.scene.avatar.vo
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.define.SpriteType;
	
	import flash.utils.ByteArray;
	
	/** Sprite Visual Object */
	public class SpriteVO
	{
		/** 出生绝对时间 */
		public var bornTime:Number;
		
		/** 精灵类型 */
		public var type:int = SpriteType.NULL;
		/** 临时id */
		public var tid:int;
		/** 唯一id */
		public var uid:Long;
		/** 地图id */
		public var mapId:int;
		/** 地图x */
		public var mapX:int;
		/** 地图y */
		public var mapY:int;
		/** 朝向 */
		public var direction:int;
		/** 外观 */
		public var look:String;
		
		public function SpriteVO()
		{
		}
		
		public function read(bytes:ByteArray):void
		{
			var aliveTime:int = EndianFacade.readInt(bytes);
			bornTime = new Date().time - aliveTime;
			
			type = EndianFacade.readByte(bytes);
			tid = EndianFacade.readInt(bytes);
			uid = EndianFacade.readLong(bytes);
			mapId = EndianFacade.readInt(bytes);
			mapX = EndianFacade.readInt(bytes);
			mapY = EndianFacade.readInt(bytes);
			direction = EndianFacade.readByte(bytes);
			look = EndianFacade.readMultiByte(bytes);
		}
		
	}
}