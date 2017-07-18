package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiType;
	
	public class CsLabel extends CShell
	{
		private var label:JLabel = new JLabel();
		override public function getUI():JComponent { return label; }
		
		public function inject(ui:JComponent):void
		{
			this.label = ui as JLabel;
		}
		
		//tpl_label
		private var _tpl_label:String;
		public function set tpl_label(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(label);	
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
			label.text = value;
		}
		public function get text():String { return label.text; }
		
		//align
		public function set align(value:String):void
		{
			label.align = value;
		}
		public function get align():String { return label.align; }
		
		//valign
		public function set valign(value:String):void
		{
			label.valign = value;
		}
		public function get valign():String { return label.valign; }
		
		//autoWrap
		public function set autoWrap(value:String):void
		{
			label.autoWrap = BU.str2bool(value);
		}
		public function get autoWrap():String { return BU.bool2str(label.autoWrap); }
		
		//useStroke
		public function set useStroke(value:String):void
		{
			label.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(label.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			label.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return label.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			label.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return label.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			label.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return label.strokeStrength.toString(); }
		
		//useHtml
		public function set useHtml(value:String):void
		{
			label.useHtml = BU.str2bool(value);
		}
		public function get useHtml():String { return BU.bool2str(label.useHtml); }
		
		//font
		public function set font(value:String):void
		{
			label.textFormat.font = value;
		}
		public function get font():String { return label.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			label.textFormat.size = BU.S2PI(value);
		}
		public function get size():String { return BU.txtSize2Str(label.textFormat.size); }
		
		//color
		public function set color(value:String):void
		{
			label.textFormat.color = BU.hex2int(value);
		}
		public function get color():String { return BU.int2hex(label.textFormat.color); }
		
		//bold
		public function set bold(value:String):void
		{
			label.textFormat.bold = BU.str2bool(value);
		}
		public function get bold():String { return BU.bool2str(label.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			label.textFormat.italic = BU.str2bool(value);
		}
		public function get italic():String { return BU.bool2str(label.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			label.textFormat.underline = BU.str2bool(value);
		}
		public function get underline():String { return BU.bool2str(label.textFormat.underline); }
		
		//usePack
		public function set usePack(value:String):void
		{
			label.usePack = BU.str2bool(value);
		}
		public function get usePack():String { return BU.bool2str(label.usePack); }
		
		public function CsLabel()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
			label.text = "这是一个标签\rThis is a JLabel!";
		}
		
		override public function getAttris():Array
		{
			return ["text", "align", "valign", "autoWrap",
			"useStroke", "strokeColor", "strokeBlur", "strokeStrength",
			"useHtml", "font", "size", "color", "bold", "italic", "underline",
			"usePack"];
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
			return "<"+JuiType.JLabel+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JLabel+">";
		}
		
	}
}