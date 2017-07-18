package com.anstu.jui.controls
{
	import com.anstu.jui.components.ICaption;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JStyle;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class JListItem extends JComponent
	{
		protected var _label:JLabel;
		public function get label():JLabel { return _label; }
		
		protected var _data:ICaption;
		/** 关联数据 */
		public function set data(value:ICaption):void
		{
			_data = value;
			invalidate();
		}
		public function get data():ICaption { return _data; }
		
		protected var _selected:Boolean;
		/** 是否被选中 */
		public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidate();
		}
		public function get selected():Boolean { return _selected; }
		
		/** 鼠标是否经过 */
		protected var _mouseOver:Boolean = false;
		
		protected var _defaultColor:uint = JStyle.LIST_DEFAULT;
		/** 默认背景颜色 */
		public function set defaultColor(value:uint):void
		{
			_defaultColor = value;
			invalidate();
		}
		public function get defaultColor():uint { return _defaultColor; }
		
		protected var _selectedColor:uint = JStyle.LIST_SELECTED;
		/** 被选择背景颜色 */
		public function set selectedColor(value:uint):void
		{
			_selectedColor = value;
			invalidate();
		}
		public function get selectedColor():uint { return _selectedColor; }
		
		protected var _rolloverColor:uint = JStyle.LIST_ROLLOVER;
		/** 鼠标经过背景颜色 */
		public function set rolloverColor(value:uint):void
		{
			_rolloverColor = value;
			invalidate();
		}
		public function get rolloverColor():uint { return _rolloverColor; }
		
		protected var _bgAlpha:Number = 0.8;
		/** 背景颜色的alpha */
		public function set bgAlpha(value:Number):void
		{
			_bgAlpha = value;
			invalidate();
		}
		public function get bgAlpha():Number { return _bgAlpha; }
		
		/** JListItem */
		public function JListItem(data:ICaption = null)
		{
			_data = data;
			super();
			this._type = JuiType.JListItem;
		}
		
		protected override function init() : void
		{
			super.init();
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			setSize(100, 20);
		}
		
		protected override function addChildren() : void
		{
			super.addChildren();
			_label = new JLabel();
			this.addChild(_label);
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			_label.setSize(w, h);
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			_label.width = w;
		}
		
		override public function set height(h:Number):void
		{
			super.height = h;
			_label.height = h;
		}
		
		public override function draw() : void
		{
			super.draw();
			graphics.clear();

			if(_selected)
			{
				graphics.beginFill(_selectedColor, _bgAlpha);
			}
			else if(_mouseOver)
			{
				graphics.beginFill(_rolloverColor, _bgAlpha);
			}
			else
			{
				graphics.beginFill(_defaultColor, _bgAlpha);
			}
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();

			if(_data != null)
			{
				_label.text = _data.caption;
			}
		}
		
		/**
		 * Called when the user rolls the mouse over the item. Changes the background color.
		 */
		protected function onMouseOver(event:MouseEvent):void
		{
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_mouseOver = true;
			invalidate();
		}
		
		/**
		 * Called when the user rolls the mouse off the item. Changes the background color.
		 */
		protected function onMouseOut(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_mouseOver = false;
			invalidate();
		}
		
	}
}