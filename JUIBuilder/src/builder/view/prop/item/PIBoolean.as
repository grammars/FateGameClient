package builder.view.prop.item
{
	import builder.view.base.BImage;
	
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.skin.JCheckBoxSkin;

	public class PIBoolean extends PropItemBase
	{
		protected var label:JLabel;
		protected var check:JCheckBox;
		
		public function setValue(value:String):void { check.selected = value=="true"?true:false; }
		public function getValue():String { return check.selected==true?"true":"false"; }
		
		private var szLabel:String;
		private var defaultValue:Boolean;
		
		public function PIBoolean(szLabel:String, defaultValue:Boolean=false, noteContent:String=null)
		{
			this.szLabel = szLabel;
			this.defaultValue = defaultValue;
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			mainW = 0;
			mainH = 30;
			noteW = 0;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			label = createEasyLabel(szLabel, mainW, 30, 0, 0);
			label.draw();
			label.width = label.textField.textWidth + 10;
			
			check = new JCheckBox("", "");
			
			mainW = label.width + 30;
			
			var unsel_default:BImage = new BImage("prop/unsel_default.png", 23, 21);
			var unsel_over:BImage = new BImage("prop/unsel_over.png", 23, 21);
			var unsel_down:BImage = new BImage("prop/unsel_down.png", 23, 21);
			
			var sel_default:BImage = new BImage("prop/sel_default.png", 23, 21);
			var sel_over:BImage = new BImage("prop/sel_over.png", 23, 21);
			var sel_down:BImage = new BImage("prop/sel_down.png", 23, 21);
			
			check.unselectedBtn.fillDefaultBg(unsel_default);
			check.unselectedBtn.fillOverBg(unsel_over);
			check.unselectedBtn.fillDownBg(unsel_down);
			
			check.selectedBtn.fillDefaultBg(sel_default);
			check.selectedBtn.fillOverBg(sel_over);
			check.selectedBtn.fillDownBg(sel_down);
			
			check.selected = defaultValue;
			check.setSize(23, 21);
			check.move(label.width+10, 10);
			this.addChild(check);
		}
	}
}