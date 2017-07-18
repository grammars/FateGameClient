package comm.struct.skill
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class StSkillItem
	{
		/** 技能id */
		public var id:int;
		/** 技能等级 */
		public var level:int;
		
		public function StSkillItem()
		{
		}
		
		/** 从bytes读出 */
		public function read(bytes:ByteArray):void
		{
			id = EndianFacade.readInt(bytes);
			level = EndianFacade.readInt(bytes);
		}
		
		public function toString():String
		{
			return "[StSkillItem] id=" + id + " level=" + level;
		}
	}
}