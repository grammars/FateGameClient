package ui.view.goods
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.*;
	
	import comm.component.goods.GoodsInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import net.msg.goods.GoodsMsg;
	
	import ui.view.ViewWnd;
	
	public class GoodsSplitFrame extends ViewWnd
	{
		private var closeBtn:JPushButton;
		private var numInput:JInputText;
		private var addBtn:JPushButton;
		private var subtractBtn:JPushButton;
		private var sureBtn:JPushButton;
		private var cancelBtn:JPushButton;
		
		private function setNum(value:int):void
		{
			if(value < 0) { value = 0; }
			else if(value > 99) { value = 99; }
			numInput.text = value.toString();
		}
		private function getNum():int { return parseInt(numInput.text); }
		
		private var info:GoodsInfo;
		
		public function GoodsSplitFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("goods_split");
			pane = uiPack.getCtrl("root");
			closeBtn = uiPack.getPushButton("closeBtn");
			numInput = uiPack.getInputText("numInput");
			addBtn = uiPack.getPushButton("addBtn");
			subtractBtn = uiPack.getPushButton("subtractBtn");
			sureBtn = uiPack.getPushButton("sureBtn");
			cancelBtn = uiPack.getPushButton("cancelBtn");
			
			canDrag(true);
			canBringTop(true);
			
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtnClick);
			addBtn.addEventListener(MouseEvent.CLICK, __addBtnClick);
			subtractBtn.addEventListener(MouseEvent.CLICK, __subtractBtnClick);
			sureBtn.addEventListener(MouseEvent.CLICK, __sureBtnClick);
			cancelBtn.addEventListener(MouseEvent.CLICK, __cancelBtnClick);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
		private function __closeBtnClick(e:MouseEvent):void
		{
			hide();
		}
		
		private function __addBtnClick(e:MouseEvent):void
		{
			setNum( getNum()+1 );
		}
		
		private function __subtractBtnClick(e:MouseEvent):void
		{
			setNum( getNum()-1 );
		}
		
		private function __sureBtnClick(e:MouseEvent):void
		{
			GoodsMsg.getInstance().sendSplitItemInBagReq_C2G(info.uid, getNum());
		}
		
		private function __cancelBtnClick(e:MouseEvent):void
		{
			hide();
		}
		
		public function open(info:GoodsInfo):void
		{
			this.info = info;
			show();
		}
		
		public function close():void
		{
			this.info = null;
			hide();
		}
		
	}
}