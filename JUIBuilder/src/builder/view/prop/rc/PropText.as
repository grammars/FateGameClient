package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsText;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIBaseText;
	import builder.view.prop.item.PIFill;
	import builder.view.prop.item.PISize;
	
	public class PropText extends PropBase
	{
		private static var _instance:PropText;
		public static function get instance():PropText
		{
			if(_instance == null) { _instance = new PropText(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_baseText:PIBaseText;
		private var this_defaultFill:PIFill;
		private var this_overFill:PIFill;
		private var this_uneditableFill:PIFill;
		
		public function PropText()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_baseText = new PIBaseText();
			this_baseText.hide("align", "valign", "maxChars", "useHtml");
			addRoot(this_baseText);
			
			this_defaultFill = new PIFill("defaultFill");
			addRoot(this_defaultFill);
			
			this_overFill = new PIFill("overFill");
			addRoot(this_overFill);
			
			this_uneditableFill = new PIFill("uneditableFill");
			addRoot(this_uneditableFill);
		}
		
		override public function apply():void
		{
			super.apply();
			var text:CsText = shell as CsText;
			text.setWidth( this_size.getWidth() );
			text.setHeight( this_size.getHeight() );
			
			text.text = this_baseText.getText();
			text.autoWrap = this_baseText.getAutoWrap();
			text.useStroke = this_baseText.getUseStroke();
			text.strokeColor = this_baseText.getStrokeColor();
			text.strokeBlur = this_baseText.getStrokeBlur();
			text.strokeStrength = this_baseText.getStrokeStrength();
			text.font = this_baseText.getFont();
			text.size = this_baseText.getSize();
			text.color = this_baseText.getColor();
			text.bold = this_baseText.getBold();
			text.italic = this_baseText.getItalic();
			text.underline = this_baseText.getUnderline();
			
			text.defaultFill = this_defaultFill.getFill();
			text.overFill = this_overFill.getFill();
			text.uneditableFill = this_uneditableFill.getFill();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var text:CsText = shell as CsText;
			this_size.setWidth( text.getWidth() );
			this_size.setHeight( text.getHeight() );
			
			this_baseText.setText( text.text );
			this_baseText.setAutoWrap( text.autoWrap );
			this_baseText.setUseStroke( text.useStroke );
			this_baseText.setStrokeColor( text.strokeColor );
			this_baseText.setStrokeBlur( text.strokeBlur );
			this_baseText.setStrokeStrength( text.strokeStrength );
			this_baseText.setFont( text.font );
			this_baseText.setSize( text.size );
			this_baseText.setColor( text.color );
			this_baseText.setBold( text.bold );
			this_baseText.setItalic( text.italic );
			this_baseText.setUnderline( text.underline );
			
			this_defaultFill.setFill( text.defaultFill );
			this_overFill.setFill( text.overFill );
			this_uneditableFill.setFill( text.uneditableFill );
		}
		
	}
}