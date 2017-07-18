package net.msg
{
	import central.Centre;
	
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;
	
	import net.SidType;

	public class MsgBuffer
	{
		public var bytes:ByteArray = new ByteArray();
		
		public function MsgBuffer(mainId:int, subId:int, target:int=4)//target:int=SidType.GAME
		{
			EndianFacade.writeInt(bytes, mainId);
			EndianFacade.writeInt(bytes, subId);
			EndianFacade.writeByte(bytes, target);
			EndianFacade.writeLong(bytes, Centre.NET.clientBundleId);
		}
		
		public function send():void
		{
			Centre.NET.send(bytes);
		}
		
	}
}