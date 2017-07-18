package ui.view
{
	import central.Centre;
	
	import com.anstu.jui.controls.JPanel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import gamekit.layer.Layer;
	
	public class BasePane extends JPanel implements IBasePane
	{
		/** 所属layer层 */
		public var layer:Sprite;
		
		public function BasePane()
		{
			layer = Layer.ui;
			putDefaultPos();
			Centre.stage.addEventListener(Event.RESIZE, putDefaultPos);
		}
		
		public function show():void
		{
			layer.addChild(this);
		}
		
		public function hide():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
		
		/** 显示/隐藏 */
		public function showOrHide():void
		{
			if(this.parent) { hide(); }
			else { show(); }
		}
		
		public function putDefaultPos(event:Event=null):void
		{
		}
		
		/** 摆放位置到舞台中央 */
		public function putCentre():void
		{
			this.x = (Centre.stage.stageWidth - this.width) / 2;
			this.y = (Centre.stage.stageHeight - this.height) / 2;
		}
		
		/** 摆放到当前层的最前面 */
		public function putTop():void
		{
			
		}
		
	}
}