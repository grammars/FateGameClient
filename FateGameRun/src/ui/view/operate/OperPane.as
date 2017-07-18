package ui.view.operate
{
	import central.Centre;
	import central.Game;
	import central.View;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.controls.*;
	import com.anstu.jui.skin.JCheckBoxSkin;
	import com.anstu.jui.skin.JPushButtonSkin;
	import com.anstu.jui.skin.JRadioButtonSkin;
	
	import comm.component.skill.SkillItem;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gamekit.layer.Layer;
	
	import ui.UIManage;
	import ui.view.IBasePane;
	import ui.view.ViewWnd;
	import ui.view.goods.GoodsFrame;
	import ui.view.heroAttri.HeroAttriFrame;
	
	public class OperPane extends ViewWnd
	{
		private var expandBtn:JCheckBox;
		private var roleBtn:JPushButton;
		private var goodsBtn:JPushButton;
		private var taskBtn:JPushButton;
		private var skillBtn:JPushButton;
		private var familyBtn:JPushButton;
		private var horseBtn:JPushButton;
		private var channelsBtn:JPushButton;
		private var soulBtn:JPushButton;
		private var roundMask:JImage;
		
		public function OperPane()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("oper_pane");
			pane = uiPack.getCtrl("root");
			expandBtn = uiPack.getCheckBox("expandBtn");
			roleBtn = uiPack.getPushButton("roleBtn");
			goodsBtn = uiPack.getPushButton("goodsBtn");
			taskBtn = uiPack.getPushButton("taskBtn");
			skillBtn = uiPack.getPushButton("skillBtn");
			familyBtn = uiPack.getPushButton("familyBtn");
			horseBtn = uiPack.getPushButton("horseBtn");
			channelsBtn = uiPack.getPushButton("channelsBtn");
			soulBtn = uiPack.getPushButton("soulBtn");
			roundMask = uiPack.getImage("roundMask");
			
			OperIconField.instance.x = 39;
			OperIconField.instance.y = 12;
			pane.addChild(OperIconField.instance);
			
			pane.addEventListener(MouseEvent.CLICK, __paneClick);
			expandBtn.addEventListener(Event.CHANGE, __expandBtn);
		}
		
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = (Centre.stage.stageWidth - pane.width) / 2;
				pane.y = Centre.stage.stageHeight - pane.height;
			}
		}
		
		private function __paneClick(e:MouseEvent):void
		{
			switch(e.target)
			{
				case roleBtn:
					View.heroAttriFrame.showOrHide();
					break;
				case goodsBtn:
					View.goodsFrame.showOrHide();
					break;
				case taskBtn:
					View.taskFrame.showOrHide();
					break;
				case skillBtn:
					Game.info.notice("技能系统暂未开放");
					break;
				case familyBtn:
					Game.info.notice("家族系统暂未开放");
					break;
				case horseBtn:
					Game.info.notice("坐骑系统暂未开放");
					break;
				case channelsBtn:
					Game.info.notice("经脉系统暂未开放");
					break;
				case soulBtn:
					Game.info.notice("战魂系统暂未开放");
					break;
			}
		}
		
		private function __expandBtn(e:Event):void
		{
			if(expandBtn.selected)
			{
				Game.info.notice("展开技能栏");
			} 
			else
			{
				Game.info.notice("缩起技能栏");
			}
		}
		
		
		/** heroInit */
		public function heroInit():void
		{
			OperIconField.instance.clear();
			var skills:Vector.<SkillItem> = Game.hero.skills.items;
			for(var i:int = 0; i < skills.length; i++)
			{
				var data:SkillItem = skills[i];
				var icon:OperIcon = new OperIcon();
				icon.fill(data);
				OperIconField.instance.add(icon);
			}
		}
		
	}
}