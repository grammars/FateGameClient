package ui.view.goods.equip
{
	import comm.component.goods.info.EquipGI;
	
	import flash.events.MouseEvent;
	
	import net.msg.goods.GoodsMsg;
	
	import ui.drag.Drag;
	import ui.drag.DragAction;
	import ui.view.goods.GoodsIcon;
	
	public class EquipIcon extends GoodsIcon
	{
		public function getInfo():EquipGI { return info.toEquip(); }
		
		public function EquipIcon()
		{
			super();
			canDrag(true);
			this.doubleClickEnabled = true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, __doubleClick);
		}
		
		override protected function doDrag():void
		{
			Drag.getInstance().startQ(this, DragAction.dragEquipIcon, info);
		}
		
		private function __doubleClick(e:MouseEvent):void
		{
			GoodsMsg.getInstance().sendTakeOffEquipReq_C2G(info.uid, -1);
		}
		
	}
}