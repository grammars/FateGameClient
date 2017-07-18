package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JText;
	import com.anstu.jui.define.JuiType;
	
	public class CsText extends CShell
	{
		private var textUI:JText = new JText();
		override public function getUI():JComponent { return textUI; }
		
		public function inject(ui:JComponent):void
		{
			this.textUI = ui as JText;
		}
		
		//defaultFill
		private var _defaultFill:String;
		public function set defaultFill(value:String):void
		{
			if(_defaultFill == value) { return; }
			_defaultFill = value;
			fill(textUI.fillDefaultBg, value);
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
			fill(textUI.fillOverBg, value);
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
			fill(textUI.fillUneditableBg, value);
		}
		public function get uneditableFill():String
		{
			return _uneditableFill;
		}
		
		//text
		public function set text(value:String):void
		{
			textUI.text = value;
		}
		public function get text():String { return textUI.text; }
		
		//autoWrap
		public function set autoWrap(value:String):void
		{
			textUI.autoWrap = BU.str2bool(value);
		}
		public function get autoWrap():String { return BU.bool2str(textUI.autoWrap); }
		
		//restrict
		public function set restrict(value:String):void
		{
			textUI.restrict = BU.richStr(value);
		}
		public function get restrict():String { return BU.unRichStr(textUI.restrict); }
		
		//password
		public function set password(value:String):void
		{
			textUI.password = BU.str2bool(value);
		}
		public function get password():String { return BU.bool2str(textUI.password); }
		
		//useStroke
		public function set useStroke(value:String):void
		{
			textUI.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(textUI.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			textUI.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return textUI.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			textUI.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return textUI.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			textUI.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return textUI.strokeStrength.toString(); }
		
		//font
		public function set font(value:String):void
		{
			textUI.textFormat.font = value;
		}
		public function get font():String { return textUI.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			textUI.textFormat.size = BU.S2PI(value);
		}
		public function get size():String { return BU.txtSize2Str(textUI.textFormat.size); }
		
		//color
		public function set color(value:String):void
		{
			textUI.textFormat.color = BU.hex2int(value);
		}
		public function get color():String { return BU.int2hex(textUI.textFormat.color); }
		
		//bold
		public function set bold(value:String):void
		{
			textUI.textFormat.bold = BU.str2bool(value);
		}
		public function get bold():String { return BU.bool2str(textUI.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			textUI.textFormat.italic = BU.str2bool(value);
		}
		public function get italic():String { return BU.bool2str(textUI.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			textUI.textFormat.underline = BU.str2bool(value);
		}
		public function get underline():String { return BU.bool2str(textUI.textFormat.underline); }
		
		
		public function CsText()
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
				"defaultFill", "overFill", "uneditableFill"];
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
			return "<"+JuiType.JText+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JText+">";
		}
		
	}
}