package comm.component.goods.bag
{
	import central.Game;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsContainer;
	import comm.component.goods.GoodsInfo;

	public class BagContainer extends GoodsContainer
	{
		public function BagContainer()
		{
			super();
		}
		
		/** 清空物品handler */
		override protected function clearItemsHandler():void
		{
			Game.goods.bag.clearItems();
		}
		
		/** 初始化物品handler */
		override protected function initItemsHandler():void
		{
			Game.goods.bag.initItems();
		}
		
		/**  添加物品handler */
		override protected function addItemHandler(item:GoodsInfo):void
		{
			Game.goods.bag.addItem(item);
		}
		
		/** 移除物品handler */
		override protected function removeItemHandler(item:GoodsInfo):void
		{
			Game.goods.bag.removeItem(item);
		}
		
		/** 更新物品handler */
		override protected function updateItemHandler(item:GoodsInfo):void
		{
			Game.goods.bag.updateItem(item);
		}
		
		/** build */
		override protected function build():void
		{
			super.build();
		}
		
	}
}