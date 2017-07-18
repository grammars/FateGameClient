package builder.view.prop.item
{
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;

	public class PIPairLong extends PropItemBase
	{
		protected var label:JLabel;
		protected var input:JInputText;
		
		public function setValue(value:String):void { input.text = value; }
		public function getValue():String { return input.text; }
		
		private var szLabel:String;
		private var szDefaultValue:String;
		
		public function PIPairLong(szLabel:String, szDefaultValue:String="", noteContent:String=null)
		{
			this.szLabel = szLabel;
			this.szDefaultValue = szDefaultValue;
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			super.setParam();
			mainH = 60;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			label = createEasyLabel(szLabel, LONG_LABEL_W, LONG_LABEL_H, 0, 0);
			input = createEasyInput(szDefaultValue, LONG_INPUT_W, LONG_INPUT_H, 0, 30);
		}
		
	}
}