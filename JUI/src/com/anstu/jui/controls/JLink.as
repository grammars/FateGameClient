package com.anstu.jui.controls
{
	import com.anstu.jui.define.JuiType;
	
	import flash.events.MouseEvent;

	public class JLink extends JLabel
	{
		protected var _htmlDefault:String = "";
		/** 默认html文本 */
		public function set htmlDefault(value:String):void
		{
			_htmlDefault = value;
			invalidate();
		}
		public function get htmlDefault():String { return _htmlDefault; }
		
		protected var _htmlOver:String = "";
		/** 鼠标经过html文本 */
		public function set htmlOver(value:String):void
		{
			_htmlOver = value;
			invalidate();
		}
		public function get htmlOver():String { return _htmlOver; }
		
		protected var _htmlPress:String = "";
		/** 鼠标按下html文本 */
		public function set htmlPress(value:String):void
		{
			_htmlPress = value;
			invalidate();
		}
		public function get htmlPress():String { return _htmlPress; }
		
		//------------------------------------------------------------------------
		
		protected var _colorDefault:uint = 0xd1c692;
		/** 默认文本颜色 */
		public function set colorDefault(value:uint):void
		{
			_colorDefault = value;
			this.textFormat.color = _colorDefault;
			invalidate();
		}
		public function get colorDefault():uint { return _colorDefault; }
		
		protected var _colorOver:uint = 0xfffacb;
		/** 鼠标经过文本颜色 */
		public function set colorOver(value:uint):void
		{
			_colorOver = value;
			invalidate();
		}
		public function get colorOver():uint { return _colorOver; }
		
		protected var _colorPress:uint = 0xf2fac0;
		/** 鼠标按下文本颜色 */
		public function set colorPress(value:uint):void
		{
			_colorPress = value;
			invalidate();
		}
		public function get colorPress():uint { return _colorPress; }
		
		//--------------------------------------------------------------------
		
		private static const DEFAULT:int = 0;
		private static const OVER:int = 1;
		private static const PRESS:int = 2;
		private var mouseState:int = DEFAULT;
		
		public function JLink(text:String="")
		{
			super(text);
			_htmlDefault = _htmlOver = _htmlPress = text;
			this._type = JuiType.JLink;
			this.addEventListener(MouseEvent.MOUSE_OVER, __mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, __mouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			mouseEnabled = true;
		}
		
		private function __mouseOver(e:MouseEvent):void
		{
			mouseState = OVER;
			handleMouseState();
		}
		
		private function __mouseOut(e:MouseEvent):void
		{
			mouseState = DEFAULT;
			handleMouseState();
		}
		
		private function __mouseDown(e:MouseEvent):void
		{
			mouseState = PRESS;
			handleMouseState();
		}
		
		private function __mouseUp(e:MouseEvent):void
		{
			mouseState = DEFAULT;
			handleMouseState();
		}
		
		private function handleMouseState():void
		{
			if(this.useHtml)
			{
				switch(mouseState)
				{
				case DEFAULT:
					this.text = _htmlDefault;
					break;
				case OVER:
					this.text = _htmlOver;
					break;
				case PRESS:
					this.text = _htmlPress;
					break;
				}
			}
			else
			{
				switch(mouseState)
				{
				case DEFAULT:
					this.textFormat.color = _colorDefault;
					break;
				case OVER:
					this.textFormat.color = _colorOver;
					break;
				case PRESS:
					this.textFormat.color = _colorPress;
					break;
				}
			}
		}
		
	}
}