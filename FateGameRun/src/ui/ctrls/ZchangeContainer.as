package ui.ctrls{
	
	public class ZchangeContainer extends Ape{
		public function ZchangeContainer(width:Number = 400, height:Number = 300){
			super(width, height);
			this.uiType 	= UIInfo.TYPE_CONTAINER;
			this.uiSubType 	= UIInfo.ZCHANGE_CONTAINER;
		}
	}
}