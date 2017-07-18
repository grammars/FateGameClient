package builder.view.template.rc
{
	import com.anstu.jui.build.ctrls.CsScrollBar;
	import builder.view.prop.item.PIScrollBar;
	import builder.view.template.TempBase;
	
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class TempScrollBarV extends TempBase
	{
		private static var _instance:TempScrollBarV;
		public static function get instance():TempScrollBarV
		{
			if(_instance == null) { _instance = new TempScrollBarV(); }
			return _instance;
		}
		
		private var ui:CsScrollBar;
		
		public var edit:PIScrollBar;
		
		public function TempScrollBarV()
		{
			super();
			
			ui = new CsScrollBar(JuiConst.VERTICAL);
			ui.onlyModel = true;
			ui.setX("530");
			ui.setY("100");
			ui.setWidth("30");
			ui.setHeight("200");
			this.addChild(ui);
			
			edit = new PIScrollBar(JuiConst.VERTICAL, null, true, false);
			edit.move(20, 100);
			this.addChild(edit);
		}
		
		override public function apply():void
		{
			ui.fatSize = edit.fatSize.getValue();
			ui.bgFill = edit.bgFill.getFill();
			
			ui.handle_defaultFill = edit.handleBtn.getDefaultFill();
			ui.handle_overFill = edit.handleBtn.getOverFill();
			ui.handle_downFill = edit.handleBtn.getDownFill();
			ui.handle_disabledFill = edit.handleBtn.getDisabledFill();
			ui.handle_faceFill = edit.handleBtn.getFaceFill();
			
			ui.upBtn_width = edit.upBtn.getWidth();
			ui.upBtn_height = edit.upBtn.getHeight();
			ui.upBtn_defaultFill = edit.upBtn.getDefaultFill();
			ui.upBtn_overFill = edit.upBtn.getOverFill();
			ui.upBtn_downFill = edit.upBtn.getDownFill();
			ui.upBtn_disabledFill = edit.upBtn.getDisabledFill();
			ui.upBtn_faceFill = edit.upBtn.getFaceFill();
			
			ui.downBtn_width = edit.downBtn.getWidth();
			ui.downBtn_height = edit.downBtn.getHeight();
			ui.downBtn_defaultFill = edit.downBtn.getDefaultFill();
			ui.downBtn_overFill = edit.downBtn.getOverFill();
			ui.downBtn_downFill = edit.downBtn.getDownFill();
			ui.downBtn_disabledFill = edit.downBtn.getDisabledFill();
			ui.downBtn_faceFill = edit.downBtn.getFaceFill();
		}
		
		override protected function encode():String
		{
			var attri:String = "";
			attri += ATTRI("fatSize", edit.fatSize.getValue());
			attri += ATTRI("bgFill", edit.bgFill.getFill());
			
			attri += ATTRI("handle_defaultFill", edit.handleBtn.getDefaultFill());
			attri += ATTRI("handle_overFill", edit.handleBtn.getOverFill());
			attri += ATTRI("handle_downFill", edit.handleBtn.getDownFill());
			attri += ATTRI("handle_disabledFill", edit.handleBtn.getDisabledFill());
			attri += ATTRI("handle_faceFill", edit.handleBtn.getFaceFill());
			
			attri += ATTRI("upBtn_width", edit.upBtn.getWidth());
			attri += ATTRI("upBtn_height", edit.upBtn.getHeight());
			attri += ATTRI("upBtn_defaultFill", edit.upBtn.getDefaultFill());
			attri += ATTRI("upBtn_overFill", edit.upBtn.getOverFill());
			attri += ATTRI("upBtn_downFill", edit.upBtn.getDownFill());
			attri += ATTRI("upBtn_disabledFill", edit.upBtn.getDisabledFill());
			attri += ATTRI("upBtn_faceFill", edit.upBtn.getFaceFill());
			
			attri += ATTRI("downBtn_width", edit.downBtn.getWidth());
			attri += ATTRI("downBtn_height", edit.downBtn.getHeight());
			attri += ATTRI("downBtn_defaultFill", edit.downBtn.getDefaultFill());
			attri += ATTRI("downBtn_overFill", edit.downBtn.getOverFill());
			attri += ATTRI("downBtn_downFill", edit.downBtn.getDownFill());
			attri += ATTRI("downBtn_disabledFill", edit.downBtn.getDisabledFill());
			attri += ATTRI("downBtn_faceFill", edit.downBtn.getFaceFill());
			
			var result:String = "<" + JuiType.JScrollBarV + attri + ">";
			result += "</"+JuiType.JScrollBarV+">";
			return result;
		}
		
	}
}