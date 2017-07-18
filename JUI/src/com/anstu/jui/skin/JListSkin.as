package com.anstu.jui.skin
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.components.JStyle;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JList;

	public class JListSkin
	{
		public var base_ns:String = "default";
		
		public var panel_bg_cls:String = null;
		public var panel_bgAlpha:Number = 0;
		
		public var item_defaultColor:uint = JStyle.LIST_DEFAULT;
		public var item_alternateColor:uint = JStyle.LIST_ALTERNATE;
		public var item_rolloverColor:uint = JStyle.LIST_ROLLOVER;
		public var item_selectedColor:uint = JStyle.LIST_SELECTED;
		
		public var item_textFormat:JTextFormat = new JTextFormat(null, 14, 0xd1c692);
		
		public var listItemHeight:int = 20;
		public var itemBgAlpha:Number = 0.8;
		public var alternateRows:Boolean = true;
		
		public var scrollBarSkin:JScrollBarSkin = new JScrollBarSkin();
		
		public function JListSkin()
		{
		}
		
		public function apply(list:JList):void
		{
			scrollBarSkin.apply(list.scrollBar);
			
			list.defaultColor = item_defaultColor;
			list.alternateColor = item_alternateColor;
			list.rolloverColor = item_rolloverColor;
			list.selectedColor = item_selectedColor;
			
			if(item_textFormat)
			{
				list.textFormat = item_textFormat;
			}
			if(listItemHeight > 0) { list.listItemHeight = listItemHeight; }
			list.itemBgAlpha = itemBgAlpha;
			list.alternateRows = alternateRows;
			
			if(panel_bgAlpha)
			{
				list.panel.fillBackground( JResource.getBmp(panel_bg_cls, base_ns) );
			}
			list.panel.bgAlpha = 0;
		}
		
	}
}