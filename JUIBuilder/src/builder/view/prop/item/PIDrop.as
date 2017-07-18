package builder.view.prop.item
{
	import com.anstu.jui.build.BU;
	
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JLabel;

	public class PIDrop extends PropItemBase
	{
		protected var label:JLabel;
		protected var drop:JComboBox;
		
		public function setValue(value:String):void { drop.selectedItem = value; }
		public function getValue():String { return BU.unRichStr(drop.selectedItem); }
		
		private var totalWidth:int;
		private var szLabel:String;
		private var data:Array;
		
		public function freshData(data:Array):void
		{
			this.data = data;
			drop.items = data;
		}
		
		public function PIDrop(totalWidth:int, szLabel:String, data:Array=null, noteContent:String=null, hasMargin:Boolean=true)
		{
			this.totalWidth = totalWidth;
			this.szLabel = szLabel;
			this.data = data;
			super(noteContent, hasMargin);
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
			drop = createDrop(Math.max(1, mainW-label.width-2), label.width+2, 0, data);
		}
		
	}
}