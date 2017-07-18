package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsTextArea;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIBaseText;
	import builder.view.prop.item.PIFill;
	import builder.view.prop.item.PIPair;
	import builder.view.prop.item.PIScrollBar;
	import builder.view.prop.item.PISize;
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class PropTextArea extends PropBase
	{
		private static var _instance:PropTextArea;
		public static function get instance():PropTextArea
		{
			if(_instance == null) { _instance = new PropTextArea(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_baseText:PIBaseText;
		private var this_defaultFill:PIFill;
		private var this_overFill:PIFill;
		private var this_uneditableFill:PIFill;
		
		private var this_scroll:PITemplate;
		
		public function PropTextArea()
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
			
			this_scroll = new PITemplate(JuiType.JScrollBarV, "scrollBar模版");
			addRoot(this_scroll);
		}
		
		override public function apply():void
		{
			super.apply();
			var textArea:CsTextArea = shell as CsTextArea;
			textArea.setWidth( this_size.getWidth() );
			textArea.setHeight( this_size.getHeight() );
			
			textArea.text = this_baseText.getText();
			textArea.autoWrap = this_baseText.getAutoWrap();
			textArea.useStroke = this_baseText.getUseStroke();
			textArea.strokeColor = this_baseText.getStrokeColor();
			textArea.strokeBlur = this_baseText.getStrokeBlur();
			textArea.strokeStrength = this_baseText.getStrokeStrength();
			textArea.font = this_baseText.getFont();
			textArea.size = this_baseText.getSize();
			textArea.color = this_baseText.getColor();
			textArea.bold = this_baseText.getBold();
			textArea.italic = this_baseText.getItalic();
			textArea.underline = this_baseText.getUnderline();
			
			textArea.defaultFill = this_defaultFill.getFill();
			textArea.overFill = this_overFill.getFill();
			textArea.uneditableFill = this_uneditableFill.getFill();
			
			textArea.tpl_scrollBar = this_scroll.value;
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var textArea:CsTextArea = shell as CsTextArea;
			this_size.setWidth( textArea.getWidth() );
			this_size.setHeight( textArea.getHeight() );
			
			this_baseText.setText( textArea.text );
			this_baseText.setAutoWrap( textArea.autoWrap );
			this_baseText.setUseStroke( textArea.useStroke );
			this_baseText.setStrokeColor( textArea.strokeColor );
			this_baseText.setStrokeBlur( textArea.strokeBlur );
			this_baseText.setStrokeStrength( textArea.strokeStrength );
			this_baseText.setFont( textArea.font );
			this_baseText.setSize( textArea.size );
			this_baseText.setColor( textArea.color );
			this_baseText.setBold( textArea.bold );
			this_baseText.setItalic( textArea.italic );
			this_baseText.setUnderline( textArea.underline );
			
			this_defaultFill.setFill( textArea.defaultFill );
			this_overFill.setFill( textArea.overFill );
			this_uneditableFill.setFill( textArea.uneditableFill );
			
			this_scroll.value = textArea.tpl_scrollBar;
		}
		
	}
}