package ui.view.buff
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import res.Res;
	
	import comm.component.buff.Buff;
	
	public class BuffIcon extends Sprite
	{
		public static const W:int = 24;
		public static const H:int = 24;
		
		public var info:Buff;
		private var icon:Bitmap = new Bitmap();
		
		public function BuffIcon(info:Buff)
		{
			super();
			this.info = info;
			this.graphics.clear();
			this.graphics.beginFill(0x121212, 1);
			this.graphics.drawRect(0, 0, W, H);
			this.graphics.endFill();
			Res.fillIcon(icon, "buff/"+info.config.icon+".jpg");
			this.addChild(icon);
			
			this.addEventListener(MouseEvent.ROLL_OVER, __rollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, __rollOut);
		}
		
		private function __rollOver(e:MouseEvent):void
		{
			BuffTip.instance.fill(info);
			BuffTip.instance.show();
		}
		
		private function __rollOut(e:MouseEvent):void
		{
			BuffTip.instance.hide();
		}
		
	}
}