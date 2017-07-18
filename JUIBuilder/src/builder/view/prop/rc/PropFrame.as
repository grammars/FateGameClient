package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsFrame;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIBoolean;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIFill;
	import builder.view.prop.item.PIPairShort;
	import builder.view.prop.item.PIImage;
	import builder.view.prop.item.PISize;
	import builder.view.prop.item.parts.PicChooser;

	public class PropFrame extends PropBase
	{
		private static var _instance:PropFrame;
		public static function get instance():PropFrame
		{
			if(_instance == null) { _instance = new PropFrame(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_active:PIBoolean;
		private var this_frameBtnsMarginX:PIPairShort;
		private var this_frameBtnsMarginY:PIPairShort;
		private var this_activeBgFill:PIFill;
		private var this_inactiveBgFill:PIFill;
		private var iconifiedBtn_button:PIButton;
		private var maximizeBtn_button:PIButton;
		private var normalBtn_button:PIButton;
		private var closeBtn_button:PIButton;
		
		public function PropFrame()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_active = new PIBoolean("active", false);
			addRoot(this_active);
			
			this_frameBtnsMarginX = new PIPairShort("frameBtnsMarginX");
			addRoot(this_frameBtnsMarginX);
			this_frameBtnsMarginY = new PIPairShort("frameBtnsMarginY");
			addRoot(this_frameBtnsMarginY);
			
			this_activeBgFill = new PIFill("activeBgFill");
			addRoot(this_activeBgFill);
			
			this_inactiveBgFill = new PIFill("inactiveBgFill");
			addRoot(this_inactiveBgFill);
			
			iconifiedBtn_button = new PIButton(true, false, false, "iconifiedBtn");
			addRoot(iconifiedBtn_button);
			
			maximizeBtn_button = new PIButton(true, false, false, "maximizeBtn");
			addRoot(maximizeBtn_button);
			
			normalBtn_button = new PIButton(true, false, false, "normalBtn");
			addRoot(normalBtn_button);
			
			closeBtn_button = new PIButton(true, false, false, "closeBtn");
			addRoot(closeBtn_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var frame:CsFrame = shell as CsFrame;
			frame.setWidth( this_size.getWidth() );
			frame.setHeight( this_size.getHeight() );
			frame.active = this_active.getValue();
			frame.frameBtnsMarginX = this_frameBtnsMarginX.getValue();
			frame.frameBtnsMarginY = this_frameBtnsMarginY.getValue();
			frame.activeBgFill = this_activeBgFill.getFill();
			frame.inactiveBgFill = this_inactiveBgFill.getFill();
			
			frame.iconifiedBtn_width = iconifiedBtn_button.getWidth();
			frame.iconifiedBtn_height = iconifiedBtn_button.getHeight();
			frame.iconifiedBtn_defaultFill = iconifiedBtn_button.getDefaultFill();
			frame.iconifiedBtn_overFill = iconifiedBtn_button.getOverFill();
			frame.iconifiedBtn_downFill = iconifiedBtn_button.getDownFill();
			frame.iconifiedBtn_disabledFill = iconifiedBtn_button.getDisabledFill();
			frame.iconifiedBtn_faceFill = iconifiedBtn_button.getFaceFill();
			
			frame.maximizeBtn_width = maximizeBtn_button.getWidth();
			frame.maximizeBtn_height = maximizeBtn_button.getHeight();
			frame.maximizeBtn_defaultFill = maximizeBtn_button.getDefaultFill();
			frame.maximizeBtn_overFill = maximizeBtn_button.getOverFill();
			frame.maximizeBtn_downFill = maximizeBtn_button.getDownFill();
			frame.maximizeBtn_disabledFill = maximizeBtn_button.getDisabledFill();
			frame.maximizeBtn_faceFill = maximizeBtn_button.getFaceFill();
			
			frame.normalBtn_width = normalBtn_button.getWidth();
			frame.normalBtn_height = normalBtn_button.getHeight();
			frame.normalBtn_defaultFill = normalBtn_button.getDefaultFill();
			frame.normalBtn_overFill = normalBtn_button.getOverFill();
			frame.normalBtn_downFill = normalBtn_button.getDownFill();
			frame.normalBtn_disabledFill = normalBtn_button.getDisabledFill();
			frame.normalBtn_faceFill = normalBtn_button.getFaceFill();
			
			frame.closeBtn_width = closeBtn_button.getWidth();
			frame.closeBtn_height = closeBtn_button.getHeight();
			frame.closeBtn_defaultFill = closeBtn_button.getDefaultFill();
			frame.closeBtn_overFill = closeBtn_button.getOverFill();
			frame.closeBtn_downFill = closeBtn_button.getDownFill();
			frame.closeBtn_disabledFill = closeBtn_button.getDisabledFill();
			frame.closeBtn_faceFill = closeBtn_button.getFaceFill();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var frame:CsFrame = shell as CsFrame;
			this_size.setWidth( frame.getWidth() );
			this_size.setHeight( frame.getHeight() );
			this_active.setValue( frame.active );
			this_frameBtnsMarginX.setValue( frame.frameBtnsMarginX );
			this_frameBtnsMarginY.setValue( frame.frameBtnsMarginY );
			this_activeBgFill.setFill( frame.activeBgFill );
			this_inactiveBgFill.setFill( frame.inactiveBgFill );
			
			iconifiedBtn_button.setWidth( frame.iconifiedBtn_width );
			iconifiedBtn_button.setHeight( frame.iconifiedBtn_height );
			iconifiedBtn_button.setDefaultFill( frame.iconifiedBtn_defaultFill );
			iconifiedBtn_button.setOverFill( frame.iconifiedBtn_overFill );
			iconifiedBtn_button.setDownFill( frame.iconifiedBtn_downFill );
			iconifiedBtn_button.setDisabledFill( frame.iconifiedBtn_disabledFill );
			iconifiedBtn_button.setFaceFill( frame.iconifiedBtn_faceFill );
			
			maximizeBtn_button.setWidth( frame.maximizeBtn_width );
			maximizeBtn_button.setHeight( frame.maximizeBtn_height );
			maximizeBtn_button.setDefaultFill( frame.maximizeBtn_defaultFill );
			maximizeBtn_button.setOverFill( frame.maximizeBtn_overFill );
			maximizeBtn_button.setDownFill( frame.maximizeBtn_downFill );
			maximizeBtn_button.setDisabledFill( frame.maximizeBtn_disabledFill );
			maximizeBtn_button.setFaceFill( frame.maximizeBtn_faceFill );
			
			normalBtn_button.setWidth( frame.normalBtn_width );
			normalBtn_button.setHeight( frame.normalBtn_height );
			normalBtn_button.setDefaultFill( frame.normalBtn_defaultFill );
			normalBtn_button.setOverFill( frame.normalBtn_overFill );
			normalBtn_button.setDownFill( frame.normalBtn_downFill );
			normalBtn_button.setDisabledFill( frame.normalBtn_disabledFill );
			normalBtn_button.setFaceFill( frame.normalBtn_faceFill );
			
			closeBtn_button.setWidth( frame.closeBtn_width );
			closeBtn_button.setHeight( frame.closeBtn_height );
			closeBtn_button.setDefaultFill( frame.closeBtn_defaultFill );
			closeBtn_button.setOverFill( frame.closeBtn_overFill );
			closeBtn_button.setDownFill( frame.closeBtn_downFill );
			closeBtn_button.setDisabledFill( frame.closeBtn_disabledFill );
			closeBtn_button.setFaceFill( frame.closeBtn_faceFill );
		}
		
	}
}