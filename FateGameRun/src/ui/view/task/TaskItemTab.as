package ui.view.task
{
	import central.Centre;
	import central.View;
	
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.controls.JRadioButton;
	import com.anstu.jui.skin.JRadioButtonSkin;
	
	import comm.component.task.TaskItem;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import res.Res;
	
	import ui.skin.font.DefaultFont;
	
	public class TaskItemTab extends Sprite
	{
		private static var group:JRadioGroup = new JRadioGroup("TaskItemTabGroup");
		private static const tabSkin:JRadioButtonSkin = new JRadioButtonSkin();
		private static var INITED:Boolean = false;
		private static function C():void
		{
			if(INITED) { return; }
			
			tabSkin.base_ns = Res.NS;
			tabSkin.unselected_default_cls = "btn_mud0$png";
			tabSkin.unselected_over_cls = "btn_mud1$png";
			tabSkin.unselected_down_cls = "btn_mud2$png";
			tabSkin.unselected_disabled_cls = "btn_mud0$png";
			tabSkin.selected_default_cls = "btn_grass0$png";
			tabSkin.selected_over_cls = "btn_grass1$png";
			tabSkin.selected_down_cls = "btn_grass2$png";
			tabSkin.selected_disabled_cls = "btn_grass0$png";
			tabSkin.width = 156;
			tabSkin.height = 28;
			tabSkin.unselected_labelFormat = DefaultFont.instance;
			tabSkin.selected_labelFormat = DefaultFont.instance;
			
			INITED = true;
		}
		
		public var tab:JRadioButton;
		
		public var info:TaskItem;
			
		public function TaskItemTab(info:TaskItem)
		{
			super();
			
			C();
			
			tab = new JRadioButton();
			tabSkin.apply(tab);
			group.add(tab);
			this.addChild(tab);
			tab.addEventListener(MouseEvent.CLICK, __tabClick);
			
			setInfo(info);
		}
		
		public function setInfo(info:TaskItem):void
		{
			this.info = info;
			
			tab.selectedLabel = "【"+info.config.name+"】";
			tab.unselectedLabel = info.config.name;
		}
		
		private function __tabClick(e:MouseEvent):void
		{
			View.taskFrame.presentTask(info);
		}
		
	}
}