package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsPanel;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.item.PIImage;
	import builder.view.prop.item.PISize;
	import builder.view.prop.PropBase;

	public class PropPanel extends PropBase
	{
		private static var _instance:PropPanel;
		public static function get instance():PropPanel
		{
			if(_instance == null) { _instance = new PropPanel(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var this_panel:PIImage;
		
		public function PropPanel()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_panel = new PIImage();
			addRoot(this_panel);
		}
		
		override public function apply():void
		{
			super.apply();
			var panel:CsPanel = shell as CsPanel;
			panel.setWidth( this_size.getWidth() );
			panel.setHeight( this_size.getHeight() );
			panel.bgAlpha = this_panel.getBgAlpha();
			panel.bgColor = this_panel.getBgColor();
			panel.fillOpt = this_panel.getFillOpt();
			panel.bgFill = this_panel.getBgFill();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var panel:CsPanel = shell as CsPanel;
			this_size.setWidth( panel.getWidth() );
			this_size.setHeight( panel.getHeight() );
			this_panel.setBgAlpha( panel.bgAlpha );
			this_panel.setBgColor( panel.bgColor );
			this_panel.setFillOpt( panel.fillOpt );
			this_panel.setBgFill( panel.bgFill );
		}
		
	}
}