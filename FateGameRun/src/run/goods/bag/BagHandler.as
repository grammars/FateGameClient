package run.goods.bag
{
	import central.View;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsInfo;
	
	import run.h.CommHandler;

	public class BagHandler
	{
		public function BagHandler()
		{
		}
		
		/** 清空背包物品 */
		public function clearItems():void
		{
			View.goodsFrame.iconField.clearIcons();
			CommHandler.bagUpdate();
		}
		
		/** 初始化背包物品 */
		public function initItems():void
		{
			View.goodsFrame.iconField.initIcons();
			CommHandler.bagUpdate();
		}
		
		/** 添加物品到背包 */
		public function addItem(item:GoodsInfo):void
		{
			View.goodsFrame.iconField.addIcon(item);
			CommHandler.bagUpdate();
		}
		
		/** 移除物品从背包 */
		public function removeItem(item:GoodsInfo):void
		{
			View.goodsFrame.iconField.removeIcon(item.uid);
			CommHandler.bagUpdate();
		}
		
		/** 更新物品在背包 */
		public function updateItem(item:GoodsInfo):void
		{
			View.goodsFrame.iconField.updateIcon(item);
			CommHandler.bagUpdate();
		}
	}
}