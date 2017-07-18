package ui.view.goods
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.*;
	
	import comm.define.EquipType;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.drag.Drag;
	import ui.view.ViewWnd;
	import ui.view.goods.bag.BagIconField;
	import ui.view.goods.equip.EquipCell;
	import ui.view.goods.equip.EquipField;
	
	public class GoodsFrame extends ViewWnd
	{	
		private var closeBtn:JPushButton;
		private var imageCtn:JPanel;
		
		private var coinsLabel:JLabel;
		private var bindCoinsLabel:JLabel;
		private var ingotLabel:JLabel;
		private var bindIngotLabel:JLabel;
		
		private var eqpHelmetCell:JPanel;
		private var eqpNecklaceCell:JPanel;
		private var eqpWeaponCell:JPanel;
		private var eqpClothesCell:JPanel;
		private var eqpBeltCell:JPanel;
		private var eqpShoesCell:JPanel;
		
		private var bagTab0:JRadioButton;
		private var bagTab1:JRadioButton;
		private var bagTab2:JRadioButton;
		private var bagField:JPanel;
		
		public var iconField:BagIconField = new BagIconField();
		
		public var equipField:EquipField = new EquipField();
		
		/** 道具装备窗体 */
		public function GoodsFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("goods_pane");
			pane = uiPack.getCtrl("root");
			closeBtn = uiPack.getPushButton("closeBtn");
			imageCtn = uiPack.getPanel("imageCtn");
			
			coinsLabel = uiPack.getLabel("coinsLabel");
			bindCoinsLabel = uiPack.getLabel("bindCoinsLabel");
			ingotLabel = uiPack.getLabel("ingotLabel");
			bindIngotLabel = uiPack.getLabel("bindIngotLabel");
			
			eqpHelmetCell = uiPack.getPanel("eqpHelmetCell");
			eqpNecklaceCell = uiPack.getPanel("eqpNecklaceCell");
			eqpWeaponCell = uiPack.getPanel("eqpWeaponCell");
			eqpClothesCell = uiPack.getPanel("eqpClothesCell");
			eqpBeltCell = uiPack.getPanel("eqpBeltCell");
			eqpShoesCell = uiPack.getPanel("eqpShoesCell");
			
			bagTab0 = uiPack.getRadioButton("bagTab0");
			bagTab1 = uiPack.getRadioButton("bagTab1");
			bagTab2 = uiPack.getRadioButton("bagTab2");
			bagField = uiPack.getPanel("bagField");
			
			canDrag(true);
			canBringTop(true);
			
			equipField.pushCell(eqpHelmetCell, EquipType.HELMET);
			equipField.pushCell(eqpNecklaceCell, EquipType.NECKLACE);
			equipField.pushCell(eqpWeaponCell, EquipType.WEAPON);
			equipField.pushCell(eqpClothesCell, EquipType.CLOTHES);
			equipField.pushCell(eqpBeltCell, EquipType.BELT);
			equipField.pushCell(eqpShoesCell, EquipType.SHOES);
			
			iconField.x = 0;
			iconField.y = 0;
			bagField.addChild(iconField);
			
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtnClick);
			
			bagTab0.addEventListener(MouseEvent.CLICK, __bagTab0Click);
			bagTab1.addEventListener(MouseEvent.CLICK, __bagTab1Click);
			bagTab2.addEventListener(MouseEvent.CLICK, __bagTab2Click);
			
			bagTab0.addEventListener(MouseEvent.ROLL_OVER, __bagTab0Over);
			bagTab1.addEventListener(MouseEvent.ROLL_OVER, __bagTab1Over);
			bagTab2.addEventListener(MouseEvent.ROLL_OVER, __bagTab2Over);
		}
		
		private function __closeBtnClick(e:MouseEvent):void { hide(); }
		private function __bagTab0Click(e:MouseEvent):void { iconField.switchPage(0); }
		private function __bagTab1Click(e:MouseEvent):void { iconField.switchPage(1); }
		private function __bagTab2Click(e:MouseEvent):void { iconField.switchPage(2); }
		
		private function __bagTab0Over(e:MouseEvent):void
		{
			if(Drag.getInstance().isDragging()) { iconField.switchPage(0); bagTab0.selected = true; }
		}
		private function __bagTab1Over(e:MouseEvent):void
		{
			if(Drag.getInstance().isDragging()) { iconField.switchPage(1); bagTab1.selected = true; }
		}
		private function __bagTab2Over(e:MouseEvent):void
		{
			if(Drag.getInstance().isDragging()) { iconField.switchPage(2); bagTab2.selected = true; }
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
	}
}