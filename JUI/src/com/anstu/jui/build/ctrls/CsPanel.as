package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.define.JSize;
	import com.anstu.jui.define.JuiType;
	
	public class CsPanel extends CShell
	{
		private var panel:JPanel = new JPanel();
		override public function getUI():JComponent { return panel; }
		
		public function inject(ui:JComponent):void
		{
			this.panel = ui as JPanel;
		}
		
		//bgAlpha
		public function set bgAlpha(value:String):void
		{
			panel.bgAlpha = parseFloat(value);
		}
		public function get bgAlpha():String
		{
			return panel.bgAlpha.toString();
		}
		
		//bgColor
		public function set bgColor(value:String):void
		{
			var color:int = parseInt(value, 16);
			color = color & 0xFFFFFF;
			panel.bgColor = color;
		}
		public function get bgColor():String
		{
			return panel.bgColor.toString(16);
		}
		
		//bgFill背景填充
		private var _bgFill:String;
		public function set bgFill(value:String):void
		{
			if(_bgFill == value) { return; }
			_bgFill = value;
			fill(panel.fillBackground, _bgFill, _fillOpt);
		}
		public function get bgFill():String
		{
			return _bgFill;
		}
		
		//fillOpt
		private var _fillOpt:String;
		public function set fillOpt(value:String):void
		{
			if(_fillOpt == value) { return; }
			_fillOpt = value;
			fill(panel.fillBackground, _bgFill, _fillOpt);
		}
		public function get fillOpt():String
		{
			return _fillOpt;
		}
		
		public function CsPanel()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override public function getAttris():Array
		{
			return ["bgAlpha", "bgColor", "fillOpt", "bgFill"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " bgAlpha='" + this.bgAlpha + "'";
			attriStr += " bgColor='" + this.bgColor + "'";
			attriStr += " fillOpt='" + this.fillOpt + "'";
			attriStr += " bgFill='" + this.bgFill + "'";
			return "<"+JuiType.JPanel+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JPanel+">";
		}
		
	}
}