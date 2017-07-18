package builder.view.prop.item
{
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;

	public class PIPair extends PropItemBase
	{	
		protected var label:JLabel;
		public var input:JInputText;
		
		/** 不进行特殊处理，只保留原生态的文本内容 */
		private static const SOURCE_TAG:String = "{source}";
		
		public function setValue(value:String):void 
		{
			input.text = value;
		}
		public function getValue():String
		{
			var ctt:String = input.text;
			if(ctt == null) { ctt=""; }
			if(ctt.indexOf(SOURCE_TAG) != -1)
			{
				ctt = ctt.split(SOURCE_TAG).join("");
			}
			else
			{
				ctt = ctt.split("\\r").join("\r");
				ctt = ctt.split("\\n").join("\n");
			}
			return ctt;
		}
		
		private var totalWidth:int;
		private var szLabel:String;
		private var szDefaultValue:String;
		
		public function PIPair(totalWidth:int, szLabel:String, szDefaultValue:String="", noteContent:String=null)
		{
			this.totalWidth = totalWidth;
			this.szLabel = szLabel;
			this.szDefaultValue = szDefaultValue;
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			mainW = Math.max(1, hasMargin ? totalWidth-MARGIN*2 : totalWidth);
			mainH = 30;
			noteW = 160;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			label = createEasyLabel(szLabel, mainW, 30, 0, 0);
			label.draw();
			label.width = label.textField.textWidth + 10;
			
			input = createEasyInput(szDefaultValue, Math.max(1, mainW-label.width), 30, label.width+2, 0);
		}
	}
}