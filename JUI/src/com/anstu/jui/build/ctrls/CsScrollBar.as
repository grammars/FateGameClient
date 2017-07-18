package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JScrollBar;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	
	public class CsScrollBar extends CShell
	{
		private var scrollBar:JScrollBar;
		override public function getUI():JComponent { return scrollBar; }
		
		public function inject(ui:JComponent):void
		{
			this.scrollBar = ui as JScrollBar;
		}
		
		private var orientation:String;
		
		//fatSize
		public function set fatSize(value:String):void
		{
			scrollBar.fatSize = BU.S2PI(value);
		}
		public function get fatSize():String { return scrollBar.fatSize.toString(); }
		
		//bgFill
		private var _bgFill:String;
		public function set bgFill(value:String):void
		{
			if(_bgFill == value) { return; }
			_bgFill = value;
			fill(scrollBar.scrollSlider.fillBackground, value);
		}
		public function get bgFill():String { return _bgFill; }
		
		//------------------handle----------------------------------
		
		//handle_defaultFill
		private var _handle_defaultFill:String;
		public function set handle_defaultFill(value:String):void
		{
			if(_handle_defaultFill == value) { return; }
			_handle_defaultFill = value;
			fill(scrollBar.scrollSlider.handle.fillDefaultBg, value);
		}
		public function get handle_defaultFill():String { return _handle_defaultFill; }
		
		//handle_overFill
		private var _handle_overFill:String;
		public function set handle_overFill(value:String):void
		{
			if(_handle_overFill == value) { return; }
			_handle_overFill = value;
			fill(scrollBar.scrollSlider.handle.fillOverBg, value);
		}
		public function get handle_overFill():String { return _handle_overFill; }
		
		//handle_downFill
		private var _handle_downFill:String;
		public function set handle_downFill(value:String):void
		{
			if(_handle_downFill == value) { return; }
			_handle_downFill = value;
			fill(scrollBar.scrollSlider.handle.fillDownBg, value);
		}
		public function get handle_downFill():String { return _handle_downFill; }
		
		//handle_disabledFill
		private var _handle_disabledFill:String;
		public function set handle_disabledFill(value:String):void
		{
			if(_handle_disabledFill == value) { return; }
			_handle_disabledFill = value;
			fill(scrollBar.scrollSlider.handle.fillDisabledBg, value);
		}
		public function get handle_disabledFill():String { return _handle_disabledFill; }
		
		//handle_faceFill
		private var _handle_faceFill:String;
		public function set handle_faceFill(value:String):void
		{
			if(_handle_faceFill == value) { return; }
			_handle_faceFill = value;
			fill(scrollBar.scrollSlider.handle.fillFace, value);
		}
		public function get handle_faceFill():String { return _handle_faceFill; }
		
		//------------------upButton----------------------------------
		
		//upBtn_width
		public function set upBtn_width(value:String):void
		{
			scrollBar.upButton.width = BU.S2PI(value);
		}
		public function get upBtn_width():String
		{
			return scrollBar.upButton.width.toString();
		}
		
		//upBtn_height
		public function set upBtn_height(value:String):void
		{
			scrollBar.upButton.height = BU.S2PI(value);
		}
		public function get upBtn_height():String
		{
			return scrollBar.upButton.height.toString();
		}
		
		//upBtn_defaultFill
		private var _upBtn_defaultFill:String;
		public function set upBtn_defaultFill(value:String):void
		{
			if(_upBtn_defaultFill == value) { return; }
			_upBtn_defaultFill = value;
			fill(scrollBar.upButton.fillDefaultBg, value);
		}
		public function get upBtn_defaultFill():String { return _upBtn_defaultFill; }
		
		//upBtn_overFill
		private var _upBtn_overFill:String;
		public function set upBtn_overFill(value:String):void
		{
			if(_upBtn_overFill == value) { return; }
			_upBtn_overFill = value;
			fill(scrollBar.upButton.fillOverBg, value);
		}
		public function get upBtn_overFill():String { return _upBtn_overFill; }
		
		//upBtn_downFill
		private var _upBtn_downFill:String;
		public function set upBtn_downFill(value:String):void
		{
			if(_upBtn_downFill == value) { return; }
			_upBtn_downFill = value;
			fill(scrollBar.upButton.fillDownBg, value);
		}
		public function get upBtn_downFill():String { return _upBtn_downFill; }
		
		//upBtn_disabledFill
		private var _upBtn_disabledFill:String;
		public function set upBtn_disabledFill(value:String):void
		{
			if(_upBtn_disabledFill == value) { return; }
			_upBtn_disabledFill = value;
			fill(scrollBar.upButton.fillDisabledBg, value);
		}
		public function get upBtn_disabledFill():String { return _upBtn_disabledFill; }
		
		//upBtn_faceFill
		private var _upBtn_faceFill:String;
		public function set upBtn_faceFill(value:String):void
		{
			if(_upBtn_faceFill == value) { return; }
			_upBtn_faceFill = value;
			fill(scrollBar.upButton.fillFace, value);
		}
		public function get upBtn_faceFill():String { return _upBtn_faceFill; }
		
		//------------------downButton----------------------------------
		
		//downBtn_width
		public function set downBtn_width(value:String):void
		{
			scrollBar.downButton.width = BU.S2PI(value);
		}
		public function get downBtn_width():String
		{
			return scrollBar.downButton.width.toString();
		}
		
		//downBtn_height
		public function set downBtn_height(value:String):void
		{
			scrollBar.downButton.height = BU.S2PI(value);
		}
		public function get downBtn_height():String
		{
			return scrollBar.downButton.height.toString();
		}
		
		//downBtn_defaultFill
		private var _downBtn_defaultFill:String;
		public function set downBtn_defaultFill(value:String):void
		{
			if(_downBtn_defaultFill == value) { return; }
			_downBtn_defaultFill = value;
			fill(scrollBar.downButton.fillDefaultBg, value);
		}
		public function get downBtn_defaultFill():String { return _downBtn_defaultFill; }
		
		//downBtn_overFill
		private var _downBtn_overFill:String;
		public function set downBtn_overFill(value:String):void
		{
			if(_downBtn_overFill == value) { return; }
			_downBtn_overFill = value;
			fill(scrollBar.downButton.fillOverBg, value);
		}
		public function get downBtn_overFill():String { return _downBtn_overFill; }
		
		//downBtn_downFill
		private var _downBtn_downFill:String;
		public function set downBtn_downFill(value:String):void
		{
			if(_downBtn_downFill == value) { return; }
			_downBtn_downFill = value;
			fill(scrollBar.downButton.fillDownBg, value);
		}
		public function get downBtn_downFill():String { return _downBtn_downFill; }
		
		//downBtn_disabledFill
		private var _downBtn_disabledFill:String;
		public function set downBtn_disabledFill(value:String):void
		{
			if(_downBtn_disabledFill == value) { return; }
			_downBtn_disabledFill = value;
			fill(scrollBar.downButton.fillDisabledBg, value);
		}
		public function get downBtn_disabledFill():String { return _downBtn_disabledFill; }
		
		//downBtn_faceFill
		private var _downBtn_faceFill:String;
		public function set downBtn_faceFill(value:String):void
		{
			if(_downBtn_faceFill == value) { return; }
			_downBtn_faceFill = value;
			fill(scrollBar.downButton.fillFace, value);
		}
		public function get downBtn_faceFill():String { return _downBtn_faceFill; }
		
		public function CsScrollBar(orientation:String)
		{
			this.orientation = orientation;
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override protected function initialize():void
		{
			super.initialize();
			scrollBar = new JScrollBar(this.orientation);
			scrollBar.thumbPercent = 0.4;
		}
		
		override public function getAttris():Array
		{
			return ["bgFill", "handle_defaultFill", "handle_overFill",
				"handle_downFill", "handle_disabledFill", "handle_faceFill",
			"upBtn_width", "upBtn_height", "upBtn_defaultFill", "upBtn_overFill", 
			"upBtn_downFill", "upBtn_disabledFill", "upBtn_faceFill", "downBtn_width",
			"downBtn_height", "downBtn_defaultFill", "downBtn_overFill", "downBtn_downFill",
			"downBtn_disabledFill", "downBtn_faceFill"];
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
			attriStr += " upBtn_width='" + this.upBtn_width + "'";
			attriStr += " upBtn_height='" + this.upBtn_height + "'";
			attriStr += " upBtn_defaultFill='" + this.upBtn_defaultFill + "'";
			attriStr += " upBtn_overFill='" + this.upBtn_overFill + "'";
			attriStr += " upBtn_downFill='" + this.upBtn_downFill + "'";
			attriStr += " upBtn_disabledFill='" + this.upBtn_disabledFill + "'";
			attriStr += " upBtn_faceFill='" + this.upBtn_faceFill + "'";
			attriStr += " downBtn_width='" + this.downBtn_width + "'";
			attriStr += " downBtn_height='" + this.downBtn_height + "'";
			attriStr += " downBtn_defaultFill='" + this.downBtn_defaultFill + "'";
			attriStr += " downBtn_overFill='" + this.downBtn_overFill + "'";
			attriStr += " downBtn_downFill='" + this.downBtn_downFill + "'";
			attriStr += " downBtn_disabledFill='" + this.downBtn_disabledFill + "'";
			attriStr += " downBtn_faceFill='" + this.downBtn_faceFill + "'";
			var nodeName:String = this.orientation == JuiConst.HORIZONTAL ? JuiType.JScrollBarH : JuiType.JScrollBarV;
			return "<"+nodeName+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			var nodeName:String = this.orientation == JuiConst.HORIZONTAL ? JuiType.JScrollBarH : JuiType.JScrollBarV;
			return "</"+nodeName+">";
		}
		
	}
}