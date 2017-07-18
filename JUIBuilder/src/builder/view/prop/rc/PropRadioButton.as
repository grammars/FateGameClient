package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsRadioButton;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIDrop;
	import builder.view.prop.item.PISize;
	import builder.view.radio.RadioGroupEditor;
	
	public class PropRadioButton extends PropBase
	{
		private static var _instance:PropRadioButton;
		public static function get instance():PropRadioButton
		{
			if(_instance == null) { _instance = new PropRadioButton(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var this_group:PIDrop;
		
		private var unselected_button:PIButton;
		private var selected_button:PIButton;
		
		public function groupsUpdate():void
		{
			this_group.freshData(RadioGroupEditor.instance.getDrops());
		}
		
		public function PropRadioButton()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_group = new PIDrop(200, "group:", RadioGroupEditor.instance.getDrops());
			addRoot(this_group);
			
			unselected_button = new PIButton(false, false, true, "unselected");
			addRoot(unselected_button);
			
			selected_button = new PIButton(false, false, true, "selected");
			addRoot(selected_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var radioButton:CsRadioButton = shell as CsRadioButton;
			radioButton.setWidth( this_size.getWidth() );
			radioButton.setHeight( this_size.getHeight() );
			
			radioButton.group = this_group.getValue();
			
			//unselected
			radioButton.unsel_defaultFill = unselected_button.getDefaultFill();
			radioButton.unsel_overFill = unselected_button.getOverFill();
			radioButton.unsel_downFill = unselected_button.getDownFill();
			radioButton.unsel_disabledFill = unselected_button.getDisabledFill();
			radioButton.unsel_faceFill = unselected_button.getFaceFill();
			
			radioButton.unsel_label_text = unselected_button.labelPI.getText();
			radioButton.unsel_label_useStroke = unselected_button.labelPI.getUseStroke();
			radioButton.unsel_label_strokeColor = unselected_button.labelPI.getStrokeColor();
			radioButton.unsel_label_strokeBlur = unselected_button.labelPI.getStrokeBlur();
			radioButton.unsel_label_strokeStrength = unselected_button.labelPI.getStrokeStrength();
			radioButton.unsel_label_useHtml = unselected_button.labelPI.getUseHtml();
			radioButton.unsel_label_font = unselected_button.labelPI.getFont();
			radioButton.unsel_label_size = unselected_button.labelPI.getSize();
			radioButton.unsel_label_color = unselected_button.labelPI.getColor();
			radioButton.unsel_label_bold = unselected_button.labelPI.getBold();
			radioButton.unsel_label_italic = unselected_button.labelPI.getItalic();
			radioButton.unsel_label_underline = unselected_button.labelPI.getUnderline();
			
			//selected
			radioButton.sel_defaultFill = selected_button.getDefaultFill();
			radioButton.sel_overFill = selected_button.getOverFill();
			radioButton.sel_downFill = selected_button.getDownFill();
			radioButton.sel_disabledFill = selected_button.getDisabledFill();
			radioButton.sel_faceFill = selected_button.getFaceFill();
			
			radioButton.sel_label_text = selected_button.labelPI.getText();
			radioButton.sel_label_useStroke = selected_button.labelPI.getUseStroke();
			radioButton.sel_label_strokeColor = selected_button.labelPI.getStrokeColor();
			radioButton.sel_label_strokeBlur = selected_button.labelPI.getStrokeBlur();
			radioButton.sel_label_strokeStrength = selected_button.labelPI.getStrokeStrength();
			radioButton.sel_label_useHtml = selected_button.labelPI.getUseHtml();
			radioButton.sel_label_font = selected_button.labelPI.getFont();
			radioButton.sel_label_size = selected_button.labelPI.getSize();
			radioButton.sel_label_color = selected_button.labelPI.getColor();
			radioButton.sel_label_bold = selected_button.labelPI.getBold();
			radioButton.sel_label_italic = selected_button.labelPI.getItalic();
			radioButton.sel_label_underline = selected_button.labelPI.getUnderline();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var radioButton:CsRadioButton = shell as CsRadioButton;
			this_size.setWidth( radioButton.getWidth() );
			this_size.setHeight( radioButton.getHeight() );
			
			this_group.setValue( radioButton.group );
			
			//unselected
			unselected_button.setDefaultFill( radioButton.unsel_defaultFill );
			unselected_button.setOverFill( radioButton.unsel_overFill );
			unselected_button.setDownFill( radioButton.unsel_downFill );
			unselected_button.setDisabledFill( radioButton.unsel_disabledFill );
			unselected_button.setFaceFill( radioButton.unsel_faceFill );
			
			unselected_button.labelPI.setText( radioButton.unsel_label_text );
			unselected_button.labelPI.setUseStroke( radioButton.unsel_label_useStroke );
			unselected_button.labelPI.setStrokeColor( radioButton.unsel_label_strokeColor );
			unselected_button.labelPI.setStrokeBlur( radioButton.unsel_label_strokeBlur );
			unselected_button.labelPI.setStrokeStrength( radioButton.unsel_label_strokeStrength );
			unselected_button.labelPI.setUseHtml( radioButton.unsel_label_useHtml );
			unselected_button.labelPI.setFont( radioButton.unsel_label_font );
			unselected_button.labelPI.setSize( radioButton.unsel_label_size );
			unselected_button.labelPI.setColor( radioButton.unsel_label_color );
			unselected_button.labelPI.setBold( radioButton.unsel_label_bold );
			unselected_button.labelPI.setItalic( radioButton.unsel_label_italic );
			unselected_button.labelPI.setUnderline( radioButton.unsel_label_underline );
			
			//selected
			selected_button.setDefaultFill( radioButton.sel_defaultFill );
			selected_button.setOverFill( radioButton.sel_overFill );
			selected_button.setDownFill( radioButton.sel_downFill );
			selected_button.setDisabledFill( radioButton.sel_disabledFill );
			selected_button.setFaceFill( radioButton.sel_faceFill );
			
			selected_button.labelPI.setText( radioButton.sel_label_text );
			selected_button.labelPI.setUseStroke( radioButton.sel_label_useStroke );
			selected_button.labelPI.setStrokeColor( radioButton.sel_label_strokeColor );
			selected_button.labelPI.setStrokeBlur( radioButton.sel_label_strokeBlur );
			selected_button.labelPI.setStrokeStrength( radioButton.sel_label_strokeStrength );
			selected_button.labelPI.setUseHtml( radioButton.sel_label_useHtml );
			selected_button.labelPI.setFont( radioButton.sel_label_font );
			selected_button.labelPI.setSize( radioButton.sel_label_size );
			selected_button.labelPI.setColor( radioButton.sel_label_color );
			selected_button.labelPI.setBold( radioButton.sel_label_bold );
			selected_button.labelPI.setItalic( radioButton.sel_label_italic );
			selected_button.labelPI.setUnderline( radioButton.sel_label_underline );
		}
		
	}
}