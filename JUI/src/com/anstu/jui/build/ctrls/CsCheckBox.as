package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.define.JuiType;
	
	public class CsCheckBox extends CShell
	{
		private var checkBox:JCheckBox = new JCheckBox();
		override public function getUI():JComponent { return checkBox; }
		
		public function inject(ui:JComponent):void
		{
			this.checkBox = ui as JCheckBox;
		}
		
		//isSelected
		private var _isSelected:String;
		public function set isSelected(value:String):void
		{
			checkBox.selected = BU.str2bool(value);
		}
		public function get isSelected():String
		{
			return BU.bool2str(checkBox.selected);
		}
		
		//-------------unselected-----------
		//_unsel_defaultFill
		private var _unsel_defaultFill:String;
		public function set unsel_defaultFill(value:String):void
		{
			if(_unsel_defaultFill == value) { return; }
			_unsel_defaultFill = value;
			fill(checkBox.unselectedBtn.fillDefaultBg, value);
		}
		public function get unsel_defaultFill():String
		{
			return _unsel_defaultFill;
		}
		
		//unsel_overFill
		private var _unsel_overFill:String;
		public function set unsel_overFill(value:String):void
		{
			if(_unsel_overFill == value) { return; }
			_unsel_overFill = value;
			fill(checkBox.unselectedBtn.fillOverBg, value);
		}
		public function get unsel_overFill():String
		{
			return _unsel_overFill;
		}
		
		//unsel_downFill
		private var _unsel_downFill:String;
		public function set unsel_downFill(value:String):void
		{
			if(_unsel_downFill == value) { return; }
			_unsel_downFill = value;
			fill(checkBox.unselectedBtn.fillDownBg, value);
		}
		public function get unsel_downFill():String
		{
			return _unsel_downFill;
		}
		
		//unsel_disabledFill
		private var _unsel_disabledFill:String;
		public function set unsel_disabledFill(value:String):void
		{
			if(_unsel_disabledFill == value) { return; }
			_unsel_disabledFill = value;
			fill(checkBox.unselectedBtn.fillDisabledBg, value);
		}
		public function get unsel_disabledFill():String
		{
			return _unsel_disabledFill;
		}
		
		//unsel_faceFill
		private var _unsel_faceFill:String;
		public function set unsel_faceFill(value:String):void
		{
			if(_unsel_faceFill == value) { return; }
			_unsel_faceFill = value;
			fill(checkBox.unselectedBtn.fillFace, value);
		}
		public function get unsel_faceFill():String
		{
			return _unsel_faceFill;
		}
		
		//unsel_label_text
		public function set unsel_label_text(value:String):void
		{
			checkBox.unselectedBtn.label.text = value;
		}
		public function get unsel_label_text():String { return checkBox.unselectedBtn.label.text; }
		
		//unsel_label_useStroke
		public function set unsel_label_useStroke(value:String):void
		{
			checkBox.unselectedBtn.label.useStroke = BU.str2bool(value);
		}
		public function get unsel_label_useStroke():String { return BU.bool2str(checkBox.unselectedBtn.label.useStroke); }
		
		//unsel_label_strokeColor
		public function set unsel_label_strokeColor(value:String):void
		{
			checkBox.unselectedBtn.label.strokeColor = BU.hex2int(value);
		}
		public function get unsel_label_strokeColor():String { return BU.int2hex(checkBox.unselectedBtn.label.strokeColor); }
		
		//unsel_label_strokeBlur
		public function set unsel_label_strokeBlur(value:String):void
		{
			checkBox.unselectedBtn.label.strokeBlur = BU.S2PI(value);
		}
		public function get unsel_label_strokeBlur():String { return checkBox.unselectedBtn.label.strokeBlur.toString(); }
		
		//unsel_label_strokeStrength
		public function set unsel_label_strokeStrength(value:String):void
		{
			checkBox.unselectedBtn.label.strokeStrength = BU.S2PI(value);
		}
		public function get unsel_label_strokeStrength():String { return checkBox.unselectedBtn.label.strokeStrength.toString(); }
		
		//unsel_label_useHtml
		public function set unsel_label_useHtml(value:String):void
		{
			checkBox.unselectedBtn.label.useHtml = BU.str2bool(value);
		}
		public function get unsel_label_useHtml():String { return BU.bool2str(checkBox.unselectedBtn.label.useHtml); }
		
		//unsel_label_font
		public function set unsel_label_font(value:String):void
		{
			checkBox.unselectedBtn.label.textFormat.font = value;
		}
		public function get unsel_label_font():String { return checkBox.unselectedBtn.label.textFormat.font; }
		
		//unsel_label_size
		public function set unsel_label_size(value:String):void
		{
			checkBox.unselectedBtn.label.textFormat.size = BU.S2PI(value);
		}
		public function get unsel_label_size():String { return BU.txtSize2Str(checkBox.unselectedBtn.label.textFormat.size); }
		
		//unsel_label_color
		public function set unsel_label_color(value:String):void
		{
			checkBox.unselectedBtn.label.textFormat.color = BU.hex2int(value);
		}
		public function get unsel_label_color():String { return BU.int2hex(checkBox.unselectedBtn.label.textFormat.color); }
		
		//unsel_label_bold
		public function set unsel_label_bold(value:String):void
		{
			checkBox.unselectedBtn.label.textFormat.bold = BU.str2bool(value);
		}
		public function get unsel_label_bold():String { return BU.bool2str(checkBox.unselectedBtn.label.textFormat.bold); }
		
		//unsel_label_italic
		public function set unsel_label_italic(value:String):void
		{
			checkBox.unselectedBtn.label.textFormat.italic = BU.str2bool(value);
		}
		public function get unsel_label_italic():String { return BU.bool2str(checkBox.unselectedBtn.label.textFormat.italic); }
		
		//unsel_label_underline
		public function set unsel_label_underline(value:String):void
		{
			checkBox.unselectedBtn.label.textFormat.underline = BU.str2bool(value);
		}
		public function get unsel_label_underline():String { return BU.bool2str(checkBox.unselectedBtn.label.textFormat.underline); }
		
		//-------------selected-----------
		//_sel_defaultFill
		private var _sel_defaultFill:String;
		public function set sel_defaultFill(value:String):void
		{
			if(_sel_defaultFill == value) { return; }
			_sel_defaultFill = value;
			fill(checkBox.selectedBtn.fillDefaultBg, value);
		}
		public function get sel_defaultFill():String
		{
			return _sel_defaultFill;
		}
		
		//sel_overFill
		private var _sel_overFill:String;
		public function set sel_overFill(value:String):void
		{
			if(_sel_overFill == value) { return; }
			_sel_overFill = value;
			fill(checkBox.selectedBtn.fillOverBg, value);
		}
		public function get sel_overFill():String
		{
			return _sel_overFill;
		}
		
		//sel_downFill
		private var _sel_downFill:String;
		public function set sel_downFill(value:String):void
		{
			if(_sel_downFill == value) { return; }
			_sel_downFill = value;
			fill(checkBox.selectedBtn.fillDownBg, value);
		}
		public function get sel_downFill():String
		{
			return _sel_downFill;
		}
		
		//sel_disabledFill
		private var _sel_disabledFill:String;
		public function set sel_disabledFill(value:String):void
		{
			if(_sel_disabledFill == value) { return; }
			_sel_disabledFill = value;
			fill(checkBox.selectedBtn.fillDisabledBg, value);
		}
		public function get sel_disabledFill():String
		{
			return _sel_disabledFill;
		}
		
		//sel_faceFill
		private var _sel_faceFill:String;
		public function set sel_faceFill(value:String):void
		{
			if(_sel_faceFill == value) { return; }
			_sel_faceFill = value;
			fill(checkBox.selectedBtn.fillFace, value);
		}
		public function get sel_faceFill():String
		{
			return _sel_faceFill;
		}
		
		//sel_label_text
		public function set sel_label_text(value:String):void
		{
			checkBox.selectedBtn.label.text = value;
		}
		public function get sel_label_text():String { return checkBox.selectedBtn.label.text; }
		
		//sel_label_useStroke
		public function set sel_label_useStroke(value:String):void
		{
			checkBox.selectedBtn.label.useStroke = BU.str2bool(value);
		}
		public function get sel_label_useStroke():String { return BU.bool2str(checkBox.selectedBtn.label.useStroke); }
		
		//sel_label_strokeColor
		public function set sel_label_strokeColor(value:String):void
		{
			checkBox.selectedBtn.label.strokeColor = BU.hex2int(value);
		}
		public function get sel_label_strokeColor():String { return BU.int2hex(checkBox.selectedBtn.label.strokeColor); }
		
		//sel_label_strokeBlur
		public function set sel_label_strokeBlur(value:String):void
		{
			checkBox.selectedBtn.label.strokeBlur = BU.S2PI(value);
		}
		public function get sel_label_strokeBlur():String { return checkBox.selectedBtn.label.strokeBlur.toString(); }
		
		//sel_label_strokeStrength
		public function set sel_label_strokeStrength(value:String):void
		{
			checkBox.selectedBtn.label.strokeStrength = BU.S2PI(value);
		}
		public function get sel_label_strokeStrength():String { return checkBox.selectedBtn.label.strokeStrength.toString(); }
		
		//sel_label_useHtml
		public function set sel_label_useHtml(value:String):void
		{
			checkBox.selectedBtn.label.useHtml = BU.str2bool(value);
		}
		public function get sel_label_useHtml():String { return BU.bool2str(checkBox.selectedBtn.label.useHtml); }
		
		//sel_label_font
		public function set sel_label_font(value:String):void
		{
			checkBox.selectedBtn.label.textFormat.font = value;
		}
		public function get sel_label_font():String { return checkBox.selectedBtn.label.textFormat.font; }
		
		//sel_label_size
		public function set sel_label_size(value:String):void
		{
			checkBox.selectedBtn.label.textFormat.size = BU.S2PI(value);
		}
		public function get sel_label_size():String { return BU.txtSize2Str(checkBox.selectedBtn.label.textFormat.size); }
		
		//sel_label_color
		public function set sel_label_color(value:String):void
		{
			checkBox.selectedBtn.label.textFormat.color = BU.hex2int(value);
		}
		public function get sel_label_color():String { return BU.int2hex(checkBox.selectedBtn.label.textFormat.color); }
		
		//sel_label_bold
		public function set sel_label_bold(value:String):void
		{
			checkBox.selectedBtn.label.textFormat.bold = BU.str2bool(value);
		}
		public function get sel_label_bold():String { return BU.bool2str(checkBox.selectedBtn.label.textFormat.bold); }
		
		//sel_label_italic
		public function set sel_label_italic(value:String):void
		{
			checkBox.selectedBtn.label.textFormat.italic = BU.str2bool(value);
		}
		public function get sel_label_italic():String { return BU.bool2str(checkBox.selectedBtn.label.textFormat.italic); }
		
		//sel_label_underline
		public function set sel_label_underline(value:String):void
		{
			checkBox.selectedBtn.label.textFormat.underline = BU.str2bool(value);
		}
		public function get sel_label_underline():String { return BU.bool2str(checkBox.selectedBtn.label.textFormat.underline); }
		
		
		public function CsCheckBox()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override public function getAttris():Array
		{
			return [ "isSelected",
				"unsel_defaultFill", "unsel_overFill", "unsel_downFill", "unsel_disabledFill", "unsel_faceFill",
				"unsel_label_text", "unsel_label_useStroke", "unsel_label_strokeColor", "unsel_label_strokeBlur",
				"unsel_label_strokeStrength", "unsel_label_useHtml", "unsel_label_font", "unsel_label_size",
				"unsel_label_color", "unsel_label_bold", "unsel_label_italic", "unsel_label_underline",
			
				"sel_defaultFill", "sel_overFill", "sel_downFill", "sel_disabledFill", "sel_faceFill",
				"sel_label_text", "sel_label_useStroke", "sel_label_strokeColor", "sel_label_strokeBlur",
				"sel_label_strokeStrength", "sel_label_useHtml", "sel_label_font", "sel_label_size",
				"sel_label_color", "sel_label_bold", "sel_label_italic", "sel_label_underline"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " isSelected='" + this.isSelected + "'";
			attriStr += " unsel_defaultFill='" + this.unsel_defaultFill + "'";
			attriStr += " unsel_overFill='" + this.unsel_overFill + "'";
			attriStr += " unsel_downFill='" + this.unsel_downFill + "'";
			attriStr += " unsel_disabledFill='" + this.unsel_disabledFill + "'";
			attriStr += " unsel_faceFill='" + this.unsel_faceFill + "'";
			attriStr += " unsel_label_text='" + BU.XML(this.unsel_label_text) + "'";
			attriStr += " unsel_label_useStroke='" + this.unsel_label_useStroke + "'";
			attriStr += " unsel_label_strokeColor='" + this.unsel_label_strokeColor + "'";
			attriStr += " unsel_label_strokeBlur='" + this.unsel_label_strokeBlur + "'";
			attriStr += " unsel_label_strokeStrength='" + this.unsel_label_strokeStrength + "'";
			attriStr += " unsel_label_useHtml='" + this.unsel_label_useHtml + "'";
			attriStr += " unsel_label_font='" + this.unsel_label_font + "'";
			attriStr += " unsel_label_size='" + this.unsel_label_size + "'";
			attriStr += " unsel_label_color='" + this.unsel_label_color + "'";
			attriStr += " unsel_label_bold='" + this.unsel_label_bold + "'";
			attriStr += " unsel_label_italic='" + this.unsel_label_italic + "'";
			attriStr += " unsel_label_underline='" + this.unsel_label_underline + "'";
			
			attriStr += " sel_defaultFill='" + this.sel_defaultFill + "'";
			attriStr += " sel_overFill='" + this.sel_overFill + "'";
			attriStr += " sel_downFill='" + this.sel_downFill + "'";
			attriStr += " sel_disabledFill='" + this.sel_disabledFill + "'";
			attriStr += " sel_faceFill='" + this.sel_faceFill + "'";
			attriStr += " sel_label_text='" + BU.XML(this.sel_label_text) + "'";
			attriStr += " sel_label_useStroke='" + this.sel_label_useStroke + "'";
			attriStr += " sel_label_strokeColor='" + this.sel_label_strokeColor + "'";
			attriStr += " sel_label_strokeBlur='" + this.sel_label_strokeBlur + "'";
			attriStr += " sel_label_strokeStrength='" + this.sel_label_strokeStrength + "'";
			attriStr += " sel_label_useHtml='" + this.sel_label_useHtml + "'";
			attriStr += " sel_label_font='" + this.sel_label_font + "'";
			attriStr += " sel_label_size='" + this.sel_label_size + "'";
			attriStr += " sel_label_color='" + this.sel_label_color + "'";
			attriStr += " sel_label_bold='" + this.sel_label_bold + "'";
			attriStr += " sel_label_italic='" + this.sel_label_italic + "'";
			attriStr += " sel_label_underline='" + this.sel_label_underline + "'";
			return "<"+JuiType.JCheckBox+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JCheckBox+">";
		}
	}
}