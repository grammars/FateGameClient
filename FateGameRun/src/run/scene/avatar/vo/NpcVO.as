package run.scene.avatar.vo
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class NpcVO extends CreatureVO
	{
		/** 配置id */
		public var cfgId:int = 0;
		
		public function NpcVO()
		{
			super();
		}
		
		override public function read(bytes:ByteArray):void
		{
			super.read(bytes);
			cfgId = EndianFacade.readInt(bytes);
		}
		
	}
}