package com.anstu.jui.components
{
	import com.anstu.jui.controls.JRadioButton;
	import com.anstu.jui.ns.jui_internal;

	public class JRadioGroup
	{
		public var name:String;
		
		protected var _buttons:Array = new Array();
		public function get buttons():Array { return _buttons; }
		
		protected var _selectedBtn:JRadioButton;
		public function get selectedBtn():JRadioButton { return _selectedBtn; }
		
		public function JRadioGroup(name:String="")
		{
			this.name = name;
		}
		
		/** 查询某个JRadioButton是否已经归属于该组之中 */
		public function exist(btn:JRadioButton):Boolean
		{
			for(var i:int = 0; i < _buttons.length; i++)
			{
				if(btn == _buttons[i])
				{
					return true;
				}
			}
			return false;
		}
		
		public function add(btn:JRadioButton):void
		{
			jui_internal::groupAddBtn(this, btn);
		}
		
		jui_internal static function groupAddBtn(g:JRadioGroup, b:JRadioButton):void
		{
			if(!g) { return; }
			if(b.group) { b.group.remove(b); }
			b.jui_internal::setGroup(g);
			if(!g.exist(b))
			{
				g.buttons.push(b);
			}
		}
		
		public function remove(btn:JRadioButton):void
		{
			btn.group = null;
			for(var i:int = 0; i < _buttons.length; i++)
			{
				if(btn == _buttons[i])
				{
					_buttons.splice(i, 1);
					if(_selectedBtn == btn)
					{
						_selectedBtn = null;
					}
					break;
				}
			}
		}
		
		public function select(btn:JRadioButton):void
		{
			for(var i:int = 0; i < _buttons.length; i++)
			{
				if(btn == _buttons[i])
				{
					btn.setSelected(true);
					_selectedBtn = btn;
				}
				else
				{
					(_buttons[i] as JRadioButton).setSelected(false);
				}
			}
		}
		
	}
}