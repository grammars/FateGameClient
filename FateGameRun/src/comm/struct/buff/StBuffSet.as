package comm.struct.buff
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class StBuffSet
	{
		public var items:Vector.<StBuff> = new Vector.<StBuff>();
		
		public function StBuffSet()
		{
		}
		
		public function read(bytes:ByteArray):StBuffSet
		{
			items.length = 0;
			var num:int = EndianFacade.readInt(bytes);
			for(var i:int = 0; i < num; i++)
			{
				var item:StBuff = new StBuff();
				item.read(bytes);
				items.push(item);
			}
			return this;
		}
	}
}