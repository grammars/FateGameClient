package com.anstu.jui.controls
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JStyle;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="change", type="flash.events.Event.CHANGE")]
	public class JCheckBox extends JComponent
	{
		protected var _unselectedBtn:JPushButton;
		public function get unselectedBtn():JPushButton { return _unselectedBtn; }
		protected var _selectedBtn:JPushButton;
		public function get selectedBtn():JPushButton { return _selectedBtn; }
		
		protected var _selected:Boolean = false;
		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				invalidate();
				this.dispatchEvent(new Event(Event.CHANGE));
			}
		}
		public function get selected():Boolean { return _selected; }
		
		protected var _disabled:Boolean = false;
		/** 是否不可用状态 */
		public function set disabled(value:Boolean):void
		{
			if(_disabled != value)
			{
				_disabled = value;
				_unselectedBtn.disabled = value;
				_selectedBtn.disabled = value;
			}
		}
		public function get disabled():Boolean { return _disabled; }
		
		protected var _unselectedLabel:String = "";
		/** 未选择状态的标签 */
		public function set unselectedLabel(value:String):void
		{
			_unselectedLabel = value;
			_unselectedBtn.caption = value;
		}
		public function get unselectedLabel():String
		{
			return _unselectedLabel;
		}
		
		protected var _selectedLabel:String = "";
		/** 选择状态的标签 */
		public function set selectedLabel(value:String):void
		{
			_selectedLabel = value;
			_selectedBtn.caption = value;
		}
		public function get selectedLabel():String
		{
			return _selectedLabel;
		}
		
		public function JCheckBox(unselectedLabel:String="", selectedLabel:String="")
		{
			super();
			this._type = JuiType.JCheckBox;
			this.unselectedLabel = unselectedLabel;
			this.selectedLabel = selectedLabel;
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
			setSize(30, 30);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_unselectedBtn = new JPushButton("", __mouseClick);
			_unselectedBtn.style_default_line = JStyle.CHECK_UNSELECTED_DEFAULT_LINE;
			_unselectedBtn.style_default_fill = JStyle.CHECK_UNSELECTED_DEFAULT_FILL;
			_unselectedBtn.style_over_line = JStyle.CHECK_UNSELECTED_OVER_LINE;
			_unselectedBtn.style_over_fill = JStyle.CHECK_UNSELECTED_OVER_FILL;
			_unselectedBtn.style_down_line = JStyle.CHECK_UNSELECTED_DOWN_LINE;
			_unselectedBtn.style_down_fill = JStyle.CHECK_UNSELECTED_DOWN_FILL;
			_unselectedBtn.style_disabled_line = JStyle.CHECK_UNSELECTED_DISABLED_LINE;
			_unselectedBtn.style_disabled_fill = JStyle.CHECK_UNSELECTED_DISABLED_FILL;
			
			_selectedBtn = new JPushButton("", __mouseClick);
			_selectedBtn.style_default_line = JStyle.CHECK_SELECTED_DEFAULT_LINE;
			_selectedBtn.style_default_fill = JStyle.CHECK_SELECTED_DEFAULT_FILL;
			_selectedBtn.style_over_line = JStyle.CHECK_SELECTED_OVER_LINE;
			_selectedBtn.style_over_fill = JStyle.CHECK_SELECTED_OVER_FILL;
			_selectedBtn.style_down_line = JStyle.CHECK_SELECTED_DOWN_LINE;
			_selectedBtn.style_down_fill = JStyle.CHECK_SELECTED_DOWN_FILL;
			_selectedBtn.style_disabled_line = JStyle.CHECK_SELECTED_DISABLED_LINE;
			_selectedBtn.style_disabled_fill = JStyle.CHECK_SELECTED_DISABLED_FILL;
		}
		
		protected function __mouseClick(e:MouseEvent):void
		{
			selected = !_selected;
			invalidate();
		}
		
		override public function draw():void
		{
			super.draw();
			
			if(_selected)
			{
				_selectedBtn.setSize(_width, _height);
				_selectedBtn.draw();
				if(_unselectedBtn.parent) { _unselectedBtn.parent.removeChild(_unselectedBtn); }
				this.addChild(_selectedBtn);
			}
			else
			{
				_unselectedBtn.setSize(_width, _height);
				_unselectedBtn.draw();
				if(_selectedBtn.parent) { _selectedBtn.parent.removeChild(_selectedBtn); }
				this.addChild(_unselectedBtn);
			}
		}
		
	}
}