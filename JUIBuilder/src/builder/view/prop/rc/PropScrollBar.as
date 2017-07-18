package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsScrollBar;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIFill;
	import builder.view.prop.item.PISize;
	
	public class PropScrollBar extends PropBase
	{
		private static var _instance:PropScrollBar;
		public static function get instance():PropScrollBar
		{
			if(_instance == null) { _instance = new PropScrollBar(); }
			return _instance;
		}
		
		private var this_size:PISize;
		private var this_bgFill:PIFill;
		private var handle_button:PIButton;
		private var up_button:PIButton;
		private var down_button:PIButton;
		
		public function PropScrollBar()
		{
			super();
			
			this_size = new PISize();
			addRoot(this_size);
			
			this_bgFill = new PIFill("bgFill");
			addRoot(this_bgFill);
			
			handle_button = new PIButton(false, false, false, "handle");
			addRoot(handle_button);
			
			up_button = new PIButton(true, false, false, "←↑button");
			addRoot(up_button);
			
			down_button = new PIButton(true, false, false, "↓→button");
			addRoot(down_button);
		}
		
		override public function apply():void
		{
			super.apply();
			var scrollBar:CsScrollBar = shell as CsScrollBar;
			scrollBar.setWidth( this_size.getWidth() );
			scrollBar.setHeight( this_size.getHeight() );
			
			scrollBar.bgFill = this_bgFill.getFill();
			scrollBar.handle_defaultFill = handle_button.getDefaultFill();
			scrollBar.handle_overFill = handle_button.getOverFill();
			scrollBar.handle_downFill = handle_button.getDownFill();
			scrollBar.handle_disabledFill = handle_button.getDisabledFill();
			scrollBar.handle_faceFill = handle_button.getFaceFill();
			
			scrollBar.upBtn_width = up_button.getWidth();
			scrollBar.upBtn_height = up_button.getHeight();
			scrollBar.upBtn_defaultFill = up_button.getDefaultFill();
			scrollBar.upBtn_overFill = up_button.getOverFill();
			scrollBar.upBtn_downFill = up_button.getDownFill();
			scrollBar.upBtn_disabledFill = up_button.getDisabledFill();
			scrollBar.upBtn_faceFill = up_button.getFaceFill();
			
			scrollBar.downBtn_width = down_button.getWidth();
			scrollBar.downBtn_height = down_button.getHeight();
			scrollBar.downBtn_defaultFill = down_button.getDefaultFill();
			scrollBar.downBtn_overFill = down_button.getOverFill();
			scrollBar.downBtn_downFill = down_button.getDownFill();
			scrollBar.downBtn_disabledFill = down_button.getDisabledFill();
			scrollBar.downBtn_faceFill = down_button.getFaceFill();
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var scrollBar:CsScrollBar = shell as CsScrollBar;
			this_size.setWidth( scrollBar.getWidth() );
			this_size.setHeight( scrollBar.getHeight() );
			
			this_bgFill.setFill( scrollBar.bgFill );
			handle_button.setDefaultFill( scrollBar.handle_defaultFill );
			handle_button.setOverFill( scrollBar.handle_overFill );
			handle_button.setDownFill( scrollBar.handle_downFill );
			handle_button.setDisabledFill( scrollBar.handle_disabledFill );
			handle_button.setFaceFill( scrollBar.handle_faceFill );
			
			up_button.setWidth( scrollBar.upBtn_width );
			up_button.setHeight( scrollBar.upBtn_height );
			up_button.setDefaultFill( scrollBar.upBtn_defaultFill );
			up_button.setOverFill( scrollBar.upBtn_overFill );
			up_button.setDownFill( scrollBar.upBtn_downFill );
			up_button.setDisabledFill( scrollBar.upBtn_disabledFill );
			up_button.setFaceFill( scrollBar.upBtn_faceFill );
			
			down_button.setWidth( scrollBar.downBtn_width );
			down_button.setHeight( scrollBar.downBtn_height );
			down_button.setDefaultFill( scrollBar.downBtn_defaultFill );
			down_button.setOverFill( scrollBar.downBtn_overFill );
			down_button.setDownFill( scrollBar.downBtn_downFill );
			down_button.setDisabledFill( scrollBar.downBtn_disabledFill );
			down_button.setFaceFill( scrollBar.downBtn_faceFill );
		}
		
	}
}