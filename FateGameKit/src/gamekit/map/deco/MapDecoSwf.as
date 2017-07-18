package gamekit.map.deco
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import gamekit.component.Swf;
	import gamekit.map.deco.struct.StMapDecoCfg;
	
	public class MapDecoSwf extends Swf
	{
		private var cfg:StMapDecoCfg;
		public function getCfg():StMapDecoCfg { return cfg; }
		
		private static const DEBUG:Boolean = true;
		
		private var debugLabel:TextField;
		
		public function MapDecoSwf(cfg:StMapDecoCfg)
		{
			super();
			this.cfg = cfg;
			if(DEBUG)
			{
				debugLabel = new TextField();
				debugLabel.width = 120;
				debugLabel.height = 24;
				debugLabel.autoSize = TextFieldAutoSize.CENTER;
				debugLabel.mouseEnabled = false;
				debugLabel.mouseWheelEnabled = false;
				debugLabel.multiline = true;
				debugLabel.htmlText = "<b><font color='#2b2b2b'>id:" + cfg.mapId + "</font>"
					+ "<br><font color='#3bc03b'> (" + cfg.mapX + "," + cfg.mapY + ")</font></b>";
			}
		}
		
		
		
		override public function addTo(pContainer:DisplayObjectContainer):void
		{
			super.addTo(pContainer);
			if(pContainer && DEBUG)
			{
				debugLabel.x = _x - debugLabel.width/2;
				debugLabel.y = _y - debugLabel.height/2;
				pContainer.addChild(debugLabel);
			}
		}
		
		override public function remove():void
		{
			super.remove();
			if(debugLabel && debugLabel.parent) { debugLabel.parent.removeChild(debugLabel); }
		}
		
	}
}