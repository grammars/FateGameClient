package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsImage;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIImage;
	import builder.view.prop.item.PISize;
	
	public class PropImage extends PropBase
	{
		private static var _instance:PropImage;
		public static function get instance():PropImage
		{
			if(_instance == null) { _instance = new PropImage(); }
			return _instance;
		}
		
		private var this_size:PISize;
		
		private var this_panel:PIImage;
		
		public function PropImage()
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
			var image:CsImage = shell as CsImage;
			image.setWidth( this_size.getWidth() );
			image.setHeight( this_size.getHeight() );
			
			image.bgAlpha = this_panel.getBgAlpha();
			image.bgColor = this_panel.getBgColor();
			image.fillOpt = this_panel.getFillOpt();
			image.bgFill = this_panel.getBgFill();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var image:CsImage = shell as CsImage;
			this_size.setWidth( image.getWidth() );
			this_size.setHeight( image.getHeight() );
			
			this_panel.setBgAlpha( image.bgAlpha );
			this_panel.setBgColor( image.bgColor );
			this_panel.setFillOpt( image.fillOpt );
			this_panel.setBgFill( image.bgFill );
		}
		
	}
}