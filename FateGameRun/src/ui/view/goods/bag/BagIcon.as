package ui.view.goods.bag
{
	import central.Game;
	
	import comm.component.goods.GoodsInfo;
	
	import flash.events.MouseEvent;
	
	import net.msg.goods.GoodsMsg;
	
	import ui.drag.Drag;
	import ui.drag.DragAction;
	import ui.parts.DClick;
	import ui.view.goods.GoodsIcon;
	
	public class BagIcon extends GoodsIcon
	{
		public function BagIcon()
		{
			super();
			canDrag(true);
			showCD(true);
			new DClick(this).setup(__click, __doubleClick);
		}
		
		override protected function doDrag():void
		{
			Drag.getInstance().startQ(this, DragAction.dragBagIcon, info);
		}
		
		private function __click(e:MouseEvent):void
		{
			BagIconMenu.getInstance().showFor(this);
		}
		
		private function __doubleClick(e:MouseEvent):void
		{
			Game.goods.useItem(this.info);
		}
		
	}
}