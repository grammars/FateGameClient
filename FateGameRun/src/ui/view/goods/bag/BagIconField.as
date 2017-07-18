package ui.view.goods.bag
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsInfo;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import net.msg.goods.GoodsMsg;
	
	import ui.drag.Drag;
	import ui.drag.DragAction;
	
	public class BagIconField extends Sprite
	{
		private static const W:int = 344;
		private static const H:int = 196;
		
		private static const COL:int = 7;
		private static const ROW:int = 4;
		private static function get PageSize():int { return COL * ROW; }
		
		private static const GRID_W:int = 49;
		private static const GRID_H:int = 49;
		
		private var icons:Vector.<BagIcon> = new Vector.<BagIcon>();
		
		private var curPageInd:int = 0;
		
		public function BagIconField()
		{
			super();
			initialize();
		}
		
		private function initialize():void
		{
			draw();
			this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		}
		
		private function draw():void
		{
			this.graphics.beginFill(0xff0000, 0.001);
			this.graphics.drawRect(0, 0, W, H);
			this.graphics.endFill();
		}
		
		private function __mouseUp(e:MouseEvent):void
		{
			if( Drag.getInstance().isDoing(DragAction.dragBagIcon) )
			{
				var srcBag:GoodsInfo = Drag.getInstance().getData() as GoodsInfo;
				GoodsMsg.getInstance().sendMoveItemBagToBagReq_C2G(srcBag.uid, getIndex4MouseXY());
			}
			else if( Drag.getInstance().isDoing(DragAction.dragEquipIcon) )
			{
				var srcEquip:GoodsInfo = Drag.getInstance().getData() as GoodsInfo;
				GoodsMsg.getInstance().sendTakeOffEquipReq_C2G(srcEquip.uid, getIndex4MouseXY());
			}
			else if( Drag.getInstance().isDoing(DragAction.dragWarehouseIcon) )
			{
				var srcWarehouse:GoodsInfo = Drag.getInstance().getData() as GoodsInfo;
				GoodsMsg.getInstance().sendMoveItemWarehouseToBagReq_C2G(srcWarehouse.uid, getIndex4MouseXY());
			}
			Drag.getInstance().dispose();
		}
		
		/** 根据鼠标所在的xy，计算此刻对应的index */
		private function getIndex4MouseXY():int
		{
			var fieldPos:Point = this.localToGlobal(new Point());
			var ix:int = Math.floor( (Centre.mouseX-fieldPos.x) / GRID_W);
			var iy:int = Math.floor( (Centre.mouseY-fieldPos.y) / GRID_H);
			var ind:int = ix + iy * COL;
			return PageSize * curPageInd + ind;
		}
		
		/** 切换页 */
		public function switchPage(pageInd:int):void
		{
			if(this.curPageInd != pageInd)
			{
				this.curPageInd = pageInd;
				for(var i:int = 0; i < icons.length; i++)
				{
					var icon:BagIcon = icons[i];
					putIcon(icon);
				}
			}
		}
		
		/** 初始化背包物品Icon */
		public function initIcons():void
		{
			clearIcons();
			var num:int = Game.hero.bag.items.length;
			for(var i:int = 0; i < num; i++)
			{
				var item:GoodsInfo = Game.hero.bag.items[i];
				addIcon(item);
			}
		}
		
		/** 添加物品Icon */
		public function addIcon(item:GoodsInfo):void
		{
			var icon:BagIcon = new BagIcon();
			icon.setup(item);
			putIcon(icon);
			icons.push(icon);
		}
		
		/** 处置摆放icon */
		private function putIcon(icon:BagIcon):void
		{
			const begIndex:int = curPageInd * PageSize;
			const endIndex:int = begIndex + PageSize;
			const theIndex:int = icon.info.index;
			if(theIndex >= begIndex && theIndex < endIndex)
			{
				const modInd:int = theIndex % PageSize;
				icon.x = (modInd % COL) * GRID_W + 6;
				icon.y = Math.floor(modInd / COL) * GRID_H + 6;
				this.addChild(icon);
			}
			else
			{
				if(icon.parent) { icon.parent.removeChild(icon); }
			}
		}
		
		/** 移除物品Icon */
		public function removeIcon(uid:Long):BagIcon
		{
			for(var i:int = icons.length-1; i >= 0; i--)
			{
				var icon:BagIcon = icons[i];
				if( uid.euqals( icon.info.uid ) )
				{
					if(icon.parent) { icon.parent.removeChild(icon); }
					icons.splice(i,1);
					return icon;
				}
			}
			return null;
		}
		
		/** 更新背包Icon */
		public function updateIcon(newItem:GoodsInfo):void
		{
			for(var i:int = icons.length-1; i >= 0; i--)
			{
				var icon:BagIcon = icons[i];
				if( newItem.uid.euqals( icon.info.uid ) )
				{
					icon.setup(newItem);
					putIcon(icon);
					break;
				}
			}
		}
		
		/** 清除所有Icon */
		public function clearIcons():void
		{
			for(var i:int = 0; i < icons.length; i++)
			{
				var icon:BagIcon = icons[i];
				if(icon.parent) { icon.parent.removeChild(icon); }
			}
			icons.length = 0;
		}
		
	}
}