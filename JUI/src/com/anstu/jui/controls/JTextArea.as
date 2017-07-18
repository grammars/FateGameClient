package com.anstu.jui.controls
{
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class JTextArea extends JText
	{
		protected var _scrollbar:JScrollBar;
		public function get scrollbar():JScrollBar { return _scrollbar; }
		
		public function JTextArea(text:String="")
		{
			super(text);
			this._type = JuiType.JTextArea;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			_scrollbar = new JScrollBar(JuiConst.VERTICAL, onScrollbarScroll);
			this.addChild(_scrollbar);
			_tf.addEventListener(Event.SCROLL, onTextScroll);
			
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		/**
		 * Changes the thumb percent of the scrollbar based on how much text is shown in the text area.
		 */
		protected function updateScrollbar():void
		{
			var visibleLines:int = _tf.numLines - _tf.maxScrollV + 1;
			var percent:Number = visibleLines / _tf.numLines;
			_scrollbar.setSliderParams(1, _tf.maxScrollV, _tf.scrollV);
			_scrollbar.thumbPercent = percent;
			_scrollbar.step = 1;
		}
		
		override public function draw():void
		{
			super.draw();
			
			_tf.width = _width - _scrollbar.width - 4;
			_scrollbar.x = _width - _scrollbar.width;
			_scrollbar.height = _height;
			_scrollbar.draw();
			addEventListener(Event.ENTER_FRAME, onTextScrollDelay);
		}
		
		/**
		 * Waits one more frame before updating scroll bar.
		 * It seems that numLines and maxScrollV are not valid immediately after changing a TextField's size.
		 */
		protected function onTextScrollDelay(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onTextScrollDelay);
			updateScrollbar();
		}
		
		/**
		 * Called when the text in the text field is manually changed.
		 */
		protected override function onChange(event:Event):void
		{
			super.onChange(event);
			updateScrollbar();
		}
		
		/**
		 * Called when the scroll bar is moved. Scrolls text accordingly.
		 */
		protected function onScrollbarScroll(event:Event):void
		{
			_tf.scrollV = Math.round(_scrollbar.value);
		}
		
		/**
		 * Called when the text is scrolled manually. Updates the position of the scroll bar.
		 */
		protected function onTextScroll(event:Event):void
		{
			if(_scrollbar.value != _tf.scrollV)
			{
				_scrollbar.value = _tf.scrollV;
				updateScrollbar();
			}
		}
		
		/**
		 * Called when the mouse wheel is scrolled over the component.
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			_scrollbar.value -= event.delta;
			_tf.scrollV = Math.round(_scrollbar.value);
		}
		
		/**
		 * Sets/gets whether this component is enabled or not.
		 */
		public override function set enabled(value:Boolean):void
		{
			super.enabled = value;
			_tf.tabEnabled = value;
		}
		
		/**
		 * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
		 */
		public function set autoHideScrollBar(value:Boolean):void
		{
			_scrollbar.autoHide = value;
		}
		public function get autoHideScrollBar():Boolean
		{
			return _scrollbar.autoHide;
		}
		
	}
}