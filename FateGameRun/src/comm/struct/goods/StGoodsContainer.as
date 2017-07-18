package comm.struct.goods
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.goods.GoodsFactory;
	import comm.component.goods.GoodsInfo;
	
	import flash.utils.ByteArray;

	public class StGoodsContainer
	{
		/** 物品们 */
		public var items:Vector.<GoodsInfo> = new Vector.<GoodsInfo>();
		
		public function StGoodsContainer()
		{
		}
		
		public function read(bytes:ByteArray):void
		{
			items.length = 0;
			var num:int = EndianFacade.readInt(bytes);
			for(var i:int = 0; i < num; i++)
			{
				var item:GoodsInfo = GoodsFactory.readInfo(bytes);
				items.push(item);
			}
		}
		
	}
}