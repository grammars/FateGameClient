package builder.view.prop.item
{
	import builder.FontCfg;
	
	import com.anstu.jui.build.BU;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.utils.FontUtils;

	public class PIFont extends PropItemBase
	{
		protected var label:JLabel;
		protected var drop:JComboBox;
		
		public function setValue(value:String):void { drop.selectedItem = value; }
		public function getValue():String { return BU.unRichStr(drop.selectedItem); }
		
		public function PIFont(noteContent:String=null, hasMargin:Boolean=true)
		{
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 170;
			mainH = 30;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			label = createEasyLabel(" font:", mainW, 30, 0, 0, JuiConst.LEFT);
			
			drop = createDrop(140, 30, 2, FontCfg.fontNames);
		}
	}
}