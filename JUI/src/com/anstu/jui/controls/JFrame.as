package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.define.JSize;
	import com.anstu.jui.define.JuiType;
	import com.anstu.jui.events.JFrameEvent;
	import com.anstu.jui.events.JReporter;
	
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class JFrame extends JComponent
	{
		/** 最小化 */
		public static const SIZE_ICONIFIED:String = "SIZE_ICONIFIED";
		/** 正常化 */
		public static const SIZE_NORMAL:String = "SIZE_NORMAL";
		/** 最大化 */
		public static const SIZE_MAXIMIZE:String = "SIZE_MAXIMIZE";
		
		protected var _pane:JPanel;
		public function get pane():JPanel { return _pane; }
		protected var _iconifiedBtn:JPushButton;
		public function get iconifiedBtn():JPushButton { return _iconifiedBtn; }
		protected var _maximizeBtn:JPushButton;
		public function get maximizeBtn():JPushButton { return _maximizeBtn; }
		protected var _normalBtn:JPushButton;
		public function get normalBtn():JPushButton { return _normalBtn; }
		protected var _closeBtn:JPushButton;
		public function get closeBtn():JPushButton { return _closeBtn; }
		
		/** 按钮是否实际起作用[为UI编辑器添加的功能] */
		public var btnAvailable:Boolean = true;
		
		/** 需要重绘背景 */
		private var _needRepaintBg:Boolean = true;
		protected function repaintBackground():void
		{
			_needRepaintBg = true;
			invalidate();
		}
		
		protected var _active:Boolean = true;
		/** frame是否激活 */
		public function set active(value:Boolean):void
		{
			if(_active != value)
			{
				_active = value;
				repaintBackground();
			}
		}
		public function get active():Boolean { return _active; }
		
		protected var _activeBgFiller:DisplayObject;
		public function fillActiveBg(filler:DisplayObject):void
		{
			_activeBgFiller = filler;
			repaintBackground();
		}
		
		protected var _inactiveBgFiller:DisplayObject;
		public function fillInactiveBg(filler:DisplayObject):void
		{
			_inactiveBgFiller = filler;
			repaintBackground();
		}
		
		protected var _iconifiedSize:JSize = new JSize(169, 169);
		/** 最小化size设置 */
		public function setIconifiedSize(w:int, h:int):void
		{
			_iconifiedSize.width = w;
			_iconifiedSize.height = h;
		}
		
		protected var _maximizeSize:JSize = new JSize(800, 600);
		/** 最大化size设置 */
		public function setMaximizeSize(w:int, h:int):void
		{
			_maximizeSize.width = w;
			_maximizeSize.height = h;
		}
		
		protected var _normalSize:JSize = new JSize(420, 300);
		/** 常规化size设置 */
		public function setNormalSize(w:int, h:int):void
		{
			_normalSize.width = w;
			_normalSize.height = h;
		}
		
		protected var _frameBtnsMargin:Point = new Point(10, 1);
		/** 设置关闭、最大化、常规化、最小化按钮的距离右上角的边距 */
		public function setFrameBtnsMargin(mx:int, my:int):void
		{
			_frameBtnsMargin.x = mx;
			_frameBtnsMargin.y = my;
			invalidate();
		}
		
		/** 设置关闭、最大化、常规化、最小化按钮的距离右上角的边距(X轴方向) */
		public function set frameBtnsMarginX(value:int):void
		{
			_frameBtnsMargin.x = value;
			invalidate();
		}
		public function get frameBtnsMarginX():int { return _frameBtnsMargin.x; }
		
		/** 设置关闭、最大化、常规化、最小化按钮的距离右上角的边距(Y轴方向) */
		public function set frameBtnsMarginY(value:int):void
		{
			_frameBtnsMargin.y = value;
			invalidate();
		}
		public function get frameBtnsMarginY():int { return _frameBtnsMargin.y; }
		
		/** 设置Frame按钮的尺寸 */
		public function setFrameBtnsSize(iconifiedW:int, iconifiedH:int, maximizeW:int, maximizeH:int, normalW:int, normalH:int, closeW:int, closeH:int):void
		{
			_iconifiedBtn.width = iconifiedW;
			_iconifiedBtn.height = iconifiedH;
			
			_maximizeBtn.width = maximizeW;
			_maximizeBtn.height = maximizeH;
			
			_normalBtn.width = normalW;
			_normalBtn.height = normalH;
			
			_closeBtn.width = closeW;
			_closeBtn.height = closeH;
		}
		
		/** 设置尺寸模式 最大化、正常化、最小化 */
		public function set sizeMode(value:String):void
		{
			switch(value)
			{
			case SIZE_ICONIFIED:
				setSize(_iconifiedSize.width, _iconifiedSize.height);
				break;
			case SIZE_NORMAL:
				setSize(_normalSize.width, _normalSize.height);
				break;
			case SIZE_MAXIMIZE:
				setSize(_maximizeSize.width, _maximizeSize.height);
				break;
			}
		}
		public function get sizeMode():String
		{
			var sizeStat:String;
			if(_width <= _iconifiedSize.width && _height <= _iconifiedSize.height)
			{
				sizeStat = SIZE_ICONIFIED;
			}
			else if(_width >= _maximizeSize.width && _height >= _maximizeSize.height)
			{
				sizeStat = SIZE_MAXIMIZE;
			}
			else
			{
				sizeStat = SIZE_NORMAL;
			}
			return sizeStat;
		}
		
		public function JFrame()
		{
			super();
			this._type = JuiType.JFrame;
		}
		
		override protected function init():void
		{
			this.setSize(_normalSize.width, _normalSize.height);
			super.init();
			JReporter.instance.addEventListener(JFrameEvent.ACTIVE, __frameActive);
		}
		
		override protected function addChildren():void
		{
			_pane = new JPanel();
			this.addRawChild(_pane);
			
			_iconifiedBtn = new JPushButton("", __iconified);
			this.addRawChild(_iconifiedBtn);
			_maximizeBtn = new JPushButton("", __maximize);
			this.addRawChild(_maximizeBtn);
			_normalBtn = new JPushButton("", __normal);
			this.addRawChild(_normalBtn);
			_closeBtn = new JPushButton("", __closeBtn);
			this.addRawChild(_closeBtn);
			
			_iconifiedBtn.setSize(26, 27);
			_maximizeBtn.setSize(25, 27);
			_normalBtn.setSize(25, 27);
			_closeBtn.setSize(43, 27);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		}
		
		/**
		 * Overridden to add new child to content.
		 */
		public override function addChild(child:DisplayObject):DisplayObject
		{
			_pane.addChild(child);
			return child;
		}
		
		/**
		 * Access to super.addChild
		 */
		public function addRawChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			return child;
		}
		
		override public function draw():void
		{
			super.draw();
			
			_pane.setSize(_width, _height);
			/////////
			var sizeStat:String = sizeMode;
			_iconifiedBtn.disabled = sizeStat == SIZE_ICONIFIED;
			_maximizeBtn.disabled = sizeStat == SIZE_MAXIMIZE;
			if(sizeStat == SIZE_ICONIFIED)
			{
				_normalBtn.visible = true;
				_maximizeBtn.visible = false;
			}
			else if(sizeStat == SIZE_MAXIMIZE)
			{
				_normalBtn.visible = true;
				_maximizeBtn.visible = false;
			}
			else
			{
				_normalBtn.visible = false;
				_maximizeBtn.visible = true;
			}
			/////////
			_closeBtn.x = _width - _frameBtnsMargin.x - _closeBtn.width;
			_closeBtn.y = _frameBtnsMargin.y;
			_maximizeBtn.x = _width - _frameBtnsMargin.x - _closeBtn.width - _maximizeBtn.width;
			_maximizeBtn.y = _frameBtnsMargin.y;
			_normalBtn.x = _width - _frameBtnsMargin.x - _closeBtn.width - _normalBtn.width;
			_normalBtn.y = _frameBtnsMargin.y;
			var middleBtnWidth:int = 0;
			if(sizeStat == SIZE_ICONIFIED)
			{
				middleBtnWidth = _normalBtn.width;
			}
			else if(sizeStat == SIZE_MAXIMIZE)
			{
				middleBtnWidth = _normalBtn.width;
			}
			else
			{
				middleBtnWidth = _maximizeBtn.width;
			}
			_iconifiedBtn.x = _width - _frameBtnsMargin.x - _closeBtn.width - middleBtnWidth - _iconifiedBtn.width;
			_iconifiedBtn.y = _frameBtnsMargin.y;
			/////////
			if(_needRepaintBg)
			{
				if(_active)
				{
					_pane.alpha = 1.0;
					if(_activeBgFiller)
					{
						_pane.fillBackground(_activeBgFiller);
					}
				}
				else
				{
					if(_inactiveBgFiller)
					{
						_pane.alpha = 1.0;
						_pane.fillBackground(_inactiveBgFiller);
					}
					else
					{
						_pane.alpha = 0.5;
					}
				}
				_needRepaintBg = false;
			}
		}
		
		/** 最小化 */
		protected function __iconified(e:MouseEvent):void
		{
			if(btnAvailable)
			{
				setSize(_iconifiedSize.width, _iconifiedSize.height);
			}
		}
		
		/** 最大化 */
		protected function __maximize(e:MouseEvent):void
		{
			if(btnAvailable)
			{
				setSize(_maximizeSize.width, _maximizeSize.height);
			}
		}
		
		/** 常规化 */
		protected function __normal(e:MouseEvent):void
		{
			if(btnAvailable)
			{
				setSize(_normalSize.width, _normalSize.height);
			}
		}
		
		/** 关闭面板 */
		protected function __closeBtn(e:MouseEvent):void
		{
			if(btnAvailable)
			{
				if(this.parent) { this.parent.removeChild(this); }
			}
		}
		
		/** __mouseDown */
		protected function __mouseDown(e:MouseEvent):void
		{
			if( !(e.target is JPushButton) )
			{
				this.startDrag();
			}
			
			if(this.parent)
			{
				this.parent.setChildIndex(this, (this.parent.numChildren - 1));
			}
			
			new JFrameEvent(JFrameEvent.ACTIVE, this).report();
		}
		
		/** __mouseUp */
		protected function __mouseUp(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		/** __frameActive */
		protected function __frameActive(e:JFrameEvent):void
		{
			if(e.frame == this)
			{
				active = true;
			}
			else
			{
				active = false;
			}
		}
		
	}
}