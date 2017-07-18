package builder.view.prop.item
{
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	
	public class PIPairShort extends PropItemBase
	{
		protected var label:JLabel;
		protected var input:JInputText;
		
		public function setValue(value:String):void { input.text = value; }
		public function getValue():String { return input.text; }
		
		private var szLabel:String;
		private var szDefaultValue:String;
		
		public function PIPairShort(szLabel:String, szDefaultValue:String="", noteContent:String=null)
		{
			this.szLabel = szLabel;
			this.szDefaultValue = szDefaultValue;
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			super.setParam();
			mainH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			label = createEasyLabel(szLabel, SHORT_LABEL_W, SHORT_LABEL_H, 0, 0);
			input = createEasyInput(szDefaultValue, SHORT_INPUT_W, SHORT_INPUT_H, SHORT_LABEL_W+2, 0);
		}
	}
}