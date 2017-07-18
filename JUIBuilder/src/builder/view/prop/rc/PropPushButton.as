package builder.view.prop.rc
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.CsPushButton;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PISize;
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.define.JuiType;
	
	public class PropPushButton extends PropBase
	{
		private static var _instance:PropPushButton;
		public static function get instance():PropPushButton
		{
			if(_instance == null) { _instance = new PropPushButton(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var tpl_button:PITemplate;
		private var this_button:PIButton;
		
		public function PropPushButton()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			tpl_button = new PITemplate(JuiType.JPushButton, "模版button");
			addRoot(tpl_button);
			
			this_button = new PIButton(false, false, true);
			addRoot(this_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var pushButton:CsPushButton = shell as CsPushButton;
			pushButton.setWidth( this_size.getWidth() );
			pushButton.setHeight( this_size.getHeight() );
			
			pushButton.defaultFill = this_button.getDefaultFill();
			pushButton.overFill = this_button.getOverFill();
			pushButton.downFill = this_button.getDownFill();
			pushButton.disabledFill = this_button.getDisabledFill();
			pushButton.faceFill = this_button.getFaceFill();
			
			pushButton.label_text = this_button.labelPI.getText();
			pushButton.label_useStroke = this_button.labelPI.getUseStroke();
			pushButton.label_strokeColor = this_button.labelPI.getStrokeColor();
			pushButton.label_strokeBlur = this_button.labelPI.getStrokeBlur();
			pushButton.label_strokeStrength = this_button.labelPI.getStrokeStrength();
			pushButton.label_useHtml = this_button.labelPI.getUseHtml();
			pushButton.label_font = this_button.labelPI.getFont();
			pushButton.label_size = this_button.labelPI.getSize();
			pushButton.label_color = this_button.labelPI.getColor();
			pushButton.label_bold = this_button.labelPI.getBold();
			pushButton.label_italic = this_button.labelPI.getItalic();
			pushButton.label_underline = this_button.labelPI.getUnderline();
			
			if(tpl_button.available())
			{
				pushButton.tpl_button = tpl_button.value;
			}
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var pushButton:CsPushButton = shell as CsPushButton;
			this_size.setWidth( pushButton.getWidth() );
			this_size.setHeight( pushButton.getHeight() );
			
			this_button.setDefaultFill( pushButton.defaultFill );
			this_button.setOverFill( pushButton.overFill );
			this_button.setDownFill( pushButton.downFill );
			this_button.setDisabledFill( pushButton.disabledFill );
			this_button.setFaceFill( pushButton.faceFill );
			
			this_button.labelPI.setText( pushButton.label_text );
			this_button.labelPI.setUseStroke( pushButton.label_useStroke );
			this_button.labelPI.setStrokeColor( pushButton.label_strokeColor );
			this_button.labelPI.setStrokeBlur( pushButton.label_strokeBlur );
			this_button.labelPI.setStrokeStrength( pushButton.label_strokeStrength );
			this_button.labelPI.setUseHtml( pushButton.label_useHtml );
			this_button.labelPI.setFont( pushButton.label_font );
			this_button.labelPI.setSize( pushButton.label_size );
			this_button.labelPI.setColor( pushButton.label_color );
			this_button.labelPI.setBold( pushButton.label_bold );
			this_button.labelPI.setItalic( pushButton.label_italic );
			this_button.labelPI.setUnderline( pushButton.label_underline );
			
			tpl_button.value = pushButton.tpl_button;
		}
	}
}