package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsScrollPanel;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIFill;
	import builder.view.prop.item.PIImage;
	import builder.view.prop.item.PIPair;
	import builder.view.prop.item.PIScrollBar;
	import builder.view.prop.item.PISize;
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class PropScrollPanel extends PropBase
	{
		private static var _instance:PropScrollPanel;
		public static function get instance():PropScrollPanel
		{
			if(_instance == null) { _instance = new PropScrollPanel(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var this_panel:PIImage;
		
		private var scrollH:PITemplate;
		private var scrollV:PITemplate;
		
		public function PropScrollPanel()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_panel = new PIImage();
			addRoot(this_panel);
			
			scrollH = new PITemplate(JuiType.JScrollBarH, "scrollH");
			addRoot(scrollH);
			
			scrollV = new PITemplate(JuiType.JScrollBarV, "scrollV");
			addRoot(scrollV);
		}
		
		override public function apply():void
		{
			super.apply();
			var scrollPanel:CsScrollPanel = shell as CsScrollPanel;
			scrollPanel.setWidth( this_size.getWidth() );
			scrollPanel.setHeight( this_size.getHeight() );
			
			scrollPanel.bgAlpha = this_panel.getBgAlpha();
			scrollPanel.bgColor = this_panel.getBgColor();
			scrollPanel.bgFill = this_panel.getBgFill();
			
			scrollPanel.tpl_scrollBarH = scrollH.value;
			scrollPanel.tpl_scrollBarV = scrollV.value;
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var scrollPanel:CsScrollPanel = shell as CsScrollPanel;
			this_size.setWidth( scrollPanel.getWidth() );
			this_size.setHeight( scrollPanel.getHeight() );
			
			this_panel.setBgAlpha( scrollPanel.bgAlpha );
			this_panel.setBgColor( scrollPanel.bgColor );
			this_panel.setBgFill( scrollPanel.bgFill );
			
			scrollH.value = scrollPanel.tpl_scrollBarH;
			scrollV.value = scrollPanel.tpl_scrollBarV;
		}
		
	}
}