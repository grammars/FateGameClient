package comm.component.goods
{
	import com.anstu.jsock.utils.Long;
	
	import comm.struct.goods.StGoodsContainer;

	public class GoodsContainer extends StGoodsContainer
	{
		/** 容器类型：背包 */
		public static const TYPE_BAG:int = 1;
		/** 容器类型：装备 */
		public static const TYPE_EQUIP:int = 2;
		/** 容器类型：仓库 */
		public static const TYPE_WAREHOUSE:int = 3;
		
		public function GoodsContainer()
		{
		}
		
		/** 添加一项物品 */
		public function addItem(item:GoodsInfo):void
		{
			items.push(item);
			addItemHandler(item);
		}
		
		/** 移除一项物品 */
		public function removeItem(uid:Long):GoodsInfo
		{
			for(var i:int = items.length-1; i >= 0; i--)
			{
				var item:GoodsInfo = items[i];
				if( uid.euqals( item.uid ) )
				{
					items.splice(i,1);
					removeItemHandler(item);
					return item;
				}
			}
			return null;
		}
		
		/** 更新一项物品 */
		public function updateItem(newItem:GoodsInfo):void
		{
			for(var i:int = 0; i < items.length; i++)
			{
				var item:GoodsInfo = items[i];
				if( newItem.uid.euqals( item.uid ) )
				{
					item.copy(newItem);
					updateItemHandler(item);
					break;
				}
			}
		}
		
		/** 清除所有物品 */
		public function clearItems():void
		{
			items.length = 0;
			clearItemsHandler();
		}
		
		/** 清空物品handler */
		protected function clearItemsHandler():void
		{
			//TODO
		}
		
		/** 初始化物品handler */
		protected function initItemsHandler():void
		{
			//TODO
		}
		
		/**  添加物品handler */
		protected function addItemHandler(item:GoodsInfo):void
		{
			//TODO
		}
		
		/** 移除物品handler */
		protected function removeItemHandler(item:GoodsInfo):void
		{
			//TODO
		}
		
		/** 更新物品handler */
		protected function updateItemHandler(item:GoodsInfo):void
		{
			//TODO
		}
		
		/** build */
		protected function build():void
		{
			//TODO
		}
		
		/** 导入结构数据 */
		public function importData(data:StGoodsContainer):void
		{
			clearItems();
			this.items = data.items;
			build();
			initItemsHandler();
		}
		
	}
}