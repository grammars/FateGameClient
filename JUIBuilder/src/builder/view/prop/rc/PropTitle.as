package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsTitle;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIBaseText;
	import builder.view.prop.item.PIPair;
	import builder.view.prop.item.PISize;
	import builder.view.prop.item.PITitle;
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.define.JuiType;
	
	public class PropTitle extends PropBase
	{
		private static var _instance:PropTitle;
		public static function get instance():PropTitle
		{
			if(_instance == null) { _instance = new PropTitle(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_text:PITitle;
		private var tpl_title:PITemplate;
		
		public function PropTitle()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_text = new PITitle();
			this_text.hide("color", "useHtml");
			addRoot(this_text);
			
			tpl_title = new PITemplate(JuiType.JTitle, "title模版");
			addRoot(tpl_title);
		}
		
		override public function apply():void
		{
			super.apply();
			var title:CsTitle = shell as CsTitle;
			title.setWidth( this_size.getWidth() );
			title.setHeight( this_size.getHeight() );
			
			title.gradBeg = this_text.getGradBeg();
			title.gradEnd = this_text.getGradEnd();
			
			title.text = this_text.getText();
			title.align = this_text.getAlign();
			title.valign = this_text.getValign();
			title.autoWrap = this_text.getAutoWrap();
			title.useStroke = this_text.getUseStroke();
			title.strokeColor = this_text.getStrokeColor();
			title.strokeBlur = this_text.getStrokeBlur();
			title.strokeStrength = this_text.getStrokeStrength();
			title.font = this_text.getFont();
			title.size = this_text.getSize();
			title.bold = this_text.getBold();
			title.italic = this_text.getItalic();
			title.underline = this_text.getUnderline();
			
			if(tpl_title.available())
			{
				title.tpl_title = tpl_title.value;
			}
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var title:CsTitle = shell as CsTitle;
			this_size.setWidth( title.getWidth() );
			this_size.setHeight( title.getHeight() );
			
			this_text.setGradBeg( title.gradBeg );
			this_text.setGradEnd( title.gradEnd );
			
			this_text.setText( title.text );
			this_text.setAlign( title.align );
			this_text.setValign( title.valign );
			this_text.setAutoWrap( title.autoWrap );
			this_text.setUseStroke( title.useStroke );
			this_text.setStrokeColor( title.strokeColor );
			this_text.setStrokeBlur( title.strokeBlur );
			this_text.setStrokeStrength( title.strokeStrength );
			this_text.setFont( title.font );
			this_text.setSize( title.size );
			this_text.setBold( title.bold );
			this_text.setItalic( title.italic );
			this_text.setUnderline( title.underline );
			
			tpl_title.value = title.tpl_title;
		}
		
	}
}