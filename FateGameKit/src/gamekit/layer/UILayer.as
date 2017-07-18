package gamekit.layer
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import gamekit.FateGameKit;
	
	public class UILayer extends Sprite
	{
		private var enable:Boolean = true;
		public function setEnable(value:Boolean):void
		{
			this.enable = value;
			this.mouseChildren = this.mouseEnabled = this.enable;
		}
		public function getEnable():Boolean { return this.enable; }
		
		public function UILayer()
		{
			super();
		}
		
		public function putCentre(child:DisplayObject):void
		{
			child.x = (FateGameKit.STAGE.stageWidth - child.width) / 2;
			child.y = (FateGameKit.STAGE.stageHeight - child.height) / 2;
			this.addChild(child);
		}
		
	}
}