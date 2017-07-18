package ui.view.goods.equip
{
	import com.anstu.jui.controls.JPanel;
	
	import comm.component.goods.GoodsInfo;
	import comm.define.EquipType;
	
	import flash.events.MouseEvent;
	
	import net.msg.goods.GoodsMsg;
	
	import ui.drag.Drag;
	import ui.drag.DragAction;

	public class EquipCell
	{
		/** ui上的装备格子 */
		private var cell:JPanel;
		/** 装备部位类型 */
		public var type:int;
		
		public var icon:EquipIcon;
		
		/** 装备格子管理
		 * @param cell:JPanel ui上的装备格子
		 * @param type:int 装备部位类型，来自EquipType的枚举 */
		public function EquipCell(cell:JPanel, type:int)
		{
			this.cell = cell;
			this.type = type;
			
			initialize();
		}
		
		private function initialize():void
		{
			cell.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		}
		
		private function __mouseUp(e:MouseEvent):void
		{
			if( Drag.getInstance().isDoing(DragAction.dragBagIcon) )
			{
				var srcBag:GoodsInfo = Drag.getInstance().getData() as GoodsInfo;
				GoodsMsg.getInstance().sendPutOnEquipReq_C2G(srcBag.uid);
			}
			Drag.getInstance().dispose();
		}
		
		public function addIcon(icon:EquipIcon):void
		{
			removeIcon();
			this.icon = icon;
			this.icon.x = this.icon.y = 5;
			cell.addChild(this.icon);
		}
		
		public function removeIcon():void
		{
			if(this.icon && this.icon.parent) { this.icon.parent.removeChild(this.icon); }
			this.icon = null;
		}
		
	}
}