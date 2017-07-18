package builder.view.prop.item
{
	public class PITitle extends PIBaseText
	{
		public function setGradBeg(value:String):void { gradBegPI.setValue(value); }
		public function getGradBeg():String { return gradBegPI.getValue(); }
		
		public function setGradEnd(value:String):void { gradEndPI.setValue(value); }
		public function getGradEnd():String { return gradEndPI.getValue(); }
		
		private var gradBegPI:PIPair;
		private var gradEndPI:PIPair;
		
		public function PITitle(noteContent:String=null, hasMargin:Boolean=false)
		{
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 450;
			mainH = 310;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			gradBegPI = new PIPair(120, "gradBeg:");
			addAndPut(gradBegPI, false);
			
			gradEndPI = new PIPair(120, "gradEnd:");
			addAndPut(gradEndPI, true);
			
			this.hide("restrict", "maxChars", "password");
		}
	}
}