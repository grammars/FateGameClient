package run.goods.warehouse
{
	import central.View;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsInfo;

	public class WarehouseHandler
	{
		public function WarehouseHandler()
		{
		}
		
		/** 清空仓库物品 */
		public function clearItems():void
		{
			View.warehouseFrame.iconField.clearIcons();
		}
		
		/** 初始化仓库物品 */
		public function initItems():void
		{
			View.warehouseFrame.iconField.initIcons();
		}
		
		/** 添加物品到仓库 */
		public function addItem(item:GoodsInfo):void
		{
			View.warehouseFrame.iconField.addIcon(item);
		}
		
		/** 移除物品从仓库 */
		public function removeItem(item:GoodsInfo):void
		{
			View.warehouseFrame.iconField.removeIcon(item.uid);
		}
		
		/** 更新物品在仓库 */
		public function updateItem(item:GoodsInfo):void
		{
			View.warehouseFrame.iconField.updateIcon(item);
		}
		
	}
}