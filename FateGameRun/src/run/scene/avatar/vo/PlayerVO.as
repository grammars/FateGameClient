package run.scene.avatar.vo
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class PlayerVO extends CreatureVO
	{
		/** 武器外观 */
		public var weaponLook:String;
		/** PK模式 */
		public var pkMode:int;
		
		public function PlayerVO()
		{
			super();
		}
		
		override public function read(bytes:ByteArray):void
		{
			super.read(bytes);
			weaponLook = EndianFacade.readMultiByte(bytes);
			pkMode = EndianFacade.readInt(bytes);
		}
	}
}