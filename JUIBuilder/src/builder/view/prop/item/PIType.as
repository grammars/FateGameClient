package builder.view.prop.item
{
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;

	public class PIType extends PropItemBase
	{
		protected var typeLabel:JLabel;
		protected var typeInput:JInputText;
		
		public function setType(value:String):void { typeInput.text = value; }
		public function getType():String { return typeInput.text; }
		
		public function PIType(noteContent:String=null)
		{
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			mainW = 142;
			mainH = 30;
			noteW = 142;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			typeLabel = createEasyLabel("type:", 50, 30, 0, 0);
			typeInput = createEasyInput("", 90, 30, 52, 0);
		}
	}
}