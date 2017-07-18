package com.anstu.jui.build.template.info
{
	import com.anstu.jui.build.ctrls.CsScrollBar;
	import com.anstu.jui.build.template.TemplateInfo;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JScrollBar;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class TiScrollBarV extends TemplateInfo
	{
		public var fatSize:String;
		public var bgFill:String;
		
		public var handle_defaultFill:String;
		public var handle_overFill:String;
		public var handle_downFill:String;
		public var handle_disabledFill:String;
		public var handle_faceFill:String;
		
		public var upBtn_width:String;
		public var upBtn_height:String;
		public var upBtn_defaultFill:String;
		public var upBtn_overFill:String;
		public var upBtn_downFill:String;
		public var upBtn_disabledFill:String;
		public var upBtn_faceFill:String;
		
		public var downBtn_width:String;
		public var downBtn_height:String;
		public var downBtn_defaultFill:String;
		public var downBtn_overFill:String;
		public var downBtn_downFill:String;
		public var downBtn_disabledFill:String;
		public var downBtn_faceFill:String;
		
		public function TiScrollBarV()
		{
			super();
			type = JuiType.JScrollBarV;
		}
		
		override public function parse(name:String, xml:XML):void
		{
			super.parse(name, xml);
			
			fatSize = AttriVal("fatSize");
			bgFill = AttriVal("bgFill");
			
			handle_defaultFill = AttriVal("handle_defaultFill");
			handle_overFill = AttriVal("handle_overFill");
			handle_downFill = AttriVal("handle_downFill");
			handle_disabledFill = AttriVal("handle_disabledFill");
			handle_faceFill = AttriVal("handle_faceFill");
			
			upBtn_width = AttriVal("upBtn_width");
			upBtn_height = AttriVal("upBtn_height");
			upBtn_defaultFill = AttriVal("upBtn_defaultFill");
			upBtn_overFill = AttriVal("upBtn_overFill");
			upBtn_downFill = AttriVal("upBtn_downFill");
			upBtn_disabledFill = AttriVal("upBtn_disabledFill");
			upBtn_faceFill = AttriVal("upBtn_faceFill");
			
			downBtn_width = AttriVal("downBtn_width");
			downBtn_height = AttriVal("downBtn_height");
			downBtn_defaultFill = AttriVal("downBtn_defaultFill");
			downBtn_overFill = AttriVal("downBtn_overFill");
			downBtn_downFill = AttriVal("downBtn_downFill");
			downBtn_disabledFill = AttriVal("downBtn_disabledFill");
			downBtn_faceFill = AttriVal("downBtn_faceFill");
		}
		
		override public function apply(ui:JComponent):void
		{
			var scrollBar:JScrollBar = ui as JScrollBar;
			if(!scrollBar) { return; }
			var shell:CsScrollBar = new CsScrollBar(JuiConst.VERTICAL);
			shell.assetsNS = this.assetsNS;
			shell.inject(scrollBar);
			
			shell.fatSize = fatSize;
			shell.bgFill = bgFill;
			
			shell.handle_defaultFill = handle_defaultFill;
			shell.handle_overFill = handle_overFill;
			shell.handle_downFill = handle_downFill;
			shell.handle_disabledFill = handle_disabledFill;
			shell.handle_faceFill = handle_faceFill;
			
			shell.upBtn_width = upBtn_width;
			shell.upBtn_height = upBtn_height;
			shell.upBtn_defaultFill = upBtn_defaultFill;
			shell.upBtn_overFill = upBtn_overFill;
			shell.upBtn_downFill = upBtn_downFill;
			shell.upBtn_disabledFill = upBtn_disabledFill;
			shell.upBtn_faceFill = upBtn_faceFill;
			
			shell.downBtn_width = downBtn_width;
			shell.downBtn_height = downBtn_height;
			shell.downBtn_defaultFill = downBtn_defaultFill;
			shell.downBtn_overFill = downBtn_overFill;
			shell.downBtn_downFill = downBtn_downFill;
			shell.downBtn_disabledFill = downBtn_disabledFill;
			shell.downBtn_faceFill = downBtn_faceFill;
		}
		
	}
}