package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JTextArea;
	import com.anstu.jui.define.JuiType;
	
	public class CsTextArea extends CShell
	{
		private var testArea:JTextArea = new JTextArea();
		override public function getUI():JComponent { return testArea; }
		
		public function inject(ui:JComponent):void
		{
			this.testArea = ui as JTextArea;
		}
		
		//-------------text---------------
		//defaultFill
		private var _defaultFill:String;
		public function set defaultFill(value:String):void
		{
			if(_defaultFill == value) { return; }
			_defaultFill = value;
			fill(testArea.fillDefaultBg, value);
		}
		public function get defaultFill():String
		{
			return _defaultFill;
		}
		
		//overFill
		private var _overFill:String;
		public function set overFill(value:String):void
		{
			if(_overFill == value) { return; }
			_overFill = value;
			fill(testArea.fillOverBg, value);
		}
		public function get overFill():String
		{
			return _overFill;
		}
		
		//uneditableFill
		private var _uneditableFill:String;
		public function set uneditableFill(value:String):void
		{
			if(_uneditableFill == value) { return; }
			_uneditableFill = value;
			fill(testArea.fillUneditableBg, value);
		}
		public function get uneditableFill():String
		{
			return _uneditableFill;
		}
		
		//text
		public function set text(value:String):void
		{
			testArea.text = value;
		}
		public function get text():String { return testArea.text; }
		
		//autoWrap
		public function set autoWrap(value:String):void
		{
			testArea.autoWrap = BU.str2bool(value);
		}
		public function get autoWrap():String { return BU.bool2str(testArea.autoWrap); }
		
		//restrict
		public function set restrict(value:String):void
		{
			testArea.restrict = BU.richStr(value);
		}
		public function get restrict():String { return BU.unRichStr(testArea.restrict); }
		
		//password
		public function set password(value:String):void
		{
			testArea.password = BU.str2bool(value);
		}
		public function get password():String { return BU.bool2str(testArea.password); }
		
		//useStroke
		public function set useStroke(value:String):void
		{
			testArea.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(testArea.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			testArea.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return testArea.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			testArea.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return testArea.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			testArea.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return testArea.strokeStrength.toString(); }
		
		//font
		public function set font(value:String):void
		{
			testArea.textFormat.font = value;
		}
		public function get font():String { return testArea.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			testArea.textFormat.size = BU.S2PI(value);
		}
		public function get size():String { return BU.txtSize2Str(testArea.textFormat.size); }
		
		//color
		public function set color(value:String):void
		{
			testArea.textFormat.color = BU.hex2int(value);
		}
		public function get color():String { return BU.int2hex(testArea.textFormat.color); }
		
		//bold
		public function set bold(value:String):void
		{
			testArea.textFormat.bold = BU.str2bool(value);
		}
		public function get bold():String { return BU.bool2str(testArea.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			testArea.textFormat.italic = BU.str2bool(value);
		}
		public function get italic():String { return BU.bool2str(testArea.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			testArea.textFormat.underline = BU.str2bool(value);
		}
		public function get underline():String { return BU.bool2str(testArea.textFormat.underline); }
		
		//tpl_scrollBar
		private var _tpl_scrollBar:String;
		public function set tpl_scrollBar(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(testArea.scrollbar);	
				_tpl_scrollBar = value;
			}
			else
			{
				_tpl_scrollBar = null;
			}
		}
		public function get tpl_scrollBar():String { return _tpl_scrollBar; }
		
		public function CsTextArea()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override public function getAttris():Array
		{
			return ["text", "autoWrap", "restrict", "password",
				"useStroke", "strokeColor", "strokeBlur", "strokeStrength",
				"font", "size", "color", "bold", "italic", "underline",
				"defaultFill", "overFill", "uneditableFill"
			];
		}
		
		override public function getTpls():Array
		{
			return ["tpl_scrollBar"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " text='" + BU.XML(this.text) + "'";
			attriStr += " autoWrap='" + this.autoWrap + "'";
			attriStr += " restrict='" + this.restrict + "'";
			attriStr += " password='" + this.password + "'";
			attriStr += " useStroke='" + this.useStroke + "'";
			attriStr += " strokeColor='" + this.strokeColor + "'";
			attriStr += " strokeBlur='" + this.strokeBlur + "'";
			attriStr += " strokeStrength='" + this.strokeStrength + "'";
			attriStr += " font='" + this.font + "'";
			attriStr += " size='" + this.size + "'";
			attriStr += " color='" + this.color + "'";
			attriStr += " bold='" + this.bold + "'";
			attriStr += " italic='" + this.italic + "'";
			attriStr += " underline='" + this.underline + "'";
			attriStr += " defaultFill='" + this.defaultFill + "'";
			attriStr += " overFill='" + this.overFill + "'";
			attriStr += " uneditableFill='" + this.uneditableFill + "'";
			
			attriStr += " tpl_scrollBar='" + this.tpl_scrollBar + "'";
			
			return "<"+JuiType.JTextArea+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JTextArea+">";
		}
	}
}