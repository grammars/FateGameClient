package run.scene.avatar.vo
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class DoorVO extends SpriteVO
	{
		/** 传送目标地图id */
		public var toMapId:int;
		/** 传送目标地图x */
		public var toMapX:int;
		/** 传送目标地图y */
		public var toMapY:int;
		
		public function DoorVO()
		{
			super();
		}
		
		override public function read(bytes:ByteArray):void
		{
			super.read(bytes);
			toMapId = EndianFacade.readInt(bytes);
			toMapX = EndianFacade.readInt(bytes);
			toMapY = EndianFacade.readInt(bytes);
		}
		
	}
}