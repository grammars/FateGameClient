package com.anstu.jui.controls
{
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class JScrollPanel extends JPanel
	{
		/** mask for content */
		protected var _mask:Sprite;
		
		protected var _vScrollbar:JScrollBar;
		protected var _hScrollbar:JScrollBar;
		protected var _dragContent:Boolean = true;
		
		public function get vScrollbar():JScrollBar { return _vScrollbar; }
		public function get hScrollbar():JScrollBar { return _hScrollbar; }
		
		public function JScrollPanel()
		{
			super();
			this._type = JuiType.JScrollPanel;
		}
		
		/**
		 * Initializes this component.
		 */
		override protected function init():void
		{
			super.init();
			addEventListener(Event.RESIZE, onResize);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_background.addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
			_background.useHandCursor = true;
			_background.buttonMode = true;
			setSize(100, 100);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
			
			_mask = new Sprite();
			_mask.mouseEnabled = false;
			_background.addChild(_mask);
			content.graphics.clear();
			content.graphics.beginFill(0,0);
			content.graphics.drawRect(0,0,1,1);
			content.graphics.endFill();
			content.mask = _mask;
			
			_vScrollbar = new JScrollBar(JuiConst.VERTICAL, onScroll);
			_hScrollbar = new JScrollBar(JuiConst.HORIZONTAL, onScroll);
			addRawChild(_vScrollbar);
			addRawChild(_hScrollbar);
		}
		
		/**
		 * Overridden to add new child to content.
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			content.addChild(child);
			invalidate();
			return child;
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
			
			var vPercent:Number = _height / content.height;
			var hPercent:Number = _width / content.width; 
			
			_vScrollbar.x = width;
			_hScrollbar.y = height;
			
			_vScrollbar.height = height;
			_mask.height = height;
			_hScrollbar.width = width;
			_mask.width = width;
			
			_vScrollbar.thumbPercent = vPercent;
			_vScrollbar.maximum = Math.max(0, content.height - _height);
			_vScrollbar.step = _vScrollbar.maximum/10;
			
			_hScrollbar.thumbPercent = hPercent;
			_hScrollbar.maximum = Math.max(0, content.width - _width);
			_hScrollbar.step = _hScrollbar.maximum/10;
			
			content.x = Math.round(-_hScrollbar.value);
			content.y = Math.round(-_vScrollbar.value);
		}
		
		/**
		 * Updates the scrollbars when content is changed. Needs to be done manually.
		 */
		public function update():void
		{
			invalidate();
		}
		
		/**
		 * Called when either scroll bar is scrolled.
		 */
		protected function onScroll(event:Event):void
		{
			content.x = Math.round(-_hScrollbar.value);
			content.y = Math.round(-_vScrollbar.value);
		}
		
		protected function onResize(event:Event):void
		{
			invalidate();
		}
		
		protected function onMouseWheel(event:MouseEvent):void
		{
			var vRange:int = Math.min(0, _height - content.height);
			var deltY:int = -0.05 * event.delta * vRange;
			if(content.y + deltY < vRange)
			{
				content.y = vRange;
			}
			else if(content.y + deltY > 0)
			{
				content.y = 0;
			}
			else
			{
				content.y += deltY;
			}
			_vScrollbar.value = -content.y;
		}
		
		protected function onMouseGoDown(event:MouseEvent):void
		{
			//content.startDrag(false, new Rectangle(0, 0, Math.min(0, _width - content.width - _vScrollbar.width), Math.min(0, _height - content.height - _hScrollbar.height)));
			content.startDrag(false, new Rectangle(0, 0, Math.min(0, _width - content.width), Math.min(0, _height - content.height)));
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			_hScrollbar.value = -content.x;
			_vScrollbar.value = -content.y;
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			content.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		public function set dragContent(value:Boolean):void
		{
			_dragContent = value;
			if(_dragContent)
			{
				_background.addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
				_background.useHandCursor = true;
				_background.buttonMode = true;
			}
			else
			{
				_background.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
				_background.useHandCursor = false;
				_background.buttonMode = false;
			}
		}
		public function get dragContent():Boolean
		{
			return _dragContent;
		}
		
		/**
		 * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
		 */
		public function set autoHideScrollBar(value:Boolean):void
		{
			_vScrollbar.autoHide = value;
			_hScrollbar.autoHide = value;
		}
		public function get autoHideScrollBar():Boolean
		{
			return _vScrollbar.autoHide;
		}
		
	}
}