package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JScrollSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class CsScrollSlider extends CShell
	{
		private var scrollSlider:JScrollSlider;
		override public function getUI():JComponent { return scrollSlider; }
		
		public function inject(ui:JComponent):void
		{
			this.scrollSlider = ui as JScrollSlider;
		}
		
		private var orientation:String;
		
		//bgFill
		private var _bgFill:String;
		public function set bgFill(value:String):void
		{
			if(_bgFill == value) { return; }
			_bgFill = value;
			fill(scrollSlider.fillBackground, value);
		}
		public function get bgFill():String { return _bgFill; }
		
		//handle_defaultFill
		private var _handle_defaultFill:String;
		public function set handle_defaultFill(value:String):void
		{
			if(_handle_defaultFill == value) { return; }
			_handle_defaultFill = value;
			fill(scrollSlider.handle.fillDefaultBg, value);
		}
		public function get handle_defaultFill():String { return _handle_defaultFill; }
		
		//handle_overFill
		private var _handle_overFill:String;
		public function set handle_overFill(value:String):void
		{
			if(_handle_overFill == value) { return; }
			_handle_overFill = value;
			fill(scrollSlider.handle.fillOverBg, value);
		}
		public function get handle_overFill():String { return _handle_overFill; }
		
		//handle_downFill
		private var _handle_downFill:String;
		public function set handle_downFill(value:String):void
		{
			if(_handle_downFill == value) { return; }
			_handle_downFill = value;
			fill(scrollSlider.handle.fillDownBg, value);
		}
		public function get handle_downFill():String { return _handle_downFill; }
		
		//handle_disabledFill
		private var _handle_disabledFill:String;
		public function set handle_disabledFill(value:String):void
		{
			if(_handle_disabledFill == value) { return; }
			_handle_disabledFill = value;
			fill(scrollSlider.handle.fillDisabledBg, value);
		}
		public function get handle_disabledFill():String { return _handle_disabledFill; }
		
		//handle_faceFill
		private var _handle_faceFill:String;
		public function set handle_faceFill(value:String):void
		{
			if(_handle_faceFill == value) { return; }
			_handle_faceFill = value;
			fill(scrollSlider.handle.fillFace, value);
		}
		public function get handle_faceFill():String { return _handle_faceFill; }
		
		public function CsScrollSlider(orientation:String)
		{
			this.orientation = orientation;
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override protected function initialize():void
		{
			super.initialize();
			scrollSlider = new JScrollSlider(this.orientation);
			scrollSlider.thumbPercent = 0.4;
		}
		
		override public function getAttris():Array
		{
			return ["bgFill", "handle_defaultFill", "handle_overFill",
				"handle_downFill", "handle_disabledFill", "handle_faceFill"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " bgFill='" + this.bgFill + "'";
			attriStr += " handle_defaultFill='" + this.handle_defaultFill + "'";
			attriStr += " handle_overFill='" + this.handle_overFill + "'";
			attriStr += " handle_downFill='" + this.handle_downFill + "'";
			attriStr += " handle_disabledFill='" + this.handle_disabledFill + "'";
			attriStr += " handle_faceFill='" + this.handle_faceFill + "'";
			var nodeName:String = this.orientation == JuiConst.HORIZONTAL ? JuiType.JScrollSliderH : JuiType.JScrollSliderV;
			return "<"+nodeName+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			var nodeName:String = this.orientation == JuiConst.HORIZONTAL ? JuiType.JScrollSliderH : JuiType.JScrollSliderV;
			return "</"+nodeName+">";
		}
	}
}