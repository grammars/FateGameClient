package gamekit.layer
{
	import flash.display.Sprite;
	
	public class LoadingLayer extends Sprite
	{
		private var enable:Boolean = true;
		public function setEnable(value:Boolean):void
		{
			this.enable = value;
			this.mouseChildren = this.mouseEnabled = this.enable;
		}
		public function getEnable():Boolean { return this.enable; }
		
		public function LoadingLayer()
		{
			super();
		}
	}
}