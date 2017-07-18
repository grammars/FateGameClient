package test.ctrls
{
	import com.anstu.jui.controls.JPushButton;
	
	import comm.L;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import ui.skin.pushButton.CommOrangeBtnSkin;
	import ui.view.debug.GmFrame;

	public class GameConsole extends Sprite
	{
		private static var instance:GameConsole;
		public static function getInstance():GameConsole
		{
			if(instance == null) { instance = new GameConsole(); }
			return instance;
		}
		
		private static const W:int = 200;
		private static const H:int = 80;
		
		private var lastTickTime:Number = 0;
		private var ticker:Timer = new Timer(1000, 0);
		
		private var logTf:TextField = new TextField();
		private var logContent:String = "";
		
		private var lastMsgCount:Number = 0;
		private var msgCount:Number = 0;
		private var msgSpeed:int = 0;
		
		private var gmPaneBtn:JPushButton = new JPushButton(L.T("GM控制台"), __gmPane);
		
		public function GameConsole()
		{
			var fmt:TextFormat = new TextFormat(null, 12, 0xfee955);
			fmt.leading = -3;
			logTf.defaultTextFormat = fmt;
			logTf.x = 0;
			logTf.y = 0;
			logTf.width = W;
			logTf.height = H;
			this.addChild(logTf);
			
			CommOrangeBtnSkin.instance.apply(gmPaneBtn);
			gmPaneBtn.setSize(W, 30);
			gmPaneBtn.move(0, 80);
			this.addChild(gmPaneBtn);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
			this.addEventListener(Event.ADDED_TO_STAGE, __addToStage);
			ticker.addEventListener(TimerEvent.TIMER, __ticking);
			ticker.start();
			
			lastTickTime = new Date().time;
		}
		
		private function __mouseDown(e:MouseEvent):void
		{
			this.startDrag();
		}
		
		private function __mouseUp(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		private function __addToStage(e:Event):void
		{
			this.x = 0;
			this.y = 120;
		}
		
		private function __ticking(e:TimerEvent):void
		{
			var nowTime:Number = new Date().time;
			var passTime:Number = nowTime - lastTickTime;
			
			var deltMsgCount:Number = msgCount - lastMsgCount;
			msgSpeed = deltMsgCount/ (passTime/1000);
			repaint();
			
			lastMsgCount = msgCount;
			lastTickTime = nowTime;
		}
		
		public function log(content:String, clearBefore:Boolean=false):void
		{
			if(clearBefore) { logContent = content; }
			else { logContent += content + "\r";  }
			repaint();
		}
		
		public function msgNumIncrease():void
		{
			msgCount++;
		}
		
		private function repaint():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2, 0xf21243, 0.8);
			this.graphics.beginFill(0x121212, 0.8);
			this.graphics.drawRect(0, 0, W, H);
			
			var logFinalContent:String = "msg:" + msgSpeed + "/" + msgCount + "\r"
				+ logContent;
			logTf.text = logFinalContent;
		}
		
		private function __gmPane(e:MouseEvent):void
		{
			GmFrame.instance.show();
		}
		
	}
}