package com.anstu.jui.build.template.info
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.template.TemplateInfo;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class TiLabel extends TemplateInfo
	{
		public var align:String;
		public var valign:String;
		public var autoWrap:String;
		public var useStroke:String;
		public var strokeColor:String;
		public var strokeBlur:String;
		public var strokeStrength:String;
		public var useHtml:String;
		public var font:String;
		public var size:String;
		public var color:String;
		public var bold:String;
		public var italic:String;
		public var underline:String;
		
		public function TiLabel()
		{
			super();
			type = JuiType.JLabel;
		}
		
		override public function parse(name:String, xml:XML):void
		{
			super.parse(name, xml);
			align = AttriVal("align");
			valign = AttriVal("valign");
			autoWrap = AttriVal("autoWrap");
			useStroke = AttriVal("useStroke");
			strokeColor = AttriVal("strokeColor");
			strokeBlur = AttriVal("strokeBlur");
			strokeStrength = AttriVal("strokeStrength");
			useHtml = AttriVal("useHtml");
			font = AttriVal("font");
			size = AttriVal("size");
			color = AttriVal("color");
			bold = AttriVal("bold");
			italic = AttriVal("italic");
			underline = AttriVal("underline");
		}
		
		override public function apply(ui:JComponent):void
		{
			var label:JLabel = ui as JLabel;
			if(!label) { return; }
			label.align = align;
			label.valign = valign;
			label.autoWrap = BU.str2bool(autoWrap);
			label.useStroke = BU.str2bool(useStroke);
			label.strokeColor = parseInt(strokeColor, 16);
			label.strokeBlur = BU.S2PI(strokeBlur);
			label.strokeStrength = BU.S2PI(strokeStrength);
			label.useHtml = BU.str2bool(useHtml);
			label.textFormat.font = font;
			label.textFormat.size = BU.S2PI(size);
			label.textFormat.color = BU.hex2int(color);
			label.textFormat.bold = BU.str2bool(bold);
			label.textFormat.italic = BU.str2bool(italic);
			label.textFormat.underline = BU.str2bool(underline);
		}
		
	}
}