package builder.view.prop.item
{
	public class PILink extends PILabel
	{
		public function setHtmlDefault(value:String):void { htmlDefaultPI.setValue(value); }
		public function getHtmlDefault():String { return htmlDefaultPI.getValue(); }
		
		public function setHtmlOver(value:String):void { htmlOverPI.setValue(value); }
		public function getHtmlOver():String { return htmlOverPI.getValue(); }
		
		public function setHtmlPress(value:String):void { htmlPressPI.setValue(value); }
		public function getHtmlPress():String { return htmlPressPI.getValue(); }
		
		public function setColorDefault(value:String):void { colorDefaultPI.setValue(value); }
		public function getColorDefault():String { return colorDefaultPI.getValue(); }
		
		public function setColorOver(value:String):void { colorOverPI.setValue(value); }
		public function getColorOver():String { return colorOverPI.getValue(); }
		
		public function setColorPress(value:String):void { colorPressPI.setValue(value); }
		public function getColorPress():String { return colorPressPI.getValue(); }
		
		private var htmlDefaultPI:PIPair;
		private var htmlOverPI:PIPair;
		private var htmlPressPI:PIPair;
		private var colorDefaultPI:PIPair;
		private var colorOverPI:PIPair;
		private var colorPressPI:PIPair;
		
		public function PILink(noteContent:String=null, hasMargin:Boolean=false)
		{
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 450;
			mainH = 400;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			htmlDefaultPI = new PIPair(400, "htmlDefault:");
			addAndPut(htmlDefaultPI, true);
			
			htmlOverPI = new PIPair(400, "htmlOverPI:");
			addAndPut(htmlOverPI, true);
			
			htmlPressPI = new PIPair(400, "htmlPressPI:");
			addAndPut(htmlPressPI, true);
			
			colorDefaultPI = new PIPair(400, "colorDefaultPI:");
			addAndPut(colorDefaultPI, true);
			
			colorOverPI = new PIPair(400, "colorOverPI:");
			addAndPut(colorOverPI, true);
			
			colorPressPI = new PIPair(400, "colorPressPI:");
			addAndPut(colorPressPI, true);
		}
	}
}