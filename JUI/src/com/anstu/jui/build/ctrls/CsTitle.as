package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JTitle;
	import com.anstu.jui.define.JuiType;
	
	public class CsTitle extends CShell
	{
		private var title:JTitle = new JTitle();
		override public function getUI():JComponent { return title; }
		
		public function inject(ui:JComponent):void
		{
			this.title = ui as JTitle;
		}
		
		//tpl_title
		private var _tpl_title:String;
		public function set tpl_title(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(title);	
				_tpl_title = value;
			}
			else
			{
				_tpl_title = null;
			}
		}
		public function get tpl_title():String { return _tpl_title; }
		
		//text
		public function set text(value:String):void
		{
			title.text = value;
		}
		public function get text():String { return title.text; }
		
		//align
		public function set align(value:String):void
		{
			title.align = value;
		}
		public function get align():String { return title.align; }
		
		//valign
		public function set valign(value:String):void
		{
			title.valign = value;
		}
		public function get valign():String { return title.valign; }
		
		//autoWrap
		public function set autoWrap(value:String):void
		{
			title.autoWrap = BU.str2bool(value);
		}
		public function get autoWrap():String { return BU.bool2str(title.autoWrap); }
		
		//useStroke
		public function set useStroke(value:String):void
		{
			title.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(title.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			title.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return title.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			title.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return title.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			title.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return title.strokeStrength.toString(); }
		
		//font
		public function set font(value:String):void
		{
			title.textFormat.font = value;
			title.repaint();
		}
		public function get font():String { return title.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			title.textFormat.size = BU.S2PI(value);
			title.repaint();
		}
		public function get size():String { return BU.txtSize2Str(title.textFormat.size); }
		
		//bold
		public function set bold(value:String):void
		{
			title.textFormat.bold = BU.str2bool(value);
		}
		public function get bold():String { return BU.bool2str(title.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			title.textFormat.italic = BU.str2bool(value);
			title.repaint();
		}
		public function get italic():String { return BU.bool2str(title.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			title.textFormat.underline = BU.str2bool(value);
			title.repaint();
		}
		public function get underline():String { return BU.bool2str(title.textFormat.underline); }
		
		
		//gradBeg
		public function set gradBeg(value:String):void
		{
			title.gradBeg = BU.hex2int(value);
		}
		public function get gradBeg():String { return BU.int2hex(title.gradBeg); }
		
		//gradEnd
		public function set gradEnd(value:String):void
		{
			title.gradEnd = BU.hex2int(value);
		}
		public function get gradEnd():String { return BU.int2hex(title.gradEnd); }
		
		public function CsTitle()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
			title.text = "这是一个标题\rThis is a JTitle!";
		}
		
		override public function getAttris():Array
		{
			return ["text", "align", "valign", "autoWrap",
				"useStroke", "strokeColor", "strokeBlur", "strokeStrength",
				"font", "size", "bold", "italic", "underline",
				"gradBeg", "gradEnd"];
		}
		
		override public function getTpls():Array
		{
			return ["tpl_title"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " text='" + BU.XML(this.text) + "'";
			if(BU.available(tpl_title))
			{
				attriStr += " tpl_title='" + this.tpl_title + "'";
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
				attriStr += " font='" + this.font + "'";
				attriStr += " size='" + this.size + "'";
				attriStr += " bold='" + this.bold + "'";
				attriStr += " italic='" + this.italic + "'";
				attriStr += " underline='" + this.underline + "'";
				
				attriStr += " gradBeg='" + this.gradBeg + "'";
				attriStr += " gradEnd='" + this.gradEnd + "'";
			}
			return "<"+JuiType.JTitle+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JTitle+">";
		}
		
	}
}