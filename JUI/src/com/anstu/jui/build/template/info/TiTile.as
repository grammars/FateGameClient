package com.anstu.jui.build.template.info
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.template.TemplateInfo;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JTitle;
	import com.anstu.jui.define.JuiType;
	
	public class TiTile extends TemplateInfo
	{
		public var gradBeg:String;
		public var gradEnd:String;
		public var align:String;
		public var valign:String;
		public var autoWrap:String;
		public var useStroke:String;
		public var strokeColor:String;
		public var strokeBlur:String;
		public var strokeStrength:String;
		public var font:String;
		public var size:String;
		public var color:String;
		public var bold:String;
		public var italic:String;
		public var underline:String;
		
		public function TiTile()
		{
			super();
			type = JuiType.JTitle;
		}
		
		override public function parse(name:String, xml:XML):void
		{
			super.parse(name, xml);
			gradBeg = AttriVal("gradBeg");
			gradEnd = AttriVal("gradEnd");
			align = AttriVal("align");
			valign = AttriVal("valign");
			autoWrap = AttriVal("autoWrap");
			useStroke = AttriVal("useStroke");
			strokeColor = AttriVal("strokeColor");
			strokeBlur = AttriVal("strokeBlur");
			strokeStrength = AttriVal("strokeStrength");
			font = AttriVal("font");
			size = AttriVal("size");
			color = AttriVal("color");
			bold = AttriVal("bold");
			italic = AttriVal("italic");
			underline = AttriVal("underline");
		}
		
		override public function apply(ui:JComponent):void
		{
			var title:JTitle = ui as JTitle;
			if(!title) { return; }
			title.gradBeg = BU.hex2int(gradBeg);
			title.gradEnd = BU.hex2int(gradEnd);
			title.align = align;
			title.valign = valign;
			title.autoWrap = BU.str2bool(autoWrap);
			title.useStroke = BU.str2bool(useStroke);
			title.strokeColor = parseInt(strokeColor, 16);
			title.strokeBlur = BU.S2PI(strokeBlur);
			title.strokeStrength = BU.S2PI(strokeStrength);
			title.textFormat.font = font;
			title.textFormat.size = BU.S2PI(size);
			title.textFormat.color = BU.hex2int(color);
			title.textFormat.bold = BU.str2bool(bold);
			title.textFormat.italic = BU.str2bool(italic);
			title.textFormat.underline = BU.str2bool(underline);
		}
		
	}
}