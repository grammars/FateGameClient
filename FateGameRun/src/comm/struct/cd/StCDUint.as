package comm.struct.cd
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;
	
	import gamekit.ds.Map;

	public class StCDUint
	{
		/** 物品的冷却 Map<Integer, StCDInfo> */
		public var goods:Map = new Map();
		/** 技能的冷却 Map<Integer, StCDInfo> */
		public var skill:Map = new Map();
		
		public function StCDUint()
		{
		}
		
		/** 从IoBuffer读出 */
		public function read(bytes:ByteArray):StCDUint
		{
			var i = 0;
			
			goods.clear();
			var goods_num:int = EndianFacade.readInt(bytes);
			for(i = 0; i < goods_num; i++)
			{
				var info:StCDInfo = new StCDInfo();
				info.read(bytes);
				goods.put(info.id, info);
			}
			
			skill.clear();
			var skill_num:int = EndianFacade.readInt(bytes);
			for(i = 0; i < skill_num; i++)
			{
				var info:StCDInfo = new StCDInfo();
				info.read(bytes);
				skill.put(info.id, info);
			}
			return this;
		}
	}
}