package comm.vo
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class SceneVO
	{
		/** 地图id */
		public var mapId:int = 0;
		
		public function SceneVO()
		{
		}
		
		/** 读取场景信息 */
		public function readInfo(bytes:ByteArray):void
		{
			mapId = EndianFacade.readInt(bytes);
		}
		
		public function toString():String
		{
			return "[SceneVO] mapId=" + mapId;
		}
		
	}
}