package comm.component.data
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.define.SpriteType;
	
	import flash.utils.ByteArray;

	/** 结构对应Server的Sprite.java */
	public class SpriteData
	{
		/** 临时id */
		public var tid:int;
		
		/** 唯一id */
		public var uid:Long;
		/** 朝向 */
		public var direction:int;
		/** 地图id */
		public var mapId:int;
		/** 地图x */
		public var x:int;
		/** 地图y */
		public var y:int;
		/** 外观 */
		public var look:String;
		
		public function SpriteData()
		{
		}
		
		/** 读取[全部数据] */
		public function read(bytes:ByteArray):void
		{
			uid = EndianFacade.readLong(bytes);
			mapId = EndianFacade.readInt(bytes);
			x = EndianFacade.readInt(bytes);
			y = EndianFacade.readInt(bytes);
			direction = EndianFacade.readByte(bytes);
			look = EndianFacade.readMultiByte(bytes);
		}
		
	}
}