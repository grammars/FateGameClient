package builder.view.template.rc
{
	import com.anstu.jui.build.ctrls.CsTitle;
	import builder.view.prop.item.PITitle;
	import builder.view.template.TempBase;
	
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class TempTitle extends TempBase
	{
		private static var _instance:TempTitle;
		public static function get instance():TempTitle
		{
			if(_instance == null) { _instance = new TempTitle(); }
			return _instance;
		}
		
		private var uiA:CsTitle = new CsTitle();
		private var uiB:CsTitle = new CsTitle();
		
		public var edit:PITitle;
		
		public function TempTitle()
		{
			super();
			
			uiA.onlyModel = true;
			uiA.setX("500");
			uiA.setY("30");
			uiA.setWidth("400");
			uiA.setHeight("300");
			uiA.text = "这是一段测试的文本，\rThis is a <font color='#fefe00'>test</font> text.";
			this.addChild(uiA);
			
			uiB.onlyModel = true;
			uiB.setX("500");
			uiB.setY("340");
			uiB.setWidth("100");
			uiB.setHeight("100");
			uiB.text = "这是另一段测试的文本，\rThis is a <br>test text.";
			this.addChild(uiB);
			
			edit = new PITitle();
			edit.hide("restrict", "maxChars", "password", "useHtml");
			edit.move(20, 100);
			this.addChild(edit);
			
			edit.setGradBeg("0xff0000");
			edit.setGradEnd("0x0000ff");
			edit.setAlign(JuiConst.CENTER);
			edit.setValign(JuiConst.UP);
			edit.setAutoWrap("false");
			edit.setUseStroke("true");
			edit.setStrokeColor("0xff0000");
			edit.setStrokeBlur("3");
			edit.setStrokeStrength("3");
			edit.setFont("微软雅黑");
			edit.setSize("14");
			edit.setColor("0x123456");
			edit.setBold("true");
			edit.setItalic("false");
			edit.setUnderline("false");
			
			apply();
		}
		
		override public function apply():void
		{
			uiA.gradBeg = edit.getGradBeg();
			uiA.gradEnd = edit.getGradEnd();
			uiA.align = edit.getAlign();
			uiA.valign = edit.getValign();
			uiA.autoWrap = edit.getAutoWrap();
			uiA.useStroke = edit.getUseStroke();
			uiA.strokeColor = edit.getStrokeColor();
			uiA.strokeBlur = edit.getStrokeBlur();
			uiA.strokeStrength = edit.getStrokeStrength();
			uiA.font = edit.getFont();
			uiA.size = edit.getSize();
			uiA.bold = edit.getBold();
			uiA.italic = edit.getItalic();
			uiA.underline = edit.getUnderline();
			
			uiB.gradBeg = edit.getGradBeg();
			uiB.gradEnd = edit.getGradEnd();
			uiB.align = edit.getAlign();
			uiB.valign = edit.getValign();
			uiB.autoWrap = edit.getAutoWrap();
			uiB.useStroke = edit.getUseStroke();
			uiB.strokeColor = edit.getStrokeColor();
			uiB.strokeBlur = edit.getStrokeBlur();
			uiB.strokeStrength = edit.getStrokeStrength();
			uiB.font = edit.getFont();
			uiB.size = edit.getSize();
			uiB.bold = edit.getBold();
			uiB.italic = edit.getItalic();
			uiB.underline = edit.getUnderline();
		}
		
		override protected function encode():String
		{
			var attri:String = "";
			attri += ATTRI("gradBeg", edit.getGradBeg());
			attri += ATTRI("gradEnd", edit.getGradEnd());
			attri += ATTRI("align", edit.getAlign());
			attri += ATTRI("valign", edit.getValign());
			attri += ATTRI("autoWrap", edit.getAutoWrap());
			attri += ATTRI("useStroke", edit.getUseStroke());
			attri += ATTRI("strokeColor", edit.getStrokeColor());
			attri += ATTRI("strokeBlur", edit.getStrokeBlur());
			attri += ATTRI("strokeStrength", edit.getStrokeStrength());
			attri += ATTRI("useHtml", edit.getUseHtml());
			attri += ATTRI("font", edit.getFont());
			attri += ATTRI("size", edit.getSize());
			attri += ATTRI("color", edit.getColor());
			attri += ATTRI("bold", edit.getBold());
			attri += ATTRI("italic", edit.getItalic());
			attri += ATTRI("underline", edit.getUnderline());
			var result:String = "<" + JuiType.JTitle + attri + ">";
			result += "</"+JuiType.JTitle+">";
			return result;
		}
		
	}
}