package builder.view.template.rc
{
	import com.anstu.jui.build.ctrls.CsLabel;
	import builder.view.prop.item.PIBaseText;
	import builder.view.template.TempBase;
	
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class TempLabel extends TempBase
	{
		private static var _instance:TempLabel;
		public static function get instance():TempLabel
		{
			if(_instance == null) { _instance = new TempLabel(); }
			return _instance;
		}
		
		private var uiA:CsLabel = new CsLabel();
		private var uiB:CsLabel = new CsLabel();
		
		public var edit:PIBaseText;
		
		public function TempLabel()
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
			
			edit = new PIBaseText();
			edit.hide("text", "restrict", "maxChars", "password");
			edit.move(20, 100);
			this.addChild(edit);
			
			edit.setAlign(JuiConst.LEFT);
			edit.setValign(JuiConst.UP);
			edit.setAutoWrap("false");
			edit.setUseStroke("true");
			edit.setStrokeColor("0xff0000");
			edit.setStrokeBlur("3");
			edit.setStrokeStrength("3");
			edit.setUseHtml("true");
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
			uiA.align = edit.getAlign();
			uiA.valign = edit.getValign();
			uiA.autoWrap = edit.getAutoWrap();
			uiA.useStroke = edit.getUseStroke();
			uiA.strokeColor = edit.getStrokeColor();
			uiA.strokeBlur = edit.getStrokeBlur();
			uiA.strokeStrength = edit.getStrokeStrength();
			uiA.useHtml = edit.getUseHtml();
			uiA.font = edit.getFont();
			uiA.size = edit.getSize();
			uiA.color = edit.getColor();
			uiA.bold = edit.getBold();
			uiA.italic = edit.getItalic();
			uiA.underline = edit.getUnderline();
			
			uiB.align = edit.getAlign();
			uiB.valign = edit.getValign();
			uiB.autoWrap = edit.getAutoWrap();
			uiB.useStroke = edit.getUseStroke();
			uiB.strokeColor = edit.getStrokeColor();
			uiB.strokeBlur = edit.getStrokeBlur();
			uiB.strokeStrength = edit.getStrokeStrength();
			uiB.useHtml = edit.getUseHtml();
			uiB.font = edit.getFont();
			uiB.size = edit.getSize();
			uiB.color = edit.getColor();
			uiB.bold = edit.getBold();
			uiB.italic = edit.getItalic();
			uiB.underline = edit.getUnderline();
		}
		
		override protected function encode():String
		{
			var attri:String = "";
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
			var result:String = "<" + JuiType.JLabel + attri + ">";
			result += "</"+JuiType.JLabel+">";
			return result;
		}
		
	}
}