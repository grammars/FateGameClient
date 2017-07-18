package comm.component.goods.equip
{
	import central.Game;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsContainer;
	import comm.component.goods.GoodsInfo;
	import comm.define.EquipType;
	
	import res.Res;

	public class EquipContainer extends GoodsContainer
	{
		public function EquipContainer()
		{
			super();
		}
		
		/** 清空物品handler */
		override protected function clearItemsHandler():void
		{
			Game.goods.equip.clearItems();
		}
		
		/** 初始化物品handler */
		override protected function initItemsHandler():void
		{
			Game.goods.equip.initItems();
		}
		
		/**  添加物品handler */
		override protected function addItemHandler(item:GoodsInfo):void
		{
			Game.goods.equip.addItem(item);
		}
		
		/** 移除物品handler */
		override protected function removeItemHandler(item:GoodsInfo):void
		{
			Game.goods.equip.removeItem(item.uid);
		}
		
		/** 更新物品handler */
		override protected function updateItemHandler(item:GoodsInfo):void
		{
			Game.goods.equip.updateItem(item);
		}
		
		/** 获取武器外观 */
		public function getWeaponLook():String
		{
			for(var i:int = 0; i < items.length; i++)
			{
				var item:GoodsInfo = items[i];
				if(item.toEquip().equipCfg.type == EquipType.WEAPON)
				{
					return item.toEquip().equipCfg.look;
				}
			}
			return "";
		}
		
		/** build */
		override protected function build():void
		{
			super.build();
		}
		
	}
}