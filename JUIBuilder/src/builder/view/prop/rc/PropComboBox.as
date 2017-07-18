package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsComboBox;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIDrop;
	import builder.view.prop.item.PIList;
	import builder.view.prop.item.PISize;
	
	import com.anstu.jui.define.JuiConst;
	
	public class PropComboBox extends PropBase
	{
		private static var _instance:PropComboBox;
		public static function get instance():PropComboBox
		{
			if(_instance == null) { _instance = new PropComboBox(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_openPos:PIDrop;
		private var this_list:PIList;
		private var label_button:PIButton;
		private var drop_button:PIButton;
		
		public function PropComboBox()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_openPos = new PIDrop(180, "openPosition", [JuiConst.DOWN, JuiConst.UP]);
			addRoot(this_openPos);
			
			this_list = new PIList();
			addRoot(this_list);
			
			label_button = new PIButton(false, false, false, "label");
			addRoot(label_button);
			
			drop_button = new PIButton(true, false, false, "dropButton");
			addRoot(drop_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var comboBox:CsComboBox = shell as CsComboBox;
			comboBox.setWidth( this_size.getWidth() );
			comboBox.setHeight( this_size.getHeight() );
			
			comboBox.openPos = this_openPos.getValue();
			
			comboBox.label_defaultFill = label_button.getDefaultFill();
			comboBox.label_overFill = label_button.getOverFill();
			comboBox.label_downFill = label_button.getDownFill();
			comboBox.label_disabledFill = label_button.getDisabledFill();
			comboBox.label_faceFill = label_button.getFaceFill();
			
			comboBox.drop_width = drop_button.getWidth();
			comboBox.drop_height = drop_button.getHeight();
			comboBox.drop_defaultFill = drop_button.getDefaultFill();
			comboBox.drop_overFill = drop_button.getOverFill();
			comboBox.drop_downFill = drop_button.getDownFill();
			comboBox.drop_disabledFill = drop_button.getDisabledFill();
			comboBox.drop_faceFill = drop_button.getFaceFill();
			
			comboBox.tpl_scrollBar = this_list.scrollBarPI.value;
			
			comboBox.defaultColor = this_list.defaultColorPI.getValue();
			comboBox.selectedColor = this_list.selectedColorPI.getValue();
			comboBox.rolloverColor = this_list.rolloverColorPI.getValue();
			comboBox.alternateColor = this_list.alternateColorPI.getValue();
			comboBox.alternateRows = this_list.alternateRowsPI.getValue();
			comboBox.autoHideScrollBar = this_list.autoHideScrollBarPI.getValue();
			
			comboBox.useStroke = this_list.labelPI.getUseStroke();
			comboBox.strokeColor = this_list.labelPI.getStrokeColor();
			comboBox.strokeBlur = this_list.labelPI.getStrokeBlur();
			comboBox.strokeStrength = this_list.labelPI.getStrokeStrength();
			comboBox.useHtml = this_list.labelPI.getUseHtml();
			comboBox.font = this_list.labelPI.getFont();
			comboBox.size = this_list.labelPI.getSize();
			comboBox.color = this_list.labelPI.getColor();
			comboBox.bold = this_list.labelPI.getBold();
			comboBox.italic = this_list.labelPI.getItalic();
			comboBox.underline = this_list.labelPI.getUnderline();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var comboBox:CsComboBox = shell as CsComboBox;
			this_size.setWidth( comboBox.getWidth() );
			this_size.setHeight( comboBox.getHeight() );
			
			this_openPos.setValue( comboBox.openPos );
			
			label_button.setDefaultFill( comboBox.label_defaultFill );
			label_button.setOverFill( comboBox.label_overFill );
			label_button.setDownFill( comboBox.label_downFill );
			label_button.setDisabledFill( comboBox.label_disabledFill );
			label_button.setFaceFill( comboBox.label_faceFill );
			
			drop_button.setWidth( comboBox.drop_width );
			drop_button.setHeight( comboBox.drop_height );
			drop_button.setDefaultFill( comboBox.drop_defaultFill );
			drop_button.setOverFill( comboBox.drop_overFill );
			drop_button.setDownFill( comboBox.drop_downFill );
			drop_button.setDisabledFill( comboBox.drop_disabledFill );
			drop_button.setFaceFill( comboBox.drop_faceFill );
			
			this_list.scrollBarPI.value = comboBox.tpl_scrollBar;
			
			this_list.defaultColorPI.setValue( comboBox.defaultColor );
			this_list.selectedColorPI.setValue( comboBox.selectedColor );
			this_list.rolloverColorPI.setValue( comboBox.rolloverColor );
			this_list.alternateColorPI.setValue( comboBox.alternateColor );
			this_list.alternateRowsPI.setValue( comboBox.alternateRows );
			this_list.autoHideScrollBarPI.setValue( comboBox.autoHideScrollBar );
			
			this_list.labelPI.setUseStroke( comboBox.useStroke );
			this_list.labelPI.setStrokeColor( comboBox.strokeColor );
			this_list.labelPI.setStrokeBlur( comboBox.strokeBlur );
			this_list.labelPI.setStrokeStrength( comboBox.strokeStrength );
			this_list.labelPI.setUseHtml( comboBox.useHtml );
			this_list.labelPI.setFont( comboBox.font );
			this_list.labelPI.setSize( comboBox.size );
			this_list.labelPI.setColor( comboBox.color );
			this_list.labelPI.setBold( comboBox.bold );
			this_list.labelPI.setItalic( comboBox.italic );
			this_list.labelPI.setUnderline( comboBox.underline );
		}
	}
}