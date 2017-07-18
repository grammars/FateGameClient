package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsCheckBox;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PISize;
	
	public class PropCheckBox extends PropBase
	{
		private static var _instance:PropCheckBox;
		public static function get instance():PropCheckBox
		{
			if(_instance == null) { _instance = new PropCheckBox(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var unselected_button:PIButton;
		private var selected_button:PIButton;
		
		public function PropCheckBox()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			unselected_button = new PIButton(false, false, true, "unselected");
			addRoot(unselected_button);
			
			selected_button = new PIButton(false, false, true, "selected");
			addRoot(selected_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var checkBox:CsCheckBox = shell as CsCheckBox;
			checkBox.setWidth( this_size.getWidth() );
			checkBox.setHeight( this_size.getHeight() );
			
			//unselected
			checkBox.unsel_defaultFill = unselected_button.getDefaultFill();
			checkBox.unsel_overFill = unselected_button.getOverFill();
			checkBox.unsel_downFill = unselected_button.getDownFill();
			checkBox.unsel_disabledFill = unselected_button.getDisabledFill();
			checkBox.unsel_faceFill = unselected_button.getFaceFill();
			
			checkBox.unsel_label_text = unselected_button.labelPI.getText();
			checkBox.unsel_label_useStroke = unselected_button.labelPI.getUseStroke();
			checkBox.unsel_label_strokeColor = unselected_button.labelPI.getStrokeColor();
			checkBox.unsel_label_strokeBlur = unselected_button.labelPI.getStrokeBlur();
			checkBox.unsel_label_strokeStrength = unselected_button.labelPI.getStrokeStrength();
			checkBox.unsel_label_useHtml = unselected_button.labelPI.getUseHtml();
			checkBox.unsel_label_font = unselected_button.labelPI.getFont();
			checkBox.unsel_label_size = unselected_button.labelPI.getSize();
			checkBox.unsel_label_color = unselected_button.labelPI.getColor();
			checkBox.unsel_label_bold = unselected_button.labelPI.getBold();
			checkBox.unsel_label_italic = unselected_button.labelPI.getItalic();
			checkBox.unsel_label_underline = unselected_button.labelPI.getUnderline();
			
			//selected
			checkBox.sel_defaultFill = selected_button.getDefaultFill();
			checkBox.sel_overFill = selected_button.getOverFill();
			checkBox.sel_downFill = selected_button.getDownFill();
			checkBox.sel_disabledFill = selected_button.getDisabledFill();
			checkBox.sel_faceFill = selected_button.getFaceFill();
			
			checkBox.sel_label_text = selected_button.labelPI.getText();
			checkBox.sel_label_useStroke = selected_button.labelPI.getUseStroke();
			checkBox.sel_label_strokeColor = selected_button.labelPI.getStrokeColor();
			checkBox.sel_label_strokeBlur = selected_button.labelPI.getStrokeBlur();
			checkBox.sel_label_strokeStrength = selected_button.labelPI.getStrokeStrength();
			checkBox.sel_label_useHtml = selected_button.labelPI.getUseHtml();
			checkBox.sel_label_font = selected_button.labelPI.getFont();
			checkBox.sel_label_size = selected_button.labelPI.getSize();
			checkBox.sel_label_color = selected_button.labelPI.getColor();
			checkBox.sel_label_bold = selected_button.labelPI.getBold();
			checkBox.sel_label_italic = selected_button.labelPI.getItalic();
			checkBox.sel_label_underline = selected_button.labelPI.getUnderline();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var checkBox:CsCheckBox = shell as CsCheckBox;
			this_size.setWidth( checkBox.getWidth() );
			this_size.setHeight( checkBox.getHeight() );
			
			//unselected
			unselected_button.setDefaultFill( checkBox.unsel_defaultFill );
			unselected_button.setOverFill( checkBox.unsel_overFill );
			unselected_button.setDownFill( checkBox.unsel_downFill );
			unselected_button.setDisabledFill( checkBox.unsel_disabledFill );
			unselected_button.setFaceFill( checkBox.unsel_faceFill );
			
			unselected_button.labelPI.setText( checkBox.unsel_label_text );
			unselected_button.labelPI.setUseStroke( checkBox.unsel_label_useStroke );
			unselected_button.labelPI.setStrokeColor( checkBox.unsel_label_strokeColor );
			unselected_button.labelPI.setStrokeBlur( checkBox.unsel_label_strokeBlur );
			unselected_button.labelPI.setStrokeStrength( checkBox.unsel_label_strokeStrength );
			unselected_button.labelPI.setUseHtml( checkBox.unsel_label_useHtml );
			unselected_button.labelPI.setFont( checkBox.unsel_label_font );
			unselected_button.labelPI.setSize( checkBox.unsel_label_size );
			unselected_button.labelPI.setColor( checkBox.unsel_label_color );
			unselected_button.labelPI.setBold( checkBox.unsel_label_bold );
			unselected_button.labelPI.setItalic( checkBox.unsel_label_italic );
			unselected_button.labelPI.setUnderline( checkBox.unsel_label_underline );
			
			//selected
			selected_button.setDefaultFill( checkBox.sel_defaultFill );
			selected_button.setOverFill( checkBox.sel_overFill );
			selected_button.setDownFill( checkBox.sel_downFill );
			selected_button.setDisabledFill( checkBox.sel_disabledFill );
			selected_button.setFaceFill( checkBox.sel_faceFill );
			
			selected_button.labelPI.setText( checkBox.sel_label_text );
			selected_button.labelPI.setUseStroke( checkBox.sel_label_useStroke );
			selected_button.labelPI.setStrokeColor( checkBox.sel_label_strokeColor );
			selected_button.labelPI.setStrokeBlur( checkBox.sel_label_strokeBlur );
			selected_button.labelPI.setStrokeStrength( checkBox.sel_label_strokeStrength );
			selected_button.labelPI.setUseHtml( checkBox.sel_label_useHtml );
			selected_button.labelPI.setFont( checkBox.sel_label_font );
			selected_button.labelPI.setSize( checkBox.sel_label_size );
			selected_button.labelPI.setColor( checkBox.sel_label_color );
			selected_button.labelPI.setBold( checkBox.sel_label_bold );
			selected_button.labelPI.setItalic( checkBox.sel_label_italic );
			selected_button.labelPI.setUnderline( checkBox.sel_label_underline );
		}
		
	}
}