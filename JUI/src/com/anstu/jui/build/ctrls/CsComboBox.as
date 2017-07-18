package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.define.JuiType;
	
	public class CsComboBox extends CShell
	{
		private var comboBox:JComboBox = new JComboBox();
		override public function getUI():JComponent { return comboBox; }
		
		public function inject(ui:JComponent):void
		{
			this.comboBox = ui as JComboBox;
		}
		
		//openPos
		public function set openPos(value:String):void
		{
			comboBox.openPosition = value;
		}
		public function get openPos():String { return comboBox.openPosition; }
		
		//------------labelButton---------------
		//label_defaultFill
		private var _label_defaultFill:String;
		public function set label_defaultFill(value:String):void
		{
			if(_label_defaultFill == value) { return; }
			_label_defaultFill = value;
			fill(comboBox.labelButton.fillDefaultBg, value);
		}
		public function get label_defaultFill():String { return _label_defaultFill; }
		
		//label_overFill
		private var _label_overFill:String;
		public function set label_overFill(value:String):void
		{
			if(_label_overFill == value) { return; }
			_label_overFill = value;
			fill(comboBox.labelButton.fillOverBg, value);
		}
		public function get label_overFill():String { return _label_overFill; }
		
		//label_downFill
		private var _label_downFill:String;
		public function set label_downFill(value:String):void
		{
			if(_label_downFill == value) { return; }
			_label_downFill = value;
			fill(comboBox.labelButton.fillDownBg, value);
		}
		public function get label_downFill():String { return _label_downFill; }
		
		//label_disabledFill
		private var _label_disabledFill:String;
		public function set label_disabledFill(value:String):void
		{
			if(_label_disabledFill == value) { return; }
			_label_disabledFill = value;
			fill(comboBox.labelButton.fillDisabledBg, value);
		}
		public function get label_disabledFill():String { return _label_disabledFill; }
		
		//label_faceFill
		private var _label_faceFill:String;
		public function set label_faceFill(value:String):void
		{
			if(_label_faceFill == value) { return; }
			_label_faceFill = value;
			fill(comboBox.labelButton.fillFace, value);
		}
		public function get label_faceFill():String { return _label_faceFill; }
		
		//------------dropDownButton---------------
		//drop_width
		private var _drop_width:String;
		public function set drop_width(value:String):void
		{
			_drop_width = value;
			comboBox.dropDownButton.width = BU.S2PI(value);
		}
		public function get drop_width():String { return comboBox.dropDownButton.width.toString(); }
		
		//drop_height
		private var _drop_height:String;
		public function set drop_height(value:String):void
		{
			_drop_height = value;
			comboBox.dropDownButton.height = BU.S2PI(value);
		}
		public function get drop_height():String { return comboBox.dropDownButton.height.toString(); }
		
		//drop_defaultFill
		private var _drop_defaultFill:String;
		public function set drop_defaultFill(value:String):void
		{
			if(_drop_defaultFill == value) { return; }
			_drop_defaultFill = value;
			fill(comboBox.dropDownButton.fillDefaultBg, value);
		}
		public function get drop_defaultFill():String { return _drop_defaultFill; }
		
		//drop_overFill
		private var _drop_overFill:String;
		public function set drop_overFill(value:String):void
		{
			if(_drop_overFill == value) { return; }
			_drop_overFill = value;
			fill(comboBox.dropDownButton.fillOverBg, value);
		}
		public function get drop_overFill():String { return _drop_overFill; }
		
		//drop_downFill
		private var _drop_downFill:String;
		public function set drop_downFill(value:String):void
		{
			if(_drop_downFill == value) { return; }
			_drop_downFill = value;
			fill(comboBox.dropDownButton.fillDownBg, value);
		}
		public function get drop_downFill():String { return _drop_downFill; }
		
		//drop_disabledFill
		private var _drop_disabledFill:String;
		public function set drop_disabledFill(value:String):void
		{
			if(_drop_disabledFill == value) { return; }
			_drop_disabledFill = value;
			fill(comboBox.dropDownButton.fillDisabledBg, value);
		}
		public function get drop_disabledFill():String { return _drop_disabledFill; }
		
		//drop_faceFill
		private var _drop_faceFill:String;
		public function set drop_faceFill(value:String):void
		{
			if(_drop_faceFill == value) { return; }
			_drop_faceFill = value;
			fill(comboBox.dropDownButton.fillFace, value);
		}
		public function get drop_faceFill():String { return _drop_faceFill; }
		
		//------list------------------
		//defaultColor
		public function set defaultColor(value:String):void
		{
			comboBox.list.defaultColor = parseInt(value, 16);
		}
		public function get defaultColor():String { return comboBox.list.defaultColor.toString(16); }
		
		//selectedColor
		public function set selectedColor(value:String):void
		{
			comboBox.list.selectedColor = parseInt(value, 16);
		}
		public function get selectedColor():String { return comboBox.list.selectedColor.toString(16); }
		
		//rolloverColor
		public function set rolloverColor(value:String):void
		{
			comboBox.list.rolloverColor = parseInt(value, 16);
		}
		public function get rolloverColor():String { return comboBox.list.rolloverColor.toString(16); }
		
		//alternateColor
		public function set alternateColor(value:String):void
		{
			comboBox.list.alternateColor = parseInt(value, 16);
		}
		public function get alternateColor():String { return comboBox.list.alternateColor.toString(16); }
		
		//alternateRows
		public function set alternateRows(value:String):void
		{
			comboBox.list.alternateRows = BU.str2bool(value);
		}
		public function get alternateRows():String { return BU.bool2str(comboBox.list.alternateRows); }
		
		//autoHideScrollBar
		public function set autoHideScrollBar(value:String):void
		{
			comboBox.list.autoHideScrollBar = BU.str2bool(value);
		}
		public function get autoHideScrollBar():String { return BU.bool2str(comboBox.list.autoHideScrollBar); }
		
		//------------(item/label).label-----------
		//useStroke
		public function set useStroke(value:String):void
		{
			comboBox.list.useStroke = BU.str2bool(value);
			comboBox.labelButton.label.useStroke = BU.str2bool(value);
		}
		public function get useStroke():String { return BU.bool2str(comboBox.list.useStroke); }
		
		//strokeColor
		public function set strokeColor(value:String):void
		{
			comboBox.list.strokeColor = parseInt(value, 16);
			comboBox.labelButton.label.strokeColor = parseInt(value, 16);
		}
		public function get strokeColor():String { return comboBox.list.strokeColor.toString(16); }
		
		//strokeBlur
		public function set strokeBlur(value:String):void
		{
			comboBox.list.strokeBlur = BU.S2PI(value);
			comboBox.labelButton.label.strokeBlur = BU.S2PI(value);
		}
		public function get strokeBlur():String { return comboBox.list.strokeBlur.toString(); }
		
		//strokeStrength
		public function set strokeStrength(value:String):void
		{
			comboBox.list.strokeStrength = BU.S2PI(value);
			comboBox.labelButton.label.strokeStrength = BU.S2PI(value);
		}
		public function get strokeStrength():String { return comboBox.list.strokeStrength.toString(); }
		
		//useHtml
		public function set useHtml(value:String):void
		{
			comboBox.list.useHtml = BU.str2bool(value);
			comboBox.labelButton.label.useHtml = BU.str2bool(value);
		}
		public function get useHtml():String { return BU.bool2str(comboBox.list.useHtml); }
		
		//font
		public function set font(value:String):void
		{
			comboBox.list.textFormat.font = value;
			comboBox.list.repaint();
			comboBox.labelButton.label.textFormat.font = value;
		}
		public function get font():String { return comboBox.list.textFormat.font; }
		
		//font
		public function set size(value:String):void
		{
			comboBox.list.textFormat.size = BU.S2PI(value);
			comboBox.list.repaint();
			comboBox.labelButton.label.textFormat.size = BU.S2PI(value);
		}
		public function get size():String { return BU.txtSize2Str(comboBox.list.textFormat.size); }
		
		//color
		public function set color(value:String):void
		{
			comboBox.list.textFormat.color = BU.hex2int(value);
			comboBox.list.repaint();
			comboBox.labelButton.label.textFormat.color = BU.hex2int(value);
		}
		public function get color():String { return BU.int2hex(comboBox.list.textFormat.color); }
		
		//bold
		public function set bold(value:String):void
		{
			comboBox.list.textFormat.bold = BU.str2bool(value);
			comboBox.list.repaint();
			comboBox.labelButton.label.textFormat.bold = BU.str2bool(value);
		}
		public function get bold():String { return BU.bool2str(comboBox.list.textFormat.bold); }
		
		//italic
		public function set italic(value:String):void
		{
			comboBox.list.textFormat.italic = BU.str2bool(value);
			comboBox.list.repaint();
			comboBox.labelButton.label.textFormat.italic = BU.str2bool(value);
		}
		public function get italic():String { return BU.bool2str(comboBox.list.textFormat.italic); }
		
		//underline
		public function set underline(value:String):void
		{
			comboBox.list.textFormat.underline = BU.str2bool(value);
			comboBox.list.repaint();
			comboBox.labelButton.label.textFormat.underline = BU.str2bool(value);
		}
		public function get underline():String { return BU.bool2str(comboBox.list.textFormat.underline); }
		
		//tpl_scrollBar
		private var _tpl_scrollBar:String;
		public function set tpl_scrollBar(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(comboBox.list.scrollBar);	
				_tpl_scrollBar = value;
			}
			else
			{
				_tpl_scrollBar = null;
			}
		}
		public function get tpl_scrollBar():String { return _tpl_scrollBar; }
		
		public function CsComboBox()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
			
			comboBox.items = ["Test0", "测试1", "テスト2", "테스트3", "IL Test4", 
				"Ensayo5", "اختبار6", "испытания7", "Der test8"];
		}
		
		override public function getAttris():Array
		{
			return ["openPos",
				"label_defaultFill", "label_overFill", "label_downFill", "label_disabledFill", "label_faceFill",
				"drop_width", "drop_height",
				"drop_defaultFill", "drop_overFill", "drop_downFill", "drop_disabledFill", "drop_faceFill",
				"defaultColor", "selectedColor", "rolloverColor", "alternateColor",
				"alternateRows", "autoHideScrollBar",
				"useStroke", "strokeColor", "strokeBlur", "strokeStrength",
				"useHtml", "font", "size", "color", "bold", "italic", "underline",
				"usePack"
			];
		}
		
		override public function getTpls():Array
		{
			return ["tpl_scrollBar"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " openPos='" + this.openPos + "'";
			
			attriStr += " label_defaultFill='" + this.label_defaultFill + "'";
			attriStr += " label_overFill='" + this.label_overFill + "'";
			attriStr += " label_downFill='" + this.label_downFill + "'";
			attriStr += " label_disabledFill='" + this.label_disabledFill + "'";
			attriStr += " label_faceFill='" + this.label_faceFill + "'";
			
			attriStr += " drop_width='" + this.drop_width + "'";
			attriStr += " drop_height='" + this.drop_height + "'";
			attriStr += " drop_defaultFill='" + this.drop_overFill + "'";
			attriStr += " drop_overFill='" + this.drop_overFill + "'";
			attriStr += " drop_downFill='" + this.drop_downFill + "'";
			attriStr += " drop_disabledFill='" + this.drop_disabledFill + "'";
			attriStr += " drop_faceFill='" + this.drop_faceFill + "'";
			
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
			
			return "<"+JuiType.JComboBox+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JComboBox+">";
		}
	}
}