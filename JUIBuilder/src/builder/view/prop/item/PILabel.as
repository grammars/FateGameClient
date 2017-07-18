package builder.view.prop.item
{
	public class PILabel extends PIBaseText
	{
		public function setUsePack(value:String):void { usePackPI.setValue(value); }
		public function getUsePack():String { return usePackPI.getValue(); }
		
		private var usePackPI:PIBoolean;
		
		public function PILabel(noteContent:String=null, hasMargin:Boolean=false)
		{
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 450;
			mainH = 280;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			usePackPI = new PIBoolean("usePack:");
			usePackPI.move(0, posY);
			addToMain(usePackPI);
			posY += usePackPI.paneH();
		}
	}
}