package run.goods.equip
{
	import central.Game;
	import central.View;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsInfo;
	
	import res.Res;

	public class EquipHandler
	{
		public function EquipHandler()
		{
		}
		
		/** 清空装备 */
		public function clearItems():void
		{
			View.goodsFrame.equipField.clearIcons();
		}
		
		/** 初始化装备 */
		public function initItems():void
		{
			View.goodsFrame.equipField.initIcons();
		}
		
		/** 穿上装备 */
		public function addItem(item:GoodsInfo):void
		{
			View.goodsFrame.equipField.addIcon(item);
		}
		
		/** 卸下装备 */
		public function removeItem(itemUid:Long):void
		{
			View.goodsFrame.equipField.removeIcon(itemUid);
		}
		
		/** 更新物品在装备 */
		public function updateItem(item:GoodsInfo):void
		{
			View.goodsFrame.equipField.updateIcon(item);
		}
		
	}
}