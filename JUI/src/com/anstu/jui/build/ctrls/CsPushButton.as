package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.define.JuiType;
	
	public class CsPushButton extends CShell
	{
		private var pushButton:JPushButton = new JPushButton();
		override public function getUI():JComponent { return pushButton; }
		
		public function inject(ui:JComponent):void
		{
			this.pushButton = ui as JPushButton;
		}
		
		//tpl_button
		private var _tpl_button:String;
		public function set tpl_button(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(pushButton);	
				_tpl_button = value;
			}
			else
			{
				_tpl_button = null;
			}
		}
		public function get tpl_button():String { return _tpl_button; }
		
		//_defaultFill
		private var _defaultFill:String;
		public function set defaultFill(value:String):void
		{
			if(_defaultFill == value) { return; }
			_defaultFill = value;
			fill(pushButton.fillDefaultBg, value);
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
			fill(pushButton.fillOverBg, value);
		}
		public function get overFill():String
		{
			return _overFill;
		}
		
		//downFill
		private var _downFill:String;
		public function set downFill(value:String):void
		{
			if(_downFill == value) { return; }
			_downFill = value;
			fill(pushButton.fillDownBg, value);
		}
		public function get downFill():String
		{
			return _downFill;
		}
		
		//disabledFill
		private var _disabledFill:String;
		public function set disabledFill(value:String):void
		{
			if(_disabledFill == value) { return; }
			_disabledFill = value;
			fill(pushButton.fillDisabledBg, value);
		}
		public function get disabledFill():String
		{
			return _disabledFill;
		}
		
		//faceFill
		private var _faceFill:String;
		public function set faceFill(value:String):void
		{
			if(_faceFill == value) { return; }
			_faceFill = value;
			fill(pushButton.fillFace, value);
		}
		public function get faceFill():String
		{
			return _faceFill;
		}
		
		//label_text
		public function set label_text(value:String):void
		{
			pushButton.label.text = value;
		}
		public function get label_text():String { return pushButton.label.text; }
		
		//label_useStroke
		public function set label_useStroke(value:String):void
		{
			pushButton.label.useStroke = BU.str2bool(value);
		}
		public function get label_useStroke():String { return BU.bool2str(pushButton.label.useStroke); }
		
		//label_strokeColor
		public function set label_strokeColor(value:String):void
		{
			pushButton.label.strokeColor = BU.hex2int(value);
		}
		public function get label_strokeColor():String { return BU.int2hex(pushButton.label.strokeColor); }
		
		//label_strokeBlur
		public function set label_strokeBlur(value:String):void
		{
			pushButton.label.strokeBlur = BU.S2PI(value);
		}
		public function get label_strokeBlur():String { return pushButton.label.strokeBlur.toString(); }
		
		//label_strokeStrength
		public function set label_strokeStrength(value:String):void
		{
			pushButton.label.strokeStrength = BU.S2PI(value);
		}
		public function get label_strokeStrength():String { return pushButton.label.strokeStrength.toString(); }
		
		//label_useHtml
		public function set label_useHtml(value:String):void
		{
			pushButton.label.useHtml = BU.str2bool(value);
		}
		public function get label_useHtml():String { return BU.bool2str(pushButton.label.useHtml); }
		
		//label_font
		public function set label_font(value:String):void
		{
			pushButton.label.textFormat.font = value;
		}
		public function get label_font():String { return pushButton.label.textFormat.font; }
		
		//label_size
		public function set label_size(value:String):void
		{
			pushButton.label.textFormat.size = BU.S2PI(value);
		}
		public function get label_size():String { return BU.txtSize2Str(pushButton.label.textFormat.size); }
		
		//label_color
		public function set label_color(value:String):void
		{
			pushButton.label.textFormat.color = BU.hex2int(value);
		}
		public function get label_color():String { return BU.int2hex(pushButton.label.textFormat.color); }
		
		//label_bold
		public function set label_bold(value:String):void
		{
			pushButton.label.textFormat.bold = BU.str2bool(value);
		}
		public function get label_bold():String { return BU.bool2str(pushButton.label.textFormat.bold); }
		
		//label_italic
		public function set label_italic(value:String):void
		{
			pushButton.label.textFormat.italic = BU.str2bool(value);
		}
		public function get label_italic():String { return BU.bool2str(pushButton.label.textFormat.italic); }
		
		//label_underline
		public function set label_underline(value:String):void
		{
			pushButton.label.textFormat.underline = BU.str2bool(value);
		}
		public function get label_underline():String { return BU.bool2str(pushButton.label.textFormat.underline); }
		
		public function CsPushButton()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override public function getAttris():Array
		{
			return ["defaultFill", "overFill", "downFill", "disabledFill", "faceFill",
			"label_text", "label_useStroke", "label_strokeColor", "label_strokeBlur",
			"label_strokeStrength", "label_useHtml", "label_font", "label_size",
			"label_color", "label_bold", "label_italic", "label_underline"];
		}
		
		override public function getTpls():Array
		{
			return ["tpl_button"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			
			attriStr += " label_text='" + BU.XML(this.label_text) + "'";
			if(BU.available(tpl_button))
			{
				attriStr += " tpl_button='" + this.tpl_button + "'";
			}
			else
			{
			attriStr += " defaultFill='" + this.defaultFill + "'";
			attriStr += " overFill='" + this.overFill + "'";
			attriStr += " downFill='" + this.downFill + "'";
			attriStr += " disabledFill='" + this.disabledFill + "'";
			attriStr += " faceFill='" + this.faceFill + "'";
			
			attriStr += " label_useStroke='" + this.label_useStroke + "'";
			attriStr += " label_strokeColor='" + this.label_strokeColor + "'";
			attriStr += " label_strokeBlur='" + this.label_strokeBlur + "'";
			attriStr += " label_strokeStrength='" + this.label_strokeStrength + "'";
			attriStr += " label_useHtml='" + this.label_useHtml + "'";
			attriStr += " label_font='" + this.label_font + "'";
			attriStr += " label_size='" + this.label_size + "'";
			attriStr += " label_color='" + this.label_color + "'";
			attriStr += " label_bold='" + this.label_bold + "'";
			attriStr += " label_italic='" + this.label_italic + "'";
			attriStr += " label_underline='" + this.label_underline + "'";
			}
			return "<"+JuiType.JPushButton+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JPushButton+">";
		}
	}
}