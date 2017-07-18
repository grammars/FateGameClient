package com.anstu.jui.build.doc
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	public class UIPack
	{
		private var controls:Vector.<JComponent> = new Vector.<JComponent>();
		
		public function UIPack()
		{
		}
		
		public function put(ctrl:JComponent):void
		{
			if(ctrl)
			{
				controls.push(ctrl);
			}
		}
		
		public function addToContainer(container:DisplayObjectContainer):void
		{
			for(var i:int = 0; i < controls.length; i++)
			{
				var ctrl:JComponent = controls[i];
				container.addChild(ctrl);
			}
		}
		
		
		private var dic:Object = new Object();
		/** 通过tag注册到控件索引中 */
		public function reg(ctrl:JComponent):void
		{
			if(ctrl.tag)
			{
				dic[ctrl.tag] = ctrl;
			}
		}
		
		public function getCtrl(tag:String):JComponent
		{
			return dic[tag];
		}
		
		public function getCalendar(tag:String):JCalendar { return dic[tag]; }
		public function getCheckBox(tag:String):JCheckBox { return dic[tag]; }
		public function getComboBox(tag:String):JComboBox { return dic[tag]; }
		public function getFrame(tag:String):JFrame { return dic[tag]; }
		public function getImage(tag:String):JImage { return dic[tag]; }
		public function getInputText(tag:String):JInputText { return dic[tag]; }
		public function getLabel(tag:String):JLabel { return dic[tag]; }
		public function getList(tag:String):JList { return dic[tag]; }
		public function getListItem(tag:String):JListItem { return dic[tag]; }
		public function getPanel(tag:String):JPanel { return dic[tag]; }
		public function getPushButton(tag:String):JPushButton { return dic[tag]; }
		public function getRadioButton(tag:String):JRadioButton { return dic[tag]; }
		public function getScrollBar(tag:String):JScrollBar { return dic[tag]; }
		public function getScrollPanel(tag:String):JScrollPanel { return dic[tag]; }
		public function getScrollSlider(tag:String):JScrollSlider { return dic[tag]; }
		public function getSlider(tag:String):JSlider { return dic[tag]; }
		public function getText(tag:String):JText { return dic[tag]; }
		public function getTextArea(tag:String):JTextArea { return dic[tag]; }
		public function getTitle(tag:String):JTitle { return dic[tag]; }
		public function getBaseText(tag:String):JBaseText { return dic[tag]; }
	}
}