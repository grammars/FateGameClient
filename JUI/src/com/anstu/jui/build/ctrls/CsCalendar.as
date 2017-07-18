package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JCalendar;
	import com.anstu.jui.define.JSize;
	import com.anstu.jui.define.JuiType;
	
	public class CsCalendar extends CShell
	{
		private var calendar:JCalendar = new JCalendar();
		override public function getUI():JComponent { return calendar; }
		
		public function inject(ui:JComponent):void
		{
			this.calendar = ui as JCalendar;
		}
		
		public function CsCalendar()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = "";
			attriStr += " tag='" + this.getTag() + "'";
			attriStr += " x='" + this.getX() + "'";
			attriStr += " y='" + this.getY() + "'";
			return "<"+JuiType.JCalendar+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JCalendar+">";
		}
		
	}
}