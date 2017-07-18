package ui.ctrls
{
	public class ZchangeTileContainer extends TileContainer
	{
		public function ZchangeTileContainer(width:Number=200, height:Number=200)
		{
			super(width, height);
			this.uiType 	= UIInfo.TYPE_CONTAINER;
			this.uiSubType 	= UIInfo.ZCHANGE_TILE_CONTAINER;
		}
	}
}