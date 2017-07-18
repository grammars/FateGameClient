package builder.view.prop.rc
{
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIBaseText;
	import builder.view.prop.item.PILabel;
	import builder.view.prop.item.PILink;
	import builder.view.prop.item.PISize;
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.build.ctrls.CsLink;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.define.JuiType;
	
	public class PropLink extends PropBase
	{
		private static var _instance:PropLink;
		public static function get instance():PropLink
		{
			if(_instance == null) { _instance = new PropLink(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var tpl_label:PITemplate;
		
		private var this_link:PILink;
		
		public function PropLink()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			tpl_label = new PITemplate(JuiType.JLabel, "模版label");
			addRoot(tpl_label);
			
			this_link = new PILink();
			this_link.hide("restrict", "maxChars", "password");
			addRoot(this_link);
		}
		
		override public function apply():void
		{
			super.apply();
			var link:CsLink = shell as CsLink;
			link.setWidth( this_size.getWidth() );
			link.setHeight( this_size.getHeight() );
			
			link.text = this_link.getText();
			link.align = this_link.getAlign();
			link.valign = this_link.getValign();
			link.autoWrap = this_link.getAutoWrap();
			link.useStroke = this_link.getUseStroke();
			link.strokeColor = this_link.getStrokeColor();
			link.strokeBlur = this_link.getStrokeBlur();
			link.strokeStrength = this_link.getStrokeStrength();
			link.useHtml = this_link.getUseHtml();
			link.font = this_link.getFont();
			link.size = this_link.getSize();
			link.color = this_link.getColor();
			link.bold = this_link.getBold();
			link.italic = this_link.getItalic();
			link.underline = this_link.getUnderline();
			link.usePack = this_link.getUsePack();
			
			link.htmlDefault = this_link.getHtmlDefault();
			link.htmlOver = this_link.getHtmlOver();
			link.htmlPress = this_link.getHtmlPress();
			link.colorDefault = this_link.getColorDefault();
			link.colorOver = this_link.getColorOver();
			link.colorPress = this_link.getColorPress();
			
			if(tpl_label.available())
			{
				link.tpl_label = tpl_label.value;
			}
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var link:CsLink = shell as CsLink;
			this_size.setWidth( link.getWidth() );
			this_size.setHeight( link.getHeight() );
			
			this_link.setText( link.text );
			this_link.setAlign( link.align );
			this_link.setValign( link.valign );
			this_link.setAutoWrap( link.autoWrap );
			this_link.setUseStroke( link.useStroke );
			this_link.setStrokeColor( link.strokeColor );
			this_link.setStrokeBlur( link.strokeBlur );
			this_link.setStrokeStrength( link.strokeStrength );
			this_link.setUseHtml( link.useHtml );
			this_link.setFont( link.font );
			this_link.setSize( link.size );
			this_link.setColor( link.color );
			this_link.setBold( link.bold );
			this_link.setItalic( link.italic );
			this_link.setUnderline( link.underline );
			this_link.setUsePack( link.usePack );
			
			this_link.setHtmlDefault( link.htmlDefault );
			this_link.setHtmlOver( link.htmlOver );
			this_link.setHtmlPress( link.htmlPress );
			this_link.setColorDefault( link.colorDefault );
			this_link.setColorOver( link.colorOver );
			this_link.setColorPress( link.colorPress );
			
			tpl_label.value = link.tpl_label;
		}
		
	}
}