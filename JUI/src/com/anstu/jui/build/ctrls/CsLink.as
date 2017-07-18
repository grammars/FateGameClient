package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JLink;
	import com.anstu.jui.define.JuiType;
	
	public class CsLink extends CShell
	{
		private var link:JLink = new JLink();
		override public function getUI():JComponent { return link; }
		
		public function inject(ui:JComponent):void
		{
			this.link = ui as JLink;
		}
		
		//tpl_label
		private var _tpl_label:String;
		public function set tpl_label(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(link);	
				_tpl_label = value;
			}
			else
			{
				_tpl_label = null;
			}
		}
		public function get tpl_label():String { return _tpl_label; }
		
		//text
		public function set text(value:String):void
		{
			link.text = value;
		}
		public function get text():String { return link.text; }
		
		//align
		public function set align(value:String):void
		{
			link.align = value;
		}
		public function get align():String { return link.align; }
		
		//valign
		public function set valign(value:String):void
		{
			link.valign = value;
		}
		public function get valign():String { return link.valign; }
		
		//autoWrap
		public function set autoWrap(value:String):void
		{
			link.autoWrap = BU.str2bool(value);
		}
		public function get autoWrap():String { return BU.bool2str(link.autoWrap); }
		
		//useStroke
		public function set useStroke(value:String):void
		{
			link.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(link.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			link.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return link.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			link.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return link.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			link.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return link.strokeStrength.toString(); }
		
		//useHtml
		public function set useHtml(value:String):void
		{
			link.useHtml = BU.str2bool(value);
		}
		public function get useHtml():String { return BU.bool2str(link.useHtml); }
		
		//font
		public function set font(value:String):void
		{
			link.textFormat.font = value;
		}
		public function get font():String { return link.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			link.textFormat.size = BU.S2PI(value);
		}
		public function get size():String { return BU.txtSize2Str(link.textFormat.size); }
		
		//color
		public function set color(value:String):void
		{
			link.textFormat.color = BU.hex2int(value);
		}
		public function get color():String { return BU.int2hex(link.textFormat.color); }
		
		//bold
		public function set bold(value:String):void
		{
			link.textFormat.bold = BU.str2bool(value);
		}
		public function get bold():String { return BU.bool2str(link.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			link.textFormat.italic = BU.str2bool(value);
		}
		public function get italic():String { return BU.bool2str(link.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			link.textFormat.underline = BU.str2bool(value);
		}
		public function get underline():String { return BU.bool2str(link.textFormat.underline); }
		
		//usePack
		public function set usePack(value:String):void
		{
			link.usePack = BU.str2bool(value);
		}
		public function get usePack():String { return BU.bool2str(link.usePack); }
		
		//htmlDefault
		public function set htmlDefault(value:String):void
		{
			link.htmlDefault = (value);
		}
		public function get htmlDefault():String { return (link.htmlDefault); }
		
		//htmlOver
		public function set htmlOver(value:String):void
		{
			link.htmlOver = (value);
		}
		public function get htmlOver():String { return (link.htmlOver); }
		
		//htmlPress
		public function set htmlPress(value:String):void
		{
			link.htmlPress = (value);
		}
		public function get htmlPress():String { return (link.htmlPress); }
		
		//colorDefault
		public function set colorDefault(value:String):void
		{
			link.colorDefault = BU.hex2int(value);
		}
		public function get colorDefault():String { return BU.int2hex(link.colorDefault); }
		
		//colorOver
		public function set colorOver(value:String):void
		{
			link.colorOver = BU.hex2int(value);
		}
		public function get colorOver():String { return BU.int2hex(link.colorOver); }
		
		//colorPress
		public function set colorPress(value:String):void
		{
			link.colorPress = BU.hex2int(value);
		}
		public function get colorPress():String { return BU.int2hex(link.colorPress); }
		
		public function CsLink()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
			link.text = "这是一个链接\rThis is a JLink!";
		}
		
		override public function getAttris():Array
		{
			return ["text", "align", "valign", "autoWrap",
				"useStroke", "strokeColor", "strokeBlur", "strokeStrength",
				"useHtml", "font", "size", "color", "bold", "italic", "underline",
				"usePack", "htmlDefault", "htmlOver", "htmlPress", 
				"colorDefault", "colorOver", "colorPress"];
		}
		
		override public function getTpls():Array
		{
			return ["tpl_label"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " text='" + BU.XML(this.text) + "'";
			if(BU.available(tpl_label))
			{
				attriStr += " tpl_label='" + this.tpl_label + "'";
			}
			else
			{
				attriStr += " align='" + this.align + "'";
				attriStr += " valign='" + this.valign + "'";
				attriStr += " autoWrap='" + this.autoWrap + "'";
				attriStr += " useStroke='" + this.useStroke + "'";
				attriStr += " strokeColor='" + this.strokeColor + "'";
				attriStr += " strokeBlur='" + this.strokeBlur + "'";
				attriStr += " strokeStrength='" + this.strokeStrength + "'";
				attriStr += " useHtml='" + this.useHtml + "'";
				attriStr += " font='" + this.font + "'";
				attriStr += " size='" + this.size + "'";
				attriStr += " color='" + this.color + "'";
				attriStr += " bold='" + this.bold + "'";
				attriStr += " italic='" + this.italic + "'";
				attriStr += " underline='" + this.underline + "'";
			}
			attriStr += " usePack='" + this.usePack + "'";
			attriStr += " htmlDefault='" + BU.XML(this.htmlDefault) + "'";
			attriStr += " htmlOver='" + BU.XML(this.htmlOver) + "'";
			attriStr += " htmlPress='" + BU.XML(this.htmlPress) + "'";
			attriStr += " colorDefault='" + this.colorDefault + "'";
			attriStr += " colorOver='" + this.colorOver + "'";
			attriStr += " colorPress='" + this.colorPress + "'";
			return "<"+JuiType.JLink+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JLink+">";
		}
	}
}