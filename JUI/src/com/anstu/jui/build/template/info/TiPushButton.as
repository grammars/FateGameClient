package com.anstu.jui.build.template.info
{
	import com.anstu.jui.build.ctrls.CsPushButton;
	import com.anstu.jui.build.template.TemplateInfo;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.define.JuiType;
	
	public class TiPushButton extends TemplateInfo
	{
		public var defaultFill:String;
		public var overFill:String;
		public var downFill:String;
		public var disabledFill:String;
		public var faceFill:String;
		
		public var label_useStroke:String;
		public var label_strokeColor:String;
		public var label_strokeBlur:String;
		public var label_strokeStrength:String;
		public var label_useHtml:String;
		public var label_font:String;
		public var label_size:String;
		public var label_color:String;
		public var label_bold:String;
		public var label_italic:String;
		public var label_underline:String;
		
		public function TiPushButton()
		{
			super();
			type = JuiType.JPushButton;
		}
		
		override public function parse(name:String, xml:XML):void
		{
			super.parse(name, xml);
			defaultFill = AttriVal("defaultFill");
			overFill = AttriVal("overFill");
			downFill = AttriVal("downFill");
			disabledFill = AttriVal("disabledFill");
			faceFill = AttriVal("faceFill");
			
			label_useStroke = AttriVal("label_useStroke");
			label_strokeColor = AttriVal("label_strokeColor");
			label_strokeBlur = AttriVal("label_strokeBlur");
			label_strokeStrength = AttriVal("label_strokeStrength");
			label_useHtml = AttriVal("label_useHtml");
			label_font = AttriVal("label_font");
			label_size = AttriVal("label_size");
			label_color = AttriVal("label_color");
			label_bold = AttriVal("label_bold");
			label_italic = AttriVal("label_italic");
			label_underline = AttriVal("label_underline");
		}
		
		override public function apply(ui:JComponent):void
		{
			var pushButton:JPushButton = ui as JPushButton;
			if(!pushButton) { return; }
			var shell:CsPushButton = new CsPushButton();
			shell.assetsNS = this.assetsNS;
			shell.inject(pushButton);
			
			shell.defaultFill = defaultFill;
			shell.overFill = overFill;
			shell.downFill = downFill;
			shell.disabledFill = disabledFill;
			shell.faceFill = faceFill;
			shell.label_useStroke = label_useStroke;
			shell.label_strokeColor = label_strokeColor;
			shell.label_strokeBlur = label_strokeBlur;
			shell.label_strokeStrength = label_strokeStrength;
			shell.label_useHtml = label_useHtml;
			shell.label_font = label_font;
			shell.label_size = label_size;
			shell.label_color = label_color;
			shell.label_bold = label_bold;
			shell.label_italic = label_italic;
			shell.label_underline = label_underline;
		}
	}
}