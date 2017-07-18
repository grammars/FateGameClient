package ui.view.goods
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JRadioButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.drag.Drag;
	import ui.view.ViewWnd;
	import ui.view.goods.warehouse.WarehouseIconField;
	
	public class WarehouseFrame extends ViewWnd
	{
		private var closeBtn:JPushButton;
		
		private var tab0:JRadioButton;
		private var tab1:JRadioButton;
		private var tab2:JRadioButton;
		private var field:JPanel;
		
		public var iconField:WarehouseIconField = new WarehouseIconField();
		
		public function WarehouseFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("warehouse_pane");
			pane = uiPack.getCtrl("root");
			closeBtn = uiPack.getPushButton("closeBtn");
			tab0 = uiPack.getRadioButton("tab0");
			tab1 = uiPack.getRadioButton("tab1");
			tab2 = uiPack.getRadioButton("tab2");
			field = uiPack.getPanel("field");
			
			canDrag(true);
			canBringTop(true);
			
			iconField.x = 0;
			iconField.y = 0;
			field.addChild(iconField);
			
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtnClick);
			
			tab0.addEventListener(MouseEvent.CLICK, __tab0Click);
			tab1.addEventListener(MouseEvent.CLICK, __tab1Click);
			tab2.addEventListener(MouseEvent.CLICK, __tab2Click);
			
			tab0.addEventListener(MouseEvent.ROLL_OVER, __tab0Over);
			tab1.addEventListener(MouseEvent.ROLL_OVER, __tab1Over);
			tab2.addEventListener(MouseEvent.ROLL_OVER, __tab2Over);
		}
		
		private function __closeBtnClick(e:MouseEvent):void { hide(); }
		private function __tab0Click(e:MouseEvent):void { iconField.switchPage(0); }
		private function __tab1Click(e:MouseEvent):void { iconField.switchPage(1); }
		private function __tab2Click(e:MouseEvent):void { iconField.switchPage(2); }
		
		private function __tab0Over(e:MouseEvent):void
		{
			if(Drag.getInstance().isDragging()) { iconField.switchPage(0); tab0.selected = true; }
		}
		private function __tab1Over(e:MouseEvent):void
		{
			if(Drag.getInstance().isDragging()) { iconField.switchPage(1); tab1.selected = true; }
		}
		private function __tab2Over(e:MouseEvent):void
		{
			if(Drag.getInstance().isDragging()) { iconField.switchPage(2); tab2.selected = true; }
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
	}
}