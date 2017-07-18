package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsList;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIList;
	import builder.view.prop.item.PISize;
	
	public class PropList extends PropBase
	{
		private static var _instance:PropList;
		public static function get instance():PropList
		{
			if(_instance == null) { _instance = new PropList(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var this_list:PIList;
		
		public function PropList()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_list = new PIList();
			addRoot(this_list);
		}
		
		override public function apply():void
		{
			super.apply();
			var list:CsList = shell as CsList;
			list.setWidth( this_size.getWidth() );
			list.setHeight( this_size.getHeight() );
			
			list.defaultColor = this_list.defaultColorPI.getValue();
			list.selectedColor = this_list.selectedColorPI.getValue();
			list.rolloverColor = this_list.rolloverColorPI.getValue();
			list.alternateColor = this_list.alternateColorPI.getValue();
			list.alternateRows = this_list.alternateRowsPI.getValue();
			list.autoHideScrollBar = this_list.autoHideScrollBarPI.getValue();
			
			list.useStroke = this_list.labelPI.getUseStroke();
			list.strokeColor = this_list.labelPI.getStrokeColor();
			list.strokeBlur = this_list.labelPI.getStrokeBlur();
			list.strokeStrength = this_list.labelPI.getStrokeStrength();
			list.useHtml = this_list.labelPI.getUseHtml();
			list.font = this_list.labelPI.getFont();
			list.size = this_list.labelPI.getSize();
			list.color = this_list.labelPI.getColor();
			list.bold = this_list.labelPI.getBold();
			list.italic = this_list.labelPI.getItalic();
			list.underline = this_list.labelPI.getUnderline();
			
			if( this_list.scrollBarPI.available() )
			{
				list.tpl_scrollBar = this_list.scrollBarPI.value;
			}
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var list:CsList = shell as CsList;
			this_size.setWidth( list.getWidth() );
			this_size.setHeight( list.getHeight() );
			
			this_list.defaultColorPI.setValue( list.defaultColor );
			this_list.selectedColorPI.setValue( list.selectedColor );
			this_list.rolloverColorPI.setValue( list.rolloverColor );
			this_list.alternateColorPI.setValue( list.alternateColor );
			this_list.alternateRowsPI.setValue( list.alternateRows );
			this_list.autoHideScrollBarPI.setValue( list.autoHideScrollBar );
			
			this_list.labelPI.setUseStroke( list.useStroke );
			this_list.labelPI.setStrokeColor( list.strokeColor );
			this_list.labelPI.setStrokeBlur( list.strokeBlur );
			this_list.labelPI.setStrokeStrength( list.strokeStrength );
			this_list.labelPI.setUseHtml( list.useHtml );
			this_list.labelPI.setFont( list.font );
			this_list.labelPI.setSize( list.size );
			this_list.labelPI.setColor( list.color );
			this_list.labelPI.setBold( list.bold );
			this_list.labelPI.setItalic( list.italic );
			this_list.labelPI.setUnderline( list.underline );
			
			this_list.scrollBarPI.value = list.tpl_scrollBar;
		}
		
	}
}