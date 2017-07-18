package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JFrame;
	import com.anstu.jui.define.JSize;
	import com.anstu.jui.define.JuiType;
	
	public class CsFrame extends CShell
	{
		private var frame:JFrame = new JFrame();
		override public function getUI():JComponent { return frame; }
		
		public function inject(ui:JComponent):void
		{
			this.frame = ui as JFrame;
		}
		
		//active
		public function set active(value:String):void
		{
			frame.active = value=="true";
		}
		public function get active():String { return frame.active?"true":"false"; }
		
		//frameBtnsMarginX
		public function set frameBtnsMarginX(value:String):void
		{
			frame.frameBtnsMarginX = BU.S2PI(value);
		}
		public function get frameBtnsMarginX():String { return frame.frameBtnsMarginX.toString(); }
		
		//frameBtnsMarginY
		public function set frameBtnsMarginY(value:String):void
		{
			frame.frameBtnsMarginY = BU.S2PI(value);
		}
		public function get frameBtnsMarginY():String { return frame.frameBtnsMarginY.toString(); }
		
		//activeBgFill
		private var _activeBgFill:String;
		public function set activeBgFill(value:String):void
		{
			if(_activeBgFill == value) { return; }
			_activeBgFill = value;
			fill(frame.fillActiveBg, value);
		}
		public function get activeBgFill():String
		{
			return _activeBgFill;
		}
		
		//inactiveBgFill
		private var _inactiveBgFill:String;
		public function set inactiveBgFill(value:String):void
		{
			if(_inactiveBgFill == value) { return; }
			_inactiveBgFill = value;
			fill(frame.fillInactiveBg, value);
		}
		public function get inactiveBgFill():String
		{
			return _inactiveBgFill;
		}
		
		//iconifiedBtn_width
		public function set iconifiedBtn_width(value:String):void
		{
			frame.iconifiedBtn.width = BU.S2PI(value);
		}
		public function get iconifiedBtn_width():String
		{
			return frame.iconifiedBtn.width.toString();
		}
		
		//iconifiedBtn_height
		public function set iconifiedBtn_height(value:String):void
		{
			frame.iconifiedBtn.height = BU.S2PI(value);
		}
		public function get iconifiedBtn_height():String
		{
			return frame.iconifiedBtn.height.toString();
		}
		
		//iconifiedBtn_defaultFill
		private var _iconifiedBtn_defaultFill:String;
		public function set iconifiedBtn_defaultFill(value:String):void
		{
			if(_iconifiedBtn_defaultFill == value) { return; }
			_iconifiedBtn_defaultFill = value;
			fill(frame.iconifiedBtn.fillDefaultBg, value);
		}
		public function get iconifiedBtn_defaultFill():String
		{
			return _iconifiedBtn_defaultFill;
		}
		
		//iconifiedBtn_overFill
		private var _iconifiedBtn_overFill:String;
		public function set iconifiedBtn_overFill(value:String):void
		{
			if(_iconifiedBtn_overFill == value) { return; }
			_iconifiedBtn_overFill = value;
			fill(frame.iconifiedBtn.fillOverBg, value);
		}
		public function get iconifiedBtn_overFill():String
		{
			return _iconifiedBtn_overFill;
		}
		
		//iconifiedBtn_downFill
		private var _iconifiedBtn_downFill:String;
		public function set iconifiedBtn_downFill(value:String):void
		{
			if(_iconifiedBtn_downFill == value) { return; }
			_iconifiedBtn_downFill = value;
			fill(frame.iconifiedBtn.fillDownBg, value);
		}
		public function get iconifiedBtn_downFill():String
		{
			return _iconifiedBtn_downFill;
		}
		
		//iconifiedBtn_disabledFill
		private var _iconifiedBtn_disabledFill:String;
		public function set iconifiedBtn_disabledFill(value:String):void
		{
			if(_iconifiedBtn_disabledFill == value) { return; }
			_iconifiedBtn_disabledFill = value;
			fill(frame.iconifiedBtn.fillDisabledBg, value);
		}
		public function get iconifiedBtn_disabledFill():String
		{
			return _iconifiedBtn_disabledFill;
		}
		
		//iconifiedBtn_faceFill
		private var _iconifiedBtn_faceFill:String;
		public function set iconifiedBtn_faceFill(value:String):void
		{
			if(_iconifiedBtn_faceFill == value) { return; }
			_iconifiedBtn_faceFill = value;
			fill(frame.iconifiedBtn.fillFace, value);
		}
		public function get iconifiedBtn_faceFill():String
		{
			return _iconifiedBtn_faceFill;
		}
		
		//maximizeBtn_width
		public function set maximizeBtn_width(value:String):void
		{
			frame.maximizeBtn.width = BU.S2PI(value);
		}
		public function get maximizeBtn_width():String
		{
			return frame.maximizeBtn.width.toString();
		}
		
		//maximizeBtn_height
		public function set maximizeBtn_height(value:String):void
		{
			frame.maximizeBtn.height = BU.S2PI(value);
		}
		public function get maximizeBtn_height():String
		{
			return frame.maximizeBtn.height.toString();
		}
		
		//maximizeBtn_defaultFill
		private var _maximizeBtn_defaultFill:String;
		public function set maximizeBtn_defaultFill(value:String):void
		{
			if(_maximizeBtn_defaultFill == value) { return; }
			_maximizeBtn_defaultFill = value;
			fill(frame.maximizeBtn.fillDefaultBg, value);
		}
		public function get maximizeBtn_defaultFill():String
		{
			return _maximizeBtn_defaultFill;
		}
		
		//maximizeBtn_overFill
		private var _maximizeBtn_overFill:String;
		public function set maximizeBtn_overFill(value:String):void
		{
			if(_maximizeBtn_overFill == value) { return; }
			_maximizeBtn_overFill = value;
			fill(frame.maximizeBtn.fillOverBg, value);
		}
		public function get maximizeBtn_overFill():String
		{
			return _maximizeBtn_overFill;
		}
		
		//maximizeBtn_downFill
		private var _maximizeBtn_downFill:String;
		public function set maximizeBtn_downFill(value:String):void
		{
			if(_maximizeBtn_downFill == value) { return; }
			_maximizeBtn_downFill = value;
			fill(frame.maximizeBtn.fillDownBg, value);
		}
		public function get maximizeBtn_downFill():String
		{
			return _maximizeBtn_downFill;
		}
		
		//maximizeBtn_disabledFill
		private var _maximizeBtn_disabledFill:String;
		public function set maximizeBtn_disabledFill(value:String):void
		{
			if(_maximizeBtn_disabledFill == value) { return; }
			_maximizeBtn_disabledFill = value;
			fill(frame.maximizeBtn.fillDisabledBg, value);
		}
		public function get maximizeBtn_disabledFill():String
		{
			return _maximizeBtn_disabledFill;
		}
		
		//maximizeBtn_faceFill
		private var _maximizeBtn_faceFill:String;
		public function set maximizeBtn_faceFill(value:String):void
		{
			if(_maximizeBtn_faceFill == value) { return; }
			_maximizeBtn_faceFill = value;
			fill(frame.maximizeBtn.fillFace, value);
		}
		public function get maximizeBtn_faceFill():String
		{
			return _maximizeBtn_faceFill;
		}
		
		//normalBtn_width
		public function set normalBtn_width(value:String):void
		{
			frame.normalBtn.width = BU.S2PI(value);
		}
		public function get normalBtn_width():String
		{
			return frame.normalBtn.width.toString();
		}
		
		//normalBtn_height
		public function set normalBtn_height(value:String):void
		{
			frame.normalBtn.height = BU.S2PI(value);
		}
		public function get normalBtn_height():String
		{
			return frame.normalBtn.height.toString();
		}
		
		//normalBtn_defaultFill
		private var _normalBtn_defaultFill:String;
		public function set normalBtn_defaultFill(value:String):void
		{
			if(_normalBtn_defaultFill == value) { return; }
			_normalBtn_defaultFill = value;
			fill(frame.normalBtn.fillDefaultBg, value);
		}
		public function get normalBtn_defaultFill():String
		{
			return _normalBtn_defaultFill;
		}
		
		//normalBtn_overFill
		private var _normalBtn_overFill:String;
		public function set normalBtn_overFill(value:String):void
		{
			if(_normalBtn_overFill == value) { return; }
			_normalBtn_overFill = value;
			fill(frame.normalBtn.fillOverBg, value);
		}
		public function get normalBtn_overFill():String
		{
			return _normalBtn_overFill;
		}
		
		//normalBtn_downFill
		private var _normalBtn_downFill:String;
		public function set normalBtn_downFill(value:String):void
		{
			if(_normalBtn_downFill == value) { return; }
			_normalBtn_downFill = value;
			fill(frame.normalBtn.fillDownBg, value);
		}
		public function get normalBtn_downFill():String
		{
			return _normalBtn_downFill;
		}
		
		//normalBtn_disabledFill
		private var _normalBtn_disabledFill:String;
		public function set normalBtn_disabledFill(value:String):void
		{
			if(_normalBtn_disabledFill == value) { return; }
			_normalBtn_disabledFill = value;
			fill(frame.normalBtn.fillDisabledBg, value);
		}
		public function get normalBtn_disabledFill():String
		{
			return _normalBtn_disabledFill;
		}
		
		//normalBtn_faceFill
		private var _normalBtn_faceFill:String;
		public function set normalBtn_faceFill(value:String):void
		{
			if(_normalBtn_faceFill == value) { return; }
			_normalBtn_faceFill = value;
			fill(frame.normalBtn.fillFace, value);
		}
		public function get normalBtn_faceFill():String
		{
			return _normalBtn_faceFill;
		}
		
		//closeBtn_width
		public function set closeBtn_width(value:String):void
		{
			frame.closeBtn.width = BU.S2PI(value);
		}
		public function get closeBtn_width():String
		{
			return frame.closeBtn.width.toString();
		}
		
		//closeBtn_height
		public function set closeBtn_height(value:String):void
		{
			frame.closeBtn.height = BU.S2PI(value);
		}
		public function get closeBtn_height():String
		{
			return frame.closeBtn.height.toString();
		}
		
		//closeBtn_defaultFill
		private var _closeBtn_defaultFill:String;
		public function set closeBtn_defaultFill(value:String):void
		{
			if(_closeBtn_defaultFill == value) { return; }
			_closeBtn_defaultFill = value;
			fill(frame.closeBtn.fillDefaultBg, value);
		}
		public function get closeBtn_defaultFill():String
		{
			return _closeBtn_defaultFill;
		}
		
		//closeBtn_overFill
		private var _closeBtn_overFill:String;
		public function set closeBtn_overFill(value:String):void
		{
			if(_closeBtn_overFill == value) { return; }
			_closeBtn_overFill = value;
			fill(frame.closeBtn.fillOverBg, value);
		}
		public function get closeBtn_overFill():String
		{
			return _closeBtn_overFill;
		}
		
		//closeBtn_downFill
		private var _closeBtn_downFill:String;
		public function set closeBtn_downFill(value:String):void
		{
			if(_closeBtn_downFill == value) { return; }
			_closeBtn_downFill = value;
			fill(frame.closeBtn.fillDownBg, value);
		}
		public function get closeBtn_downFill():String
		{
			return _closeBtn_downFill;
		}
		
		//closeBtn_disabledFill
		private var _closeBtn_disabledFill:String;
		public function set closeBtn_disabledFill(value:String):void
		{
			if(_closeBtn_disabledFill == value) { return; }
			_closeBtn_disabledFill = value;
			fill(frame.closeBtn.fillDisabledBg, value);
		}
		public function get closeBtn_disabledFill():String
		{
			return _closeBtn_disabledFill;
		}
		
		//closeBtn_faceFill
		private var _closeBtn_faceFill:String;
		public function set closeBtn_faceFill(value:String):void
		{
			if(_closeBtn_faceFill == value) { return; }
			_closeBtn_faceFill = value;
			fill(frame.closeBtn.fillFace, value);
		}
		public function get closeBtn_faceFill():String
		{
			return _closeBtn_faceFill;
		}
		
		public function CsFrame()
		{
			super();
			frame.btnAvailable = false;
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override public function getAttris():Array
		{
			return ["active", "activeBgFill", "inactiveBgFill", "frameBtnsMarginX", "frameBtnsMarginY",
				"iconifiedBtn_width", "iconifiedBtn_height", "iconifiedBtn_defaultFill", "iconifiedBtn_overFill",
				"iconifiedBtn_downFill", "iconifiedBtn_disabledFill", "iconifiedBtn_faceFill", 
				"maximizeBtn_width", "maximizeBtn_height", "maximizeBtn_defaultFill", "maximizeBtn_overFill",
				"maximizeBtn_downFill", "maximizeBtn_disabledFill", "maximizeBtn_faceFill", 
				"normalBtn_width", "normalBtn_height", "normalBtn_defaultFill", "normalBtn_overFill",
				"normalBtn_downFill", "normalBtn_disabledFill", "normalBtn_faceFill", 
				"closeBtn_width", "closeBtn_height", "closeBtn_defaultFill", "closeBtn_overFill",
				"closeBtn_downFill", "closeBtn_disabledFill", "closeBtn_faceFill", ];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			attriStr += " active='" + this.active + "'";
			attriStr += " frameBtnsMarginX='" + this.frameBtnsMarginX + "'";
			attriStr += " frameBtnsMarginY='" + this.frameBtnsMarginY + "'";
			attriStr += " activeBgFill='" + this.activeBgFill + "'";
			attriStr += " inactiveBgFill='" + this.inactiveBgFill + "'";
			
			attriStr += " iconifiedBtn_width='" + this.iconifiedBtn_width + "'";
			attriStr += " iconifiedBtn_height='" + this.iconifiedBtn_height + "'";
			attriStr += " iconifiedBtn_defaultFill='" + this.iconifiedBtn_defaultFill + "'";
			attriStr += " iconifiedBtn_overFill='" + this.iconifiedBtn_overFill + "'";
			attriStr += " iconifiedBtn_downFill='" + this.iconifiedBtn_downFill + "'";
			attriStr += " iconifiedBtn_disabledFill='" + this.iconifiedBtn_disabledFill + "'";
			attriStr += " iconifiedBtn_faceFill='" + this.iconifiedBtn_faceFill + "'";
			
			attriStr += " maximizeBtn_width='" + this.maximizeBtn_width + "'";
			attriStr += " maximizeBtn_height='" + this.maximizeBtn_height + "'";
			attriStr += " maximizeBtn_defaultFill='" + this.maximizeBtn_defaultFill + "'";
			attriStr += " maximizeBtn_overFill='" + this.maximizeBtn_overFill + "'";
			attriStr += " maximizeBtn_downFill='" + this.maximizeBtn_downFill + "'";
			attriStr += " maximizeBtn_disabledFill='" + this.maximizeBtn_disabledFill + "'";
			attriStr += " maximizeBtn_faceFill='" + this.maximizeBtn_faceFill + "'";
			
			attriStr += " normalBtn_width='" + this.normalBtn_width + "'";
			attriStr += " normalBtn_height='" + this.normalBtn_height + "'";
			attriStr += " normalBtn_defaultFill='" + this.normalBtn_defaultFill + "'";
			attriStr += " normalBtn_overFill='" + this.normalBtn_overFill + "'";
			attriStr += " normalBtn_downFill='" + this.normalBtn_downFill + "'";
			attriStr += " normalBtn_disabledFill='" + this.normalBtn_disabledFill + "'";
			attriStr += " normalBtn_faceFill='" + this.normalBtn_faceFill + "'";
			
			attriStr += " closeBtn_width='" + this.closeBtn_width + "'";
			attriStr += " closeBtn_height='" + this.closeBtn_height + "'";
			attriStr += " closeBtn_defaultFill='" + this.closeBtn_defaultFill + "'";
			attriStr += " closeBtn_overFill='" + this.closeBtn_overFill + "'";
			attriStr += " closeBtn_downFill='" + this.closeBtn_downFill + "'";
			attriStr += " closeBtn_disabledFill='" + this.closeBtn_disabledFill + "'";
			attriStr += " closeBtn_faceFill='" + this.closeBtn_faceFill + "'";
			
			return "<"+JuiType.JFrame+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JFrame+">";
		}
		
	}
}