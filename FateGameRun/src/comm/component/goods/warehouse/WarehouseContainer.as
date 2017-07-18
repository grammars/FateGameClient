package comm.component.goods.warehouse
{
	import central.Game;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsContainer;
	import comm.component.goods.GoodsInfo;

	public class WarehouseContainer extends GoodsContainer
	{
		public function WarehouseContainer()
		{
			super();
		}
		
		/** 清空物品handler */
		override protected function clearItemsHandler():void
		{
			Game.goods.warehouse.clearItems();
		}
		
		/** 初始化物品handler */
		override protected function initItemsHandler():void
		{
			Game.goods.warehouse.initItems();
		}
		
		/**  添加物品handler */
		override protected function addItemHandler(item:GoodsInfo):void
		{
			Game.goods.warehouse.addItem(item);
		}
		
		/** 移除物品handler */
		override protected function removeItemHandler(item:GoodsInfo):void
		{
			Game.goods.warehouse.removeItem(item);
		}
		
		/** 更新物品handler */
		override protected function updateItemHandler(item:GoodsInfo):void
		{
			Game.goods.warehouse.updateItem(item);
		}
		
		/** build */
		override protected function build():void
		{
			super.build();
		}
	}
}