package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsLabel;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIBaseText;
	import builder.view.prop.item.PILabel;
	import builder.view.prop.item.PISize;
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.define.JuiType;
	
	public class PropLabel extends PropBase
	{
		private static var _instance:PropLabel;
		public static function get instance():PropLabel
		{
			if(_instance == null) { _instance = new PropLabel(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var tpl_label:PITemplate;
		
		private var this_label:PILabel;
		
		public function PropLabel()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			tpl_label = new PITemplate(JuiType.JLabel, "模版label");
			addRoot(tpl_label);
			
			this_label = new PILabel();
			this_label.hide("restrict", "maxChars", "password");
			addRoot(this_label);
		}
		
		override public function apply():void
		{
			super.apply();
			var label:CsLabel = shell as CsLabel;
			label.setWidth( this_size.getWidth() );
			label.setHeight( this_size.getHeight() );
			
			label.text = this_label.getText();
			label.align = this_label.getAlign();
			label.valign = this_label.getValign();
			label.autoWrap = this_label.getAutoWrap();
			label.useStroke = this_label.getUseStroke();
			label.strokeColor = this_label.getStrokeColor();
			label.strokeBlur = this_label.getStrokeBlur();
			label.strokeStrength = this_label.getStrokeStrength();
			label.useHtml = this_label.getUseHtml();
			label.font = this_label.getFont();
			label.size = this_label.getSize();
			label.color = this_label.getColor();
			label.bold = this_label.getBold();
			label.italic = this_label.getItalic();
			label.underline = this_label.getUnderline();
			label.usePack = this_label.getUsePack();
			
			if(tpl_label.available())
			{
				label.tpl_label = tpl_label.value;
			}
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var label:CsLabel = shell as CsLabel;
			this_size.setWidth( label.getWidth() );
			this_size.setHeight( label.getHeight() );
			
			this_label.setText( label.text );
			this_label.setAlign( label.align );
			this_label.setValign( label.valign );
			this_label.setAutoWrap( label.autoWrap );
			this_label.setUseStroke( label.useStroke );
			this_label.setStrokeColor( label.strokeColor );
			this_label.setStrokeBlur( label.strokeBlur );
			this_label.setStrokeStrength( label.strokeStrength );
			this_label.setUseHtml( label.useHtml );
			this_label.setFont( label.font );
			this_label.setSize( label.size );
			this_label.setColor( label.color );
			this_label.setBold( label.bold );
			this_label.setItalic( label.italic );
			this_label.setUnderline( label.underline );
			this_label.setUsePack( label.usePack );
			
			tpl_label.value = label.tpl_label;
		}
		
	}
}