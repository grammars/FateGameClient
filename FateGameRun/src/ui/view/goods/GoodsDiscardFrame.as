package ui.view.goods
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.*;
	
	import comm.component.goods.GoodsInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import net.msg.goods.GoodsMsg;
	
	import ui.view.ViewWnd;
	
	public class GoodsDiscardFrame extends ViewWnd
	{
		private var closeBtn:JPushButton;
		private var sureBtn:JPushButton;
		private var cancelBtn:JPushButton;
		private var iconCtn:JPanel;
		
		private var info:GoodsInfo;
		private var icon:GoodsIcon;
		
		public function GoodsDiscardFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("goods_discard");
			pane = uiPack.getCtrl("root");
			closeBtn = uiPack.getPushButton("closeBtn");
			sureBtn = uiPack.getPushButton("sureBtn");
			cancelBtn = uiPack.getPushButton("cancelBtn");
			iconCtn = uiPack.getPanel("iconCtn");
			
			canDrag(true);
			canBringTop(true);
			
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtnClick);
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
			close();
		}
		
		private function __sureBtnClick(e:MouseEvent):void
		{
			GoodsMsg.getInstance().sendDropItemFromBagReq_C2G(info.uid);
			close();
		}
		
		private function __cancelBtnClick(e:MouseEvent):void
		{
			close();
		}
		
		public function open(info:GoodsInfo):void
		{
			this.info = info;
			deleteIcon();
			icon = new GoodsIcon();
			icon.setup(info);
			icon.x = icon.y = 2;
			iconCtn.addChild(icon);
			show();
		}
		
		public function close():void
		{
			this.info = null;
			deleteIcon();
			hide();
		}
		
		private function deleteIcon():void
		{
			if(icon && icon.parent) { icon.parent.removeChild(icon); }
			this.icon = null;
		}
	}
}