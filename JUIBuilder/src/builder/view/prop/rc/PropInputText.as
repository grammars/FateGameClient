package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsInputText;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIBaseText;
	import builder.view.prop.item.PISize;
	
	public class PropInputText extends PropBase
	{
		private static var _instance:PropInputText;
		public static function get instance():PropInputText
		{
			if(_instance == null) { _instance = new PropInputText(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var this_baseText:PIBaseText;
		
		public function PropInputText()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_baseText = new PIBaseText();
			this_baseText.hide("valign", "useHtml", "autoWrap");
			addRoot(this_baseText);
		}
		
		override public function apply():void
		{
			super.apply();
			var inputText:CsInputText = shell as CsInputText;
			inputText.setWidth( this_size.getWidth() );
			inputText.setHeight( this_size.getHeight() );
			
			inputText.text = this_baseText.getText();
			inputText.align = this_baseText.getAlign();
			inputText.restrict = this_baseText.getRestrict();
			inputText.maxChars = this_baseText.getMaxChars();
			inputText.password = this_baseText.getPassword();
			inputText.useStroke = this_baseText.getUseStroke();
			inputText.strokeColor = this_baseText.getStrokeColor();
			inputText.strokeBlur = this_baseText.getStrokeBlur();
			inputText.strokeStrength = this_baseText.getStrokeStrength();
			inputText.font = this_baseText.getFont();
			inputText.size = this_baseText.getSize();
			inputText.color = this_baseText.getColor();
			inputText.bold = this_baseText.getBold();
			inputText.italic = this_baseText.getItalic();
			inputText.underline = this_baseText.getUnderline();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var inputText:CsInputText = shell as CsInputText;
			this_size.setWidth( inputText.getWidth() );
			this_size.setHeight( inputText.getHeight() );
			
			this_baseText.setText( inputText.text );
			this_baseText.setAlign( inputText.align );
			this_baseText.setRestrict( inputText.restrict );
			this_baseText.setMaxChars( inputText.maxChars );
			this_baseText.setPassword( inputText.password );
			this_baseText.setUseStroke( inputText.useStroke );
			this_baseText.setStrokeColor( inputText.strokeColor );
			this_baseText.setStrokeBlur( inputText.strokeBlur );
			this_baseText.setStrokeStrength( inputText.strokeStrength );
			this_baseText.setFont( inputText.font );
			this_baseText.setSize( inputText.size );
			this_baseText.setColor( inputText.color );
			this_baseText.setBold( inputText.bold );
			this_baseText.setItalic( inputText.italic );
			this_baseText.setUnderline( inputText.underline );
		}
		
	}
}