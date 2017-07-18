package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.define.JuiType;
	
	public class CsInputText extends CShell
	{
		private var inputText:JInputText = new JInputText();
		override public function getUI():JComponent { return inputText; }
		
		public function inject(ui:JComponent):void
		{
			this.inputText = ui as JInputText;
		}
		
		//text
		public function set text(value:String):void
		{
			inputText.text = value;
		}
		public function get text():String { return inputText.text; }
		
		//align
		public function set align(value:String):void
		{
			inputText.align = value;
		}
		public function get align():String { return inputText.align; }
		
		//restrict
		public function set restrict(value:String):void
		{
			inputText.restrict = BU.richStr(value);
		}
		public function get restrict():String { return BU.unRichStr(inputText.restrict); }
		
		//maxChars
		public function set maxChars(value:String):void
		{
			inputText.maxChars = BU.S2PI(value);
		}
		public function get maxChars():String { return inputText.maxChars.toString(); }
		
		//password
		public function set password(value:String):void
		{
			inputText.password = BU.str2bool(value);
		}
		public function get password():String { return BU.bool2str(inputText.password); }
		
		//useStroke
		public function set useStroke(value:String):void
		{
			inputText.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(inputText.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			inputText.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return inputText.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			inputText.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return inputText.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			inputText.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return inputText.strokeStrength.toString(); }
		
		//font
		public function set font(value:String):void
		{
			inputText.textFormat.font = value;
		}
		public function get font():String { return inputText.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			inputText.textFormat.size = BU.S2PI(value);
		}
		public function get size():String { return BU.txtSize2Str(inputText.textFormat.size); }
		
		//color
		public function set color(value:String):void
		{
			inputText.textFormat.color = BU.hex2int(value);
		}
		public function get color():String { return BU.int2hex(inputText.textFormat.color); }
		
		//bold
		public function set bold(value:String):void
		{
			inputText.textFormat.bold = BU.str2bool(value);
		}
		public function get bold():String { return BU.bool2str(inputText.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			inputText.textFormat.italic = BU.str2bool(value);
		}
		public function get italic():String { return BU.bool2str(inputText.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			inputText.textFormat.underline = BU.str2bool(value);
		}
		public function get underline():String { return BU.bool2str(inputText.textFormat.underline); }
		
		public function CsInputText()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
			inputText.text = "这是一个输入框。This is a JInputText!";
		}
		
		override public function getAttris():Array
		{
			return ["text", "align", "restrict", "maxChars", "password",
				"useStroke", "strokeColor", "strokeBlur", "strokeStrength",
				"font", "size", "color", "bold", "italic", "underline"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " text='" + BU.XML(this.text) + "'";
			attriStr += " align='" + this.align + "'";
			attriStr += " restrict='" + this.restrict + "'";
			attriStr += " maxChars='" + this.maxChars + "'";
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
			return "<"+JuiType.JInputText+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JInputText+">";
		}
	}
}