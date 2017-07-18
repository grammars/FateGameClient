package builder.view.template.rc
{
	import com.anstu.jui.build.ctrls.CsPushButton;
	import builder.view.prop.item.PIButton;
	import builder.view.template.TempBase;
	
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.define.JuiType;
	
	public class TempPushButton extends TempBase
	{
		private static var _instance:TempPushButton;
		public static function get instance():TempPushButton
		{
			if(_instance == null) { _instance = new TempPushButton(); }
			return _instance;
		}
		
		private var ui:CsPushButton;
		
		public var edit:PIButton;
		
		public function TempPushButton()
		{
			super();
			
			ui = new CsPushButton();
			ui.onlyModel = true;
			ui.setX("500");
			ui.setY("100");
			ui.setWidth("100");
			ui.setHeight("50");
			ui.label_text = "测试文字";
			this.addChild(ui);
			
			edit = new PIButton(true, false, true);
			edit.move(20, 100);
			this.addChild(edit);
		}
		
		override public function apply():void
		{
			ui.setWidth( edit.getWidth() );
			ui.setHeight( edit.getHeight() );
			
			ui.defaultFill = edit.getDefaultFill();
			ui.overFill = edit.getOverFill();
			ui.downFill = edit.getDownFill();
			ui.disabledFill = edit.getDisabledFill();
			ui.faceFill = edit.getFaceFill();
			
			ui.label_text = edit.labelPI.getText();//但是不用
			
			ui.label_useStroke = edit.labelPI.getUseStroke();
			ui.label_strokeColor = edit.labelPI.getStrokeColor();
			ui.label_strokeBlur = edit.labelPI.getStrokeBlur();
			ui.label_strokeStrength = edit.labelPI.getStrokeStrength();
			ui.label_useHtml = edit.labelPI.getUseHtml();
			ui.label_font = edit.labelPI.getFont();
			ui.label_size = edit.labelPI.getSize();
			ui.label_color = edit.labelPI.getColor();
			ui.label_bold = edit.labelPI.getBold();
			ui.label_italic = edit.labelPI.getItalic();
			ui.label_underline = edit.labelPI.getUnderline();
		}
		
		override protected function encode():String
		{
			var attri:String = "";
			attri += ATTRI("defaultFill", edit.getDefaultFill());
			attri += ATTRI("overFill", edit.getOverFill());
			attri += ATTRI("downFill", edit.getDownFill());
			attri += ATTRI("disabledFill", edit.getDisabledFill());
			attri += ATTRI("faceFill", edit.getFaceFill());
			attri += ATTRI("label_useStroke", edit.labelPI.getUseStroke());
			attri += ATTRI("label_strokeColor", edit.labelPI.getStrokeColor());
			attri += ATTRI("label_strokeBlur", edit.labelPI.getStrokeBlur());
			attri += ATTRI("label_strokeStrength", edit.labelPI.getStrokeStrength());
			attri += ATTRI("label_useHtml", edit.labelPI.getUseHtml());
			attri += ATTRI("label_font", edit.labelPI.getFont());
			attri += ATTRI("label_size", edit.labelPI.getSize());
			attri += ATTRI("label_color", edit.labelPI.getColor());
			attri += ATTRI("label_bold", edit.labelPI.getBold());
			attri += ATTRI("label_italic", edit.labelPI.getItalic());
			attri += ATTRI("label_underline", edit.labelPI.getUnderline());
			var result:String = "<" + JuiType.JPushButton + attri + ">";
			result += "</"+JuiType.JPushButton+">";
			return result;
		}
	}
}