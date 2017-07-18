package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JImage;
	import com.anstu.jui.define.JuiType;
	
	public class CsImage extends CShell
	{
		private var image:JImage = new JImage();
		override public function getUI():JComponent { return image; }
		
		public function inject(ui:JComponent):void
		{
			this.image = ui as JImage;
		}
		
		//bgAlpha
		public function set bgAlpha(value:String):void
		{
			image.bgAlpha = parseFloat(value);
		}
		public function get bgAlpha():String
		{
			return image.bgAlpha.toString();
		}
		
		//bgColor
		public function set bgColor(value:String):void
		{
			var color:int = parseInt(value, 16);
			color = color & 0xFFFFFF;
			image.bgColor = color;
		}
		public function get bgColor():String
		{
			return image.bgColor.toString(16);
		}
		
		//bgFill背景填充
		private var _bgFill:String;
		public function set bgFill(value:String):void
		{
			if(_bgFill == value) { return; }
			_bgFill = value;
			fill(image.fillBackground, _bgFill, _fillOpt);
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
			fill(image.fillBackground, _bgFill, _fillOpt);
		}
		public function get fillOpt():String
		{
			return _fillOpt;
		}
		
		public function CsImage()
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
			return "<"+JuiType.JImage+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JImage+">";
		}
		
	}
}