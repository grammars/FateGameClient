package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsSlider;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIFill;
	import builder.view.prop.item.PIPair;
	import builder.view.prop.item.PISize;
	
	public class PropSlider extends PropBase
	{
		private static var _instance:PropSlider;
		public static function get instance():PropSlider
		{
			if(_instance == null) { _instance = new PropSlider(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_bgFill:PIFill;
		private var handle_fat:PIPair;
		private var handle_button:PIButton;
		
		public function PropSlider()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_bgFill = new PIFill("bgFill");
			addRoot(this_bgFill);
			
			handle_fat = new PIPair(120, "handleFat");
			addRoot(handle_fat);
			
			handle_button = new PIButton(false, false, false, "handle");
			addRoot(handle_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var slider:CsSlider = shell as CsSlider;
			slider.setWidth( this_size.getWidth() );
			slider.setHeight( this_size.getHeight() );
			
			slider.bgFill = this_bgFill.getFill();
			slider.handleFat = handle_fat.getValue();
			slider.handle_defaultFill = handle_button.getDefaultFill();
			slider.handle_overFill = handle_button.getOverFill();
			slider.handle_downFill = handle_button.getDownFill();
			slider.handle_disabledFill = handle_button.getDisabledFill();
			slider.handle_faceFill = handle_button.getFaceFill();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var slider:CsSlider = shell as CsSlider;
			this_size.setWidth( slider.getWidth() );
			this_size.setHeight( slider.getHeight() );
			
			this_bgFill.setFill( slider.bgFill );
			handle_fat.setValue( slider.handleFat );
			handle_button.setDefaultFill( slider.handle_defaultFill );
			handle_button.setOverFill( slider.handle_overFill );
			handle_button.setDownFill( slider.handle_downFill );
			handle_button.setDisabledFill( slider.handle_disabledFill );
			handle_button.setFaceFill( slider.handle_faceFill );
		}
		
	}
}