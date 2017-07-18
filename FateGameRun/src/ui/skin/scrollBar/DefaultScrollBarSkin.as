package ui.skin.scrollBar
{
	import com.anstu.jui.skin.JScrollBarSkin;
	
	import res.Res;
	
	public class DefaultScrollBarSkin extends JScrollBarSkin
	{
		private static var _instance:DefaultScrollBarSkin;
		public static function get instance():DefaultScrollBarSkin
		{
			if(_instance == null) { _instance = new DefaultScrollBarSkin(); }
			return _instance;
		}
		
		public function DefaultScrollBarSkin()
		{
			super();
			
			base_ns = Res.NS;
			
			h_background_cls = "scroll_bound$png";
			h_handle_default_cls = "scroll_bar0$png";
			h_handle_over_cls = "scroll_bar1$png";
			h_handle_down_cls = "scroll_bar2$png";
			h_handle_disabled_cls = "scroll_bar0$png";
			h_handle_face_cls = "scroll_barFace$png";
			
			v_background_cls = "scroll_bound$png";
			v_handle_default_cls = "scroll_bar0$png";
			v_handle_over_cls = "scroll_bar1$png";
			v_handle_down_cls = "scroll_bar2$png";
			v_handle_disabled_cls = "scroll_bar0$png";
			v_handle_face_cls = "scroll_barFace$png";
			
			handle_size = 19;
			
			h_upBtn_default_cls = "scroll_v_up0$png";
			h_upBtn_over_cls = "scroll_v_up1$png";
			h_upBtn_down_cls = "scroll_v_up2$png";
			h_upBtn_disabled_cls = "scroll_v_up0$png";
			h_downBtn_default_cls = "scroll_v_down0$png";
			h_downBtn_over_cls = "scroll_v_down1$png";
			h_downBtn_down_cls = "scroll_v_down2$png";
			h_downBtn_disabled_cls = "scroll_v_down0$png";
			
			v_upBtn_default_cls = "scroll_v_up0$png";
			v_upBtn_over_cls = "scroll_v_up1$png";
			v_upBtn_down_cls = "scroll_v_up2$png";
			v_upBtn_disabled_cls = "scroll_v_up0$png";
			v_downBtn_default_cls = "scroll_v_down0$png";
			v_downBtn_over_cls = "scroll_v_down1$png";
			v_downBtn_down_cls = "scroll_v_down2$png";
			v_downBtn_disabled_cls = "scroll_v_down0$png";
			
			h_btns_width = 19;
			h_btns_height = 21;
			
			v_btns_width = 19;
			v_btns_height = 21;
		}
	}
}