package com.anstu.jui.controls
{
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.define.JuiType;
	import com.anstu.jui.ns.jui_internal;
	
	import flash.events.MouseEvent;
	import flash.utils.flash_proxy;

	public class JRadioButton extends JCheckBox
	{
		protected var _group:JRadioGroup;
		public function set group(value:JRadioGroup):void
		{
			JRadioGroup.jui_internal::groupAddBtn(value, this);
		}
		public function get group():JRadioGroup { return _group; }
		
		jui_internal function setGroup(value:JRadioGroup):void
		{
			_group = value;
		}
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			if(_selected) { if(_group) { _group.select(this); } }
		}
		
		public function setSelected(value:Boolean):void
		{
			super.selected = value;
		}
		
		public function JRadioButton(unselectedLabel:String="", selectedLabel:String="")
		{
			super(unselectedLabel, selectedLabel);
			this._type = JuiType.JRadioButton;
		}
		
		override protected function __mouseClick(e:MouseEvent):void
		{
			selected = true;
			invalidate();
		}
		
	}
}