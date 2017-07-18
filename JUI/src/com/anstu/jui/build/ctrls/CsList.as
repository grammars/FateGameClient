package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JList;
	import com.anstu.jui.define.JuiType;
	
	public class CsList extends CShell
	{
		private var list:JList = new JList();
		override public function getUI():JComponent { return list; }
		
		public function inject(ui:JComponent):void
		{
			this.list = ui as JList;
		}
		
		//defaultColor
		public function set defaultColor(value:String):void
		{
			list.defaultColor = parseInt(value, 16);
		}
		public function get defaultColor():String { return list.defaultColor.toString(16); }
		
		//selectedColor
		public function set selectedColor(value:String):void
		{
			list.selectedColor = parseInt(value, 16);
		}
		public function get selectedColor():String { return list.selectedColor.toString(16); }
		
		//rolloverColor
		public function set rolloverColor(value:String):void
		{
			list.rolloverColor = parseInt(value, 16);
		}
		public function get rolloverColor():String { return list.rolloverColor.toString(16); }
		
		//alternateColor
		public function set alternateColor(value:String):void
		{
			list.alternateColor = parseInt(value, 16);
		}
		public function get alternateColor():String { return list.alternateColor.toString(16); }
		
		//alternateRows
		public function set alternateRows(value:String):void
		{
			list.alternateRows = BU.str2bool(value);
		}
		public function get alternateRows():String { return BU.bool2str(list.alternateRows); }
		
		//autoHideScrollBar
		public function set autoHideScrollBar(value:String):void
		{
			list.autoHideScrollBar = BU.str2bool(value);
		}
		public function get autoHideScrollBar():String { return BU.bool2str(list.autoHideScrollBar); }
		
		//------------item.label-----------
		//useStroke
		public function set useStroke(value:String):void
		{
			list.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(list.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			list.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return list.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			list.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return list.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			list.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return list.strokeStrength.toString(); }
		
		//useHtml
		public function set useHtml(value:String):void
		{
			list.useHtml = BU.str2bool(value);
		}
		public function get useHtml():String { return BU.bool2str(list.useHtml); }
		
		//font
		public function set font(value:String):void
		{
			list.textFormat.font = value;
			list.repaint();
		}
		public function get font():String { return list.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			list.textFormat.size = BU.S2PI(value);
			list.repaint();
		}
		public function get size():String { return BU.txtSize2Str(list.textFormat.size); }
		
		//color
		public function set color(value:String):void
		{
			list.textFormat.color = BU.hex2int(value);
			list.repaint();
		}
		public function get color():String { return BU.int2hex(list.textFormat.color); }
		
		//bold
		public function set bold(value:String):void
		{
			list.textFormat.bold = BU.str2bool(value);
			list.repaint();
		}
		public function get bold():String { return BU.bool2str(list.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			list.textFormat.italic = BU.str2bool(value);
			list.repaint();
		}
		public function get italic():String { return BU.bool2str(list.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			list.textFormat.underline = BU.str2bool(value);
			list.repaint();
		}
		public function get underline():String { return BU.bool2str(list.textFormat.underline); }
		
		//tpl_scrollBar
		private var _tpl_scrollBar:String;
		public function set tpl_scrollBar(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(list.scrollBar);	
				_tpl_scrollBar = value;
			}
			else
			{
				_tpl_scrollBar = null;
			}
		}
		public function get tpl_scrollBar():String { return _tpl_scrollBar; }
		
		public function CsList()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
			
			list.items = ["Test0", "测试1", "テスト2", "테스트3", "IL Test4", 
				"Ensayo5", "اختبار6", "испытания7", "Der test8"];
		}
		
		override public function getAttris():Array
		{
			return ["defaultColor", "selectedColor", "rolloverColor", "alternateColor",
				"alternateRows", "autoHideScrollBar",
				"useStroke", "strokeColor", "strokeBlur", "strokeStrength",
				"useHtml", "font", "size", "color", "bold", "italic", "underline",
				"usePack"];
		}
		
		override public function getTpls():Array
		{
			return ["tpl_scrollBar"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " defaultColor='" + this.defaultColor + "'";
			attriStr += " selectedColor='" + this.selectedColor + "'";
			attriStr += " rolloverColor='" + this.rolloverColor + "'";
			attriStr += " alternateColor='" + this.alternateColor + "'";
			attriStr += " alternateRows='" + this.alternateRows + "'";
			attriStr += " autoHideScrollBar='" + this.autoHideScrollBar + "'";
			
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
			
			attriStr += " tpl_scrollBar='" + this.tpl_scrollBar + "'";
			
			return "<"+JuiType.JList+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JList+">";
		}
	}
}