package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JListItem;
	import com.anstu.jui.define.JuiType;
	
	public class CsListItem extends CShell
	{
		private var listItem:JListItem = new JListItem();
		override public function getUI():JComponent { return listItem; }
		
		public function inject(ui:JComponent):void
		{
			this.listItem = ui as JListItem;
		}
		
		public function CsListItem()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
			listItem.label.text = "列表项";
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			return "<"+JuiType.JListItem+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JListItem+">";
		}
		
	}
}