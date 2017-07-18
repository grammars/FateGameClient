package run.goods
{
	import central.Centre;
	import central.Game;
	import central.View;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsInfo;
	
	import flash.events.MouseEvent;
	
	import net.msg.goods.GoodsMsg;
	
	import run.AbstractRunHandler;
	import run.goods.bag.BagHandler;
	import run.goods.equip.EquipHandler;
	import run.goods.warehouse.WarehouseHandler;
	
	import ui.drag.Drag;
	import ui.drag.DragAction;
	
	public class GoodsRun extends AbstractRunHandler
	{
		/** 背包处理 */
		public var bag:BagHandler = new BagHandler();
		/** 装备处理 */
		public var equip:EquipHandler = new EquipHandler();
		/** 仓库处理 */
		public var warehouse:WarehouseHandler = new WarehouseHandler();
		
		public function GoodsRun()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			super.startup();
			Centre.stage.addEventListener(MouseEvent.MOUSE_UP, __dropItemHandler);
		}
		
		/** 丢物品处理 */
		private function __dropItemHandler(e:MouseEvent):void
		{
			if( Drag.getInstance().isDoing(DragAction.dragBagIcon) )
			{
				var srcBag:GoodsInfo = Drag.getInstance().getData() as GoodsInfo;
				View.goodsDiscardFrame.open(srcBag);
			}
			Drag.getInstance().dispose();
		}
		
		/** 请求使用物品 */
		public function useItem(info:GoodsInfo, useNum:int=1):void
		{
			GoodsMsg.getInstance().sendUseItemReq_C2G(info.uid, useNum);
		}
		
	}
}