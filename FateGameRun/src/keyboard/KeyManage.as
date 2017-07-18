package keyboard
{
	import central.AbstractManage;
	import central.Centre;
	import central.Game;
	import central.View;
	
	import com.anstu.jcommon.log.Log;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import ui.view.operate.OperIconField;
	import ui.view.operate.OperPane;

	public class KeyManage extends AbstractManage
	{
		public function KeyManage()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			Log.print("KeyManage::startup()");
			super.startup();
			
			Centre.stage.addEventListener(KeyboardEvent.KEY_DOWN, __keyDown);
			Centre.stage.addEventListener(KeyboardEvent.KEY_UP, __keyUp);
			
			startupComplete();
		}
		
		/** __keyDown */
		private function __keyDown(e:KeyboardEvent):void
		{
			if(Centre.stage.focus == null)
			{
				switch(e.keyCode)
				{
				case Keyboard.A:
					Game.fight.tryHit();
					break;
				case Keyboard.Q:
					OperIconField.instance.useItem(0);
					break;
				case Keyboard.W:
					OperIconField.instance.useItem(1);
					break;
				case Keyboard.E:
					OperIconField.instance.useItem(2);
					break;
				case Keyboard.R:
					OperIconField.instance.useItem(3);
					break;
				case Keyboard.NUMBER_1:
					OperIconField.instance.useItem(4);
					break;
				case Keyboard.NUMBER_2:
					OperIconField.instance.useItem(5);
					break;
				case Keyboard.NUMBER_3:
					OperIconField.instance.useItem(6);
					break;
				case Keyboard.NUMBER_4:
					OperIconField.instance.useItem(7);
					break;
				case Keyboard.DOWN:
					View.heroAttriFrame.showOrHide();
					break;
				}
			}
		}
		
		/** __keyUp */
		private function __keyUp(e:KeyboardEvent):void
		{
			
		}
		
	}
}