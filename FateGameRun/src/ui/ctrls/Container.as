package ui.ctrls{
	public class Container extends Ape{
		public function Container(width:Number = 400, height:Number = 300){
			super(width, height);
			this.uiType 	= UIInfo.TYPE_CONTAINER;
			this.uiSubType 	= UIInfo.CONTAINER;
		}
	}
}