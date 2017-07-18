package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class CsSlider extends CShell
	{
		private var slider:JSlider;
		override public function getUI():JComponent { return slider; }
		
		public function inject(ui:JComponent):void
		{
			this.slider = ui as JSlider;
		}
		
		private var orientation:String;
		
		//bgFill
		private var _bgFill:String;
		public function set bgFill(value:String):void
		{
			if(_bgFill == value) { return; }
			_bgFill = value;
			fill(slider.fillBackground, value);
		}
		public function get bgFill():String { return _bgFill; }
		
		//handleFat
		public function set handleFat(value:String):void
		{
			slider.handleFat = BU.S2PI(value);
		}
		public function get handleFat():String
		{
			return slider.handleFat.toString();
		}
		
		//handle_defaultFill
		private var _handle_defaultFill:String;
		public function set handle_defaultFill(value:String):void
		{
			if(_handle_defaultFill == value) { return; }
			_handle_defaultFill = value;
			fill(slider.handle.fillDefaultBg, value);
		}
		public function get handle_defaultFill():String { return _handle_defaultFill; }
		
		//handle_overFill
		private var _handle_overFill:String;
		public function set handle_overFill(value:String):void
		{
			if(_handle_overFill == value) { return; }
			_handle_overFill = value;
			fill(slider.handle.fillOverBg, value);
		}
		public function get handle_overFill():String { return _handle_overFill; }
		
		//handle_downFill
		private var _handle_downFill:String;
		public function set handle_downFill(value:String):void
		{
			if(_handle_downFill == value) { return; }
			_handle_downFill = value;
			fill(slider.handle.fillDownBg, value);
		}
		public function get handle_downFill():String { return _handle_downFill; }
		
		//handle_disabledFill
		private var _handle_disabledFill:String;
		public function set handle_disabledFill(value:String):void
		{
			if(_handle_disabledFill == value) { return; }
			_handle_disabledFill = value;
			fill(slider.handle.fillDisabledBg, value);
		}
		public function get handle_disabledFill():String { return _handle_disabledFill; }
		
		//handle_faceFill
		private var _handle_faceFill:String;
		public function set handle_faceFill(value:String):void
		{
			if(_handle_faceFill == value) { return; }
			_handle_faceFill = value;
			fill(slider.handle.fillFace, value);
		}
		public function get handle_faceFill():String { return _handle_faceFill; }
		
		public function CsSlider(orientation:String)
		{
			this.orientation = orientation;
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override protected function initialize():void
		{
			super.initialize();
			slider = new JSlider(this.orientation);
		}
		
		override public function getAttris():Array
		{
			return ["bgFill", "handleFat", "handle_defaultFill", "handle_overFill",
			"handle_downFill", "handle_disabledFill", "handle_faceFill"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " bgFill='" + this.bgFill + "'";
			attriStr += " handleFat='" + this.handleFat + "'";
			attriStr += " handle_defaultFill='" + this.handle_defaultFill + "'";
			attriStr += " handle_overFill='" + this.handle_overFill + "'";
			attriStr += " handle_downFill='" + this.handle_downFill + "'";
			attriStr += " handle_disabledFill='" + this.handle_disabledFill + "'";
			attriStr += " handle_faceFill='" + this.handle_faceFill + "'";
			var nodeName:String = this.orientation == JuiConst.HORIZONTAL ? JuiType.JSliderH : JuiType.JSliderV;
			return "<"+nodeName+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			var nodeName:String = this.orientation == JuiConst.HORIZONTAL ? JuiType.JSliderH : JuiType.JSliderV;
			return "</"+nodeName+">";
		}
	}
}