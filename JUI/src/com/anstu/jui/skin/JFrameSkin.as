package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JFrame;
	import com.anstu.jui.define.JSize;
	
	import flash.geom.Point;

	public class JFrameSkin
	{
		public var base_ns:String = "default";
		
		public var paneBg_ns:String = "default";
		
		public var activeBg_cls:String = "Frame_bg_active.png";
		public var inactiveBg_cls:String = "Frame_bg_inactive.png";
		
		public var iconifiedBtn_defaultBg_cls:String = "Frame_iconified_default.png";
		public var iconifiedBtn_downBg_cls:String = "Frame_iconified_pressed.png";
		public var iconifiedBtn_overBg_cls:String = "Frame_iconified_over.png";
		public var iconifiedBtn_disabledBg_cls:String = "Frame_iconified_disabled.png";
		
		public var maximizeBtn_defaultBg_cls:String = "Frame_maximize_default.png";
		public var maximizeBtn_downBg_cls:String = "Frame_maximize_pressed.png";
		public var maximizeBtn_overBg_cls:String = "Frame_maximize_over.png";
		public var maximizeBtn_disabledBg_cls:String = "Frame_maximize_disabled.png";
		
		public var normalBtn_defaultBg_cls:String = "Frame_normal_default.png";
		public var normalBtn_downBg_cls:String = "Frame_normal_pressed.png";
		public var normalBtn_overBg_cls:String = "Frame_normal_over.png";
		public var normalBtn_disabledBg_cls:String = "Frame_normal_disabled.png";
		
		public var closeBtn_defaultBg_cls:String = "Frame_close_default.png";
		public var closeBtn_downBg_cls:String = "Frame_close_pressed.png";
		public var closeBtn_overBg_cls:String = "Frame_close_over.png";
		public var closeBtn_disabledBg_cls:String = "Frame_close_disabled.png";
		
		protected var _frameBtnsMargin:Point = new Point(10, 1);
		/** 设置关闭、最大化、常规化、最小化按钮的距离右上角的边距 */
		public function setFrameBtnsMargin(mx:int, my:int):void
		{
			_frameBtnsMargin.x = mx;
			_frameBtnsMargin.y = my;
		}
		
		protected var _iconifiedBtnSize:JSize = new JSize(26, 27);
		protected var _maximizeBtnSize:JSize = new JSize(25, 27);
		protected var _normalBtnSize:JSize = new JSize(25, 27);
		protected var _closeBtnSize:JSize = new JSize(43, 27);
		/** 设置Frame按钮的尺寸 */
		public function setFrameBtnsSize(iconifiedW:int, iconifiedH:int, maximizeW:int, maximizeH:int, normalW:int, normalH:int, closeW:int, closeH:int):void
		{
			_iconifiedBtnSize.width = iconifiedW;
			_iconifiedBtnSize.height = iconifiedH;
			
			_maximizeBtnSize.width = maximizeW;
			_maximizeBtnSize.height = maximizeH;
			
			_normalBtnSize.width = normalW;
			_normalBtnSize.height = normalH;
			
			_closeBtnSize.width = closeW;
			_closeBtnSize.height = closeH;
		}
		
		public function JFrameSkin()
		{
		}
		
		public function apply(frame:JFrame):void
		{
			frame.setFrameBtnsMargin(_frameBtnsMargin.x, _frameBtnsMargin.y);
			frame.setFrameBtnsSize(_iconifiedBtnSize.width, _iconifiedBtnSize.height, 
				_maximizeBtnSize.width, _maximizeBtnSize.height, 
				_normalBtnSize.width, _normalBtnSize.height, 
				_closeBtnSize.width, _closeBtnSize.height);
			
			frame.fillActiveBg( JResource.getBmp(activeBg_cls, paneBg_ns) );
			frame.fillInactiveBg( JResource.getBmp(inactiveBg_cls, paneBg_ns) );
			
			var iconifiedBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			iconifiedBtnSkin.base_ns = base_ns;
			iconifiedBtnSkin.defaultBg_cls = iconifiedBtn_defaultBg_cls;
			iconifiedBtnSkin.downBg_cls = iconifiedBtn_downBg_cls;
			iconifiedBtnSkin.overBg_cls = iconifiedBtn_overBg_cls;
			iconifiedBtnSkin.disabledBg_cls = iconifiedBtn_disabledBg_cls;
			iconifiedBtnSkin.apply( frame.iconifiedBtn );
			
			var maximizeBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			maximizeBtnSkin.base_ns = base_ns;
			maximizeBtnSkin.defaultBg_cls = maximizeBtn_defaultBg_cls;
			maximizeBtnSkin.downBg_cls = maximizeBtn_downBg_cls;
			maximizeBtnSkin.overBg_cls = maximizeBtn_overBg_cls;
			maximizeBtnSkin.disabledBg_cls = maximizeBtn_disabledBg_cls;
			maximizeBtnSkin.apply( frame.maximizeBtn );
			
			var normalBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			normalBtnSkin.base_ns = base_ns;
			normalBtnSkin.defaultBg_cls = normalBtn_defaultBg_cls;
			normalBtnSkin.downBg_cls = normalBtn_downBg_cls;
			normalBtnSkin.overBg_cls = normalBtn_overBg_cls;
			normalBtnSkin.disabledBg_cls = normalBtn_disabledBg_cls;
			normalBtnSkin.apply( frame.normalBtn );
			
			var closeBtnSkin:JPushButtonSkin = new JPushButtonSkin();
			closeBtnSkin.base_ns = base_ns;
			closeBtnSkin.defaultBg_cls = closeBtn_defaultBg_cls;
			closeBtnSkin.downBg_cls = closeBtn_downBg_cls;
			closeBtnSkin.overBg_cls = closeBtn_overBg_cls;
			closeBtnSkin.disabledBg_cls = closeBtn_disabledBg_cls;
			closeBtnSkin.apply( frame.closeBtn );
		}
	}
}