package ui.view.buff
{
	import central.Centre;
	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	
	import comm.L;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import res.Res;
	
	import comm.component.buff.Buff;
	
	import ui.view.ViewWnd;
	
	public class BuffTip extends ViewWnd
	{
		private static var _instance:BuffTip;
		public static function get instance():BuffTip
		{
			if(_instance == null) { _instance = new BuffTip(); }
			return _instance;
		}
		
		/** buff信息 */
		private var info:Buff;
		
		private var iconCtn:JPanel;
		private var nameLabel:JLabel;
		private var destroyTimeLabel:JLabel;
		private var leftTimeLabel:JLabel;
		
		private var icon:Bitmap = new Bitmap();
		
		private var ticker:Timer = new Timer(1000);
		
		public function BuffTip()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("buff_tip");
			pane = uiPack.getCtrl("root");
			iconCtn = uiPack.getPanel("iconCtn");
			nameLabel = uiPack.getLabel("nameLabel");
			destroyTimeLabel = uiPack.getLabel("destroyTimeLabel");
			leftTimeLabel = uiPack.getLabel("leftTimeLabel");
			
			ticker.addEventListener(TimerEvent.TIMER, __ticking);
		}
		
		override public function show():void
		{
			super.show();
			Centre.stage.addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
			ticker.start();
		}
		
		override public function hide():void
		{
			super.hide();
			Centre.stage.removeEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
			ticker.stop();
		}
		
		private function __mouseMove(e:MouseEvent):void
		{
			pane.move(Centre.stage.mouseX, Centre.stage.mouseY);
		}
		
		public function fill(info:Buff):void
		{
			this.info = info;
			
			Res.fillIcon(icon, "buff/" + info.config.icon + ".jpg");
			icon.x = icon.y = 3;
			iconCtn.addChild(icon);
			
			nameLabel.text = info.config.name;
			var destroyDate:Date = new Date();
			destroyDate.time = info.destroyTime.toNumber();
			destroyTimeLabel.text = L.Tdate(destroyDate);
			
			freshLeftSec();
		}
		
		private function __ticking(e:TimerEvent):void
		{
			freshLeftSec();
		}
		
		private function freshLeftSec():void
		{
			if(!info) { return; }
			var leftSec:int = (info.destroyTime.toNumber() - new Date().time)/1000;
			leftTimeLabel.text = leftSec + "秒";
		}
		
	}
}