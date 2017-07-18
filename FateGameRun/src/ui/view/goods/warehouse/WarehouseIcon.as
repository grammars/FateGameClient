package ui.view.goods.warehouse
{
	import ui.drag.Drag;
	import ui.drag.DragAction;
	import ui.view.goods.GoodsIcon;
	
	public class WarehouseIcon extends GoodsIcon
	{
		public function WarehouseIcon()
		{
			super();
			canDrag(true);
		}
		
		override protected function doDrag():void
		{
			Drag.getInstance().startQ(this, DragAction.dragWarehouseIcon, info);
		}
	}
}