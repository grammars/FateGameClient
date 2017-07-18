package builder.view.prop.item
{
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;

	public class PISize extends PropItemBase
	{
		protected var widthLabel:JLabel;
		protected var widthInput:JInputText;
		protected var heightLabel:JLabel;
		protected var heightInput:JInputText;
		
		public function setWidth(value:String):void { widthInput.text = value; }
		public function getWidth():String { return widthInput.text; }
		
		public function setHeight(value:String):void { heightInput.text = value; }
		public function getHeight():String { return heightInput.text; }
		
		public function PISize(noteContent:String=null)
		{
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			mainW = 160;
			mainH = 30;
			noteW = 160;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			widthLabel = createEasyLabel("width:", 40, 30, 0, 0);
			widthInput = createEasyInput("", 40, 30, 40, 0);
			heightLabel = createEasyLabel("height:", 40, 30, 80, 0);
			heightInput = createEasyInput("", 40, 30, 120, 0);
		}
		
	}
}