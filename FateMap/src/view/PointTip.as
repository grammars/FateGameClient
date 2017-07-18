package view
{
	import flash.events.MouseEvent;
	
	import model.WorkConfig;

	public class PointTip
	{
		private static var _me:PointTip;
		public static function me():PointTip
		{
			if(_me == null) { _me = new PointTip(); }
			return _me;
		}
		
		private var tip:Tip;
		
		public function PointTip()
		{
			tip = new Tip();
		}
		
		public function show():void
		{
			CanvasPanel.me().getCover().addChild(tip);
			CanvasPanel.me().getCover().addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		}
		
		private function __mouseMove(e:MouseEvent):void
		{
			var lx:int = e.localX;
			var ly:int = e.localY;
			tip.x = lx+10;
			tip.y = ly+10;
			var gx:int = Math.floor(lx / WorkConfig.me().getGridW());
			var gy:int = Math.floor(ly / WorkConfig.me().getGridH());
			tip.setText("(" + gx + "," + gy + ")");
		}
		
		public function hide():void
		{
			if(tip.parent) { tip.parent.removeChild(tip); }
			CanvasPanel.me().getCover().removeEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		}
		
	}
}


import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

class Tip extends Sprite
{
	private var tf:TextField = new TextField();
	
	public function Tip()
	{
		this.graphics.lineStyle(2, 0xffffff, 0.8);
		this.graphics.beginFill(0xffffff, 0.5);
		this.graphics.drawRoundRect(0, 0, 60, 30, 3, 3);
		tf.x = tf.y = 5;
		tf.defaultTextFormat = new TextFormat("微软雅黑", 12, 0x0, true);
		this.addChild(tf);
		this.mouseEnabled = this.mouseChildren = false;
	}
	
	public function setText(txt:String):void
	{
		tf.text = txt;
	}
}