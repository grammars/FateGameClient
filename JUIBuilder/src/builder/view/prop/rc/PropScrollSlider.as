package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsScrollSlider;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIFill;
	import builder.view.prop.item.PISize;
	
	public class PropScrollSlider extends PropBase
	{
		private static var _instance:PropScrollSlider;
		public static function get instance():PropScrollSlider
		{
			if(_instance == null) { _instance = new PropScrollSlider(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_bgFill:PIFill;
		private var handle_button:PIButton;
		
		public function PropScrollSlider()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_bgFill = new PIFill("bgFill");
			addRoot(this_bgFill);
			
			handle_button = new PIButton(false, false, false, "handle");
			addRoot(handle_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var scrollSlider:CsScrollSlider = shell as CsScrollSlider;
			scrollSlider.setWidth( this_size.getWidth() );
			scrollSlider.setHeight( this_size.getHeight() );
			
			scrollSlider.bgFill = this_bgFill.getFill();
			scrollSlider.handle_defaultFill = handle_button.getDefaultFill();
			scrollSlider.handle_overFill = handle_button.getOverFill();
			scrollSlider.handle_downFill = handle_button.getDownFill();
			scrollSlider.handle_disabledFill = handle_button.getDisabledFill();
			scrollSlider.handle_faceFill = handle_button.getFaceFill();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var scrollSlider:CsScrollSlider = shell as CsScrollSlider;
			this_size.setWidth( scrollSlider.getWidth() );
			this_size.setHeight( scrollSlider.getHeight() );
			
			this_bgFill.setFill( scrollSlider.bgFill );
			handle_button.setDefaultFill( scrollSlider.handle_defaultFill );
			handle_button.setOverFill( scrollSlider.handle_overFill );
			handle_button.setDownFill( scrollSlider.handle_downFill );
			handle_button.setDisabledFill( scrollSlider.handle_disabledFill );
			handle_button.setFaceFill( scrollSlider.handle_faceFill );
		}
		
	}
}