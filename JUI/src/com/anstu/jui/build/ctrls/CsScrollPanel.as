package com.anstu.jui.build.ctrls
{
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.define.JuiType;
	
	public class CsScrollPanel extends CShell
	{
		private var scrollPanel:JScrollPanel = new JScrollPanel();
		override public function getUI():JComponent { return scrollPanel; }
		
		public function inject(ui:JComponent):void
		{
			this.scrollPanel = ui as JScrollPanel;
		}
		
		//bgAlpha
		public function set bgAlpha(value:String):void
		{
			scrollPanel.bgAlpha = parseFloat(value);
		}
		public function get bgAlpha():String
		{
			return scrollPanel.bgAlpha.toString();
		}
		
		//bgColor
		public function set bgColor(value:String):void
		{
			var color:int = parseInt(value, 16);
			color = color & 0xFFFFFF;
			scrollPanel.bgColor = color;
		}
		public function get bgColor():String
		{
			return scrollPanel.bgColor.toString(16);
		}
		
		//bgFill背景填充
		private var _bgFill:String;
		public function set bgFill(value:String):void
		{
			if(_bgFill == value) { return; }
			_bgFill = value;
			fill(scrollPanel.fillBackground, value);
		}
		public function get bgFill():String{ return _bgFill; }
		
		//tpl_scrollBarH
		private var _tpl_scrollBarH:String;
		public function set tpl_scrollBarH(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(scrollPanel.hScrollbar);	
				_tpl_scrollBarH = value;
			}
			else
			{
				_tpl_scrollBarH = null;
			}
		}
		public function get tpl_scrollBarH():String { return _tpl_scrollBarH; }
		
		//tpl_scrollBarV
		private var _tpl_scrollBarV:String;
		public function set tpl_scrollBarV(value:String):void
		{
			var info:TemplateInfo = TemplatesCache.getInfo(value);
			if(info)
			{
				info.apply(scrollPanel.vScrollbar);	
				_tpl_scrollBarV = value;
			}
			else
			{
				_tpl_scrollBarV = null;
			}
		}
		public function get tpl_scrollBarV():String { return _tpl_scrollBarV; }
		
		
		public function CsScrollPanel()
		{
			super();
			setWidth(getUI().width.toString());
			setHeight(getUI().height.toString());
		}
		
		override public function getAttris():Array
		{
			return ["bgAlpha", "bgColor", "bgFill"];
		}
		
		override public function getTpls():Array
		{
			return ["tpl_scrollBarH", "tpl_scrollBarV"];
		}
		
		override public function nodeBeg():String
		{
			var attriStr:String = baseAttriStr();
			
			attriStr += " bgAlpha='" + this.bgAlpha + "'";
			attriStr += " bgColor='" + this.bgColor + "'";
			attriStr += " bgFill='" + this.bgFill + "'";
			
			attriStr += " tpl_scrollBarH='" + this.tpl_scrollBarH + "'";
			attriStr += " tpl_scrollBarV='" + this.tpl_scrollBarV + "'";
			
			return "<"+JuiType.JScrollPanel+attriStr+">";
		}
		
		override public function nodeEnd():String
		{
			return "</"+JuiType.JScrollPanel+">";
		}
		
	}
}