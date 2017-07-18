package comm.struct.practice
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;

	public class StPracticeData
	{
		/** 修炼经验 */
		public var exp:int = 0;
		/** 修炼境界等级 */
		public var lev:int = 0;
		
		public function StPracticeData()
		{
		}
		
		/** 从bytes读出 */
		public function read(bytes:ByteArray):void
		{
			exp = EndianFacade.readInt(bytes);
			lev = EndianFacade.readInt(bytes);
		}
	}
}