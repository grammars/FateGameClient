package comm.struct.skill
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class StSkillSet
	{
		public var items:Vector.<StSkillItem> = new Vector.<StSkillItem>();
		
		public function StSkillSet()
		{
		}
		
		/** 从bytes读出 */
		public function read(bytes:ByteArray):StSkillSet
		{
			items.length = 0;
			var num:int = EndianFacade.readInt(bytes);
			for(var i:int = 0; i < num; i++)
			{
				var item:StSkillItem = new StSkillItem();
				item.read(bytes);
				items.push(item);
			}
			return this;
		}
	}
}