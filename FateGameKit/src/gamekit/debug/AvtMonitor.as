package gamekit.debug
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import gamekit.FateGameKit;
	import gamekit.layer.Layer;
	
	public class AvtMonitor extends Sprite
	{
		private static var instance:AvtMonitor;
		public static function getInstance():AvtMonitor
		{
			if(instance == null) { instance = new AvtMonitor(); }
			return instance;
		}
		
		private static const W:int = 160;
		private static const H:int = 80;
		
		public function AvtMonitor()
		{
			super();
			prepareCtrls();
			if(FateGameKit.AVATAR_MONITOR_DEBUG)
			{
				Layer.alert.addChild(this);
				this.x = 2;
				this.y = FateGameKit.STAGE.stageHeight - H - 2;
				this.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
				this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
				this.addEventListener(Event.ENTER_FRAME, __enterFrame);
			}
		}
		
		private var num:int = 0;
		/** set Avatar数量 */
		public function setNum(value:int):void
		{
			this.num = value;
			repaint();
		}
		/** get Avatar数量 */
		public function getNum():int { return this.num; }
		
		private var message:String = "";
		public function setMessage(value:String):void
		{
			this.message = value;
			repaint();
		}
		
		private function __mouseDown(e:MouseEvent):void
		{
			this.startDrag();
		}
		
		private function __mouseUp(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		private var playedFrame:int = 0;
		private var lastTimeRec:Number = 0;
		private var speed:Number = 0;
		private function __enterFrame(e:Event):void
		{
			if(playedFrame == 0)
			{
				lastTimeRec = new Date().time;
			}
			playedFrame++;
			if(playedFrame >= 60)
			{
				var costTime:Number = new Date().time - lastTimeRec;
				speed = playedFrame / (costTime/1000);
				repaint();
				playedFrame = 0;
			}
		}
		
		private var numTf:TextField;
		
		/** 初始化界面 */
		private function prepareCtrls():void
		{
			if(!FateGameKit.AVATAR_MONITOR_DEBUG) { return; }
			
			numTf = new TextField();
			var fmt:TextFormat = new TextFormat("微软雅黑", 12, 0xdedede, true);
			fmt.leading = -4;
			numTf.defaultTextFormat = fmt;
			numTf.width = W-10;
			numTf.height = H-10;
			numTf.x = 5;
			numTf.y = 5;
			this.addChild(numTf);
		}
		
		/** 重绘调试界面 */
		private function repaint():void
		{
			if(!FateGameKit.AVATAR_MONITOR_DEBUG) { return; }
			
			this.graphics.clear();
			this.graphics.lineStyle(2, 0x90ba12, 0.8);
			this.graphics.beginFill(0x0, 0.6);
			this.graphics.drawRect(0, 0, W, H);
			this.graphics.endFill();
			
			numTf.text = "AvtNum:" + this.num + "\rFPS:" +speed.toFixed() + "\r" + message;
		}
		
	}
}