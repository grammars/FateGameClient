package builder.view.prop.item
{
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;

	public class PITag extends PropItemBase
	{
		protected var tagLabel:JLabel;
		protected var tagInput:JInputText;
		
		public function setTag(value:String):void { tagInput.text = value; }
		public function getTag():String { return tagInput.text; }
		
		public function PITag(noteContent:String=null)
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
			tagLabel = createEasyLabel("tag:", 50, 30, 0, 0);
			tagInput = createEasyInput("", 90, 30, 52, 0);
		}

		
	}
}