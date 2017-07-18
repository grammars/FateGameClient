package comm.component.goods
{
	import cfg.GoodsBaseCfg;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.info.*;
	import comm.define.GoodsType;
	
	import flash.utils.ByteArray;

	public class GoodsInfo
	{
		/** 唯一id */
		public var uid:Long;
		/** 物品位置 */
		public var index:int = 0;
		/** 物品基础配置id */
		public var baseCfgId:int = 0;
		/** 物品数量 */
		public var num:int = 0;
		
		/** 物品基础配置 */
		public var baseCfg:GoodsBaseCfg;
		
		public function getIcon():String
		{
			switch(baseCfg.type)
			{
			case GoodsType.SYSTEM: return "goods/system/"+baseCfg.icon+".jpg";
			case GoodsType.DRUG: return "goods/drug/"+baseCfg.icon+".jpg";
			case GoodsType.TASK: return "goods/task/"+baseCfg.icon+".jpg";
			case GoodsType.EQUIP: return "goods/equip/"+baseCfg.icon+".jpg";
			case GoodsType.GEM: return "goods/gem/"+baseCfg.icon+".jpg";
			case GoodsType.GIFT: return "goods/gift/"+baseCfg.icon+".jpg";
			}
			return "";
		}
		
		public function isSytem():Boolean { return baseCfg.type == GoodsType.SYSTEM; }
		public function isDrug():Boolean { return baseCfg.type == GoodsType.DRUG; }
		public function isTask():Boolean { return baseCfg.type == GoodsType.TASK; }
		public function isEquip():Boolean { return baseCfg.type == GoodsType.EQUIP; }
		public function isGem():Boolean { return baseCfg.type == GoodsType.GEM; }
		public function isGift():Boolean { return baseCfg.type == GoodsType.GIFT; }
		
		public function toSytem():SystemGI { return this as SystemGI; }
		public function toDrug():DrugGI { return this as DrugGI; }
		public function toTask():TaskGI { return this as TaskGI; }
		public function toEquip():EquipGI { return this as EquipGI; }
		public function toGem():GemGI { return this as GemGI; }
		public function toGift():GiftGI { return this as GiftGI; }
		
		/** 数据是否合法可用 */
		public function available():Boolean
		{
			return baseCfg != null;
		}
		
		public function GoodsInfo()
		{
		}
		
		public function create(baseCfgId:int):void
		{
			this.baseCfgId = baseCfgId;
			build();
		}
		
		protected function build():void
		{
			this.baseCfg = GoodsBaseCfg.get(baseCfgId);
			if(baseCfg == null)
			{
				Log.error("找不到mid=" + baseCfgId + "的物品");
			}
		}
		
		public function read(bytes:ByteArray):void
		{
			uid = EndianFacade.readLong(bytes);
			index = EndianFacade.readInt(bytes);
			baseCfgId = EndianFacade.readInt(bytes);
			num = EndianFacade.readInt(bytes);
			readHandler(bytes);
			build();
		}
		
		protected function readHandler(bytes:ByteArray):void
		{
			//TODO
		}
		
		public function copy(source:GoodsInfo):void
		{
			this.uid.clone(source.uid);
			this.index = source.index;
			this.baseCfgId = source.baseCfgId;
			this.num = source.num;
			copyHandler(source);
			build();
		}
		
		protected function copyHandler(source:GoodsInfo):void
		{
			//TODO
		}
	}
}