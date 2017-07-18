package builder.view.prop.item
{
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;

	public class PIPosition extends PropItemBase
	{
		protected var xLabel:JLabel;
		protected var xInput:JInputText;
		protected var yLabel:JLabel;
		protected var yInput:JInputText;
		
		public function setX(value:String):void { xInput.text = value; }
		public function getX():String { return xInput.text; }
		
		public function setY(value:String):void { yInput.text = value; }
		public function getY():String { return yInput.text; }
		
		public function PIPosition(noteContent:String=null)
		{
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			mainW = 120;
			mainH = 30;
			noteW = 120;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			xLabel = createEasyLabel("x:", 20, 30, 0, 0);
			xInput = createEasyInput("", 40, 30, 20, 0);
			yLabel = createEasyLabel("y:", 20, 30, 60, 0);
			yInput = createEasyInput("", 40, 30, 80, 0);
		}
	}
}