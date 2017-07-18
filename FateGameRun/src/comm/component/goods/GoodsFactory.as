package comm.component.goods
{
	import cfg.GoodsBaseCfg;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.goods.info.*;
	import comm.define.GoodsType;
	
	import flash.utils.ByteArray;

	public class GoodsFactory
	{
		public function GoodsFactory()
		{
		}
		
		/** 创建一个物品信息
		 * @param mid 物品的模版表id */
		public static function createInfo(baseCfgId:int):GoodsInfo
		{
			var baseCfg:GoodsBaseCfg = GoodsBaseCfg.get(baseCfgId);
			if(baseCfg == null)
			{
				Log.error("找不到baseCfgId=" + baseCfgId + "的物品");
				return null;
			}
			var info:GoodsInfo = create(baseCfg.type);
			info.create(baseCfgId);
			return info;
		}
		
		public static function create(type:int):GoodsInfo
		{
			switch(type)
			{
			case GoodsType.SYSTEM: return new SystemGI();
			case GoodsType.DRUG: return new DrugGI();
			case GoodsType.TASK: return new TaskGI();
			case GoodsType.EQUIP: return new EquipGI();
			case GoodsType.GEM: return new GemGI();
			case GoodsType.GIFT: return new GiftGI();
			default: return null;
			}
		}
		
		/** 从IoBuffer中读取 */
		public static function readInfo(bytes:ByteArray):GoodsInfo
		{
			var baseCfgId:int = EndianFacade.readInt(bytes);
			var info:GoodsInfo = createInfo(baseCfgId);
			info.read(bytes);
			return info;
		}
		
	}
}