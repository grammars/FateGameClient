package builder.view.prop.item
{
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.define.JuiType;

	public class PIList extends PropItemBase
	{
		public var defaultColorPI:PIPair;
		public var selectedColorPI:PIPair;
		public var rolloverColorPI:PIPair;
		public var alternateColorPI:PIPair;
		public var alternateRowsPI:PIBoolean;
		public var autoHideScrollBarPI:PIBoolean;
		
		public var labelPI:PIBaseText;
		
		public var scrollBarPI:PITemplate;
		
		public function PIList(noteContent:String=null, hasMargin:Boolean=true)
		{
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 460;
			mainH = 495;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			defaultColorPI = new PIPair(200, "defaultColor:");
			addAndPut(defaultColorPI, false);
			
			selectedColorPI = new PIPair(210, "selectedColor:");
			addAndPut(selectedColorPI, true);
			
			rolloverColorPI = new PIPair(210, "rolloverColor:");
			addAndPut(rolloverColorPI, false);
			
			alternateColorPI = new PIPair(210, "alternateColor:");
			addAndPut(alternateColorPI, true);
			
			alternateRowsPI = new PIBoolean("alternateRows:");
			addAndPut(alternateRowsPI, false);
			
			autoHideScrollBarPI = new PIBoolean("autoHideScrollBar:");
			addAndPut(autoHideScrollBarPI, true);
			
			labelPI = new PIBaseText("item.label");
			labelPI.hide("text", "align", "valign", "autoWrap", 
				"restrict", "maxChars", "password");
			addAndPut(labelPI, true);
			
			scrollBarPI = new PITemplate(JuiType.JScrollBarV, "scrollBar模版");
			addAndPut(scrollBarPI, true);
		}
			
	}
}