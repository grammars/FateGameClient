package ui.view.task
{
	import central.Game;
	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.*;
	
	import comm.component.goods.GoodsFactory;
	import comm.component.goods.GoodsInfo;
	import comm.component.task.TaskItem;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gamekit.ds.pair.PairIntInt;
	
	import ui.view.ViewWnd;
	import ui.view.goods.GoodsIcon;
	import ui.view.link.NpcLink;
	
	public class TaskFrame extends ViewWnd
	{
		private var closeBtn:JPushButton;
		private var listCtn:JScrollPanel;
		private var detailCtn:JPanel;
		private var nameKey:JLabel;
		private var nameValue:JLabel;
		private var typeKey:JLabel;
		private var typeValue:JLabel;
		private var descKey:JLabel;
		private var descValue:JLabel;
		private var actionKey:JLabel;
		private var replyKey:JLabel;
		private var rwdKey:JLabel;
		private var rwdCoinsLine:JPanel;
		private var rwdBindCoinsLine:JPanel;
		private var rwdIngotLine:JPanel;
		private var rwdBindIngotLine:JPanel;
		private var rwdCoinsLabel:JLabel;
		private var rwdBindCoinsLabel:JLabel;
		private var rwdIngotLabel:JLabel;
		private var rwdBindIngotLabel:JLabel;
		private var rwdGoodsCtn:JPanel;
		
		private var complexLine:TaskComplexLine = new TaskComplexLine();
		private var rplNpcLink:NpcLink = new NpcLink();
		
		private var tabs:Vector.<TaskItemTab> = new Vector.<TaskItemTab>();
		
		private var showInfo:TaskItem;
		
		public function TaskFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("task_pane");
			pane = uiPack.getCtrl("root");
			closeBtn = uiPack.getPushButton("closeBtn");
			listCtn = uiPack.getScrollPanel("listCtn");
			detailCtn = uiPack.getPanel("detailCtn");
			nameKey = uiPack.getLabel("nameKey");
			nameValue = uiPack.getLabel("nameValue");
			typeKey = uiPack.getLabel("typeKey");
			typeValue = uiPack.getLabel("typeValue");
			descKey = uiPack.getLabel("descKey");
			descValue = uiPack.getLabel("descValue");
			actionKey = uiPack.getLabel("actionKey");
			replyKey = uiPack.getLabel("replyKey");
			rwdKey = uiPack.getLabel("rwdKey");
			rwdCoinsLine = uiPack.getPanel("rwdCoinsLine");
			rwdBindCoinsLine = uiPack.getPanel("rwdBindCoinsLine");
			rwdIngotLine = uiPack.getPanel("rwdIngotLine");
			rwdBindIngotLine = uiPack.getPanel("rwdBindIngotLine");
			rwdCoinsLabel = uiPack.getLabel("rwdCoinsLabel");
			rwdBindCoinsLabel = uiPack.getLabel("rwdBindCoinsLabel");
			rwdIngotLabel = uiPack.getLabel("rwdIngotLabel");
			rwdBindIngotLabel = uiPack.getLabel("rwdBindIngotLabel");
			rwdGoodsCtn = uiPack.getPanel("rwdGoodsCtn");
			
			listCtn.hScrollbar.autoHide = true;
			detailCtn.addChild(this.complexLine);
			detailCtn.addChild(this.rplNpcLink);
			
			canDrag(true);
			canBringTop(true);
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtnClick);
			
			presentTask(null);
			
//			var tl:NpcLink = new NpcLink(80081);
//			tl.move(30, 50);
//			detailCtn.addChild(tl);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
		private function __closeBtnClick(e:MouseEvent):void
		{
			hide();
		}
		
		/** 初始化任务列表 */
		public function initTaskList():void
		{
			listCtn.clearContent();
			for(var i:int = 0; i < Game.hero.task.items.length; i++)
			{
				var item:TaskItem = Game.hero.task.items[i];
				var tab:TaskItemTab = new TaskItemTab(item);
				listCtn.addChild(tab);
				tabs.push(tab);
			}
			putTabsPos();
			
			//默认选中第一个任务
			if(tabs.length > 0)
			{
				var sel:TaskItemTab = tabs[tabs.length-1];
				SELECT(sel);
			}
		}
		
		private function SELECT(tit:TaskItemTab):void
		{
			tit.tab.selected = true;
			presentTask(tit.info);
		}
		
		/** 新增任务 */
		public function addTask(item:TaskItem):void
		{
			var tab:TaskItemTab = new TaskItemTab(item);
			listCtn.addChild(tab);
			tabs.push(tab);
			putTabsPos();
			SELECT(tab);
		}
		
		/** 删除任务 */
		public function removeTask(taskId:int):void
		{
			for(var i:int = tabs.length-1; i >= 0; i--)
			{
				var tab:TaskItemTab = tabs[i];
				if(tab.info.taskId == taskId)
				{
					if(tab.parent) { tab.parent.removeChild(tab); }
					tabs.splice(i,1);
					if(showInfo && showInfo.taskId == taskId)
					{
						presentTask(null);
					}
					break;
				}
			}
			putTabsPos();
		}
		
		/** 更新任务 */
		public function updateTask(item:TaskItem):void
		{
			for(var i:int = tabs.length-1; i >= 0; i--)
			{
				var tab:TaskItemTab = tabs[i];
				if(tab.info.taskId == item.taskId)
				{
					tab.setInfo(item);
					if(showInfo && showInfo.taskId == item.taskId)
					{
						presentTask(item);
					}
					break;
				}
			}
		}
		
		/** 摆放tabs的位置 */
		private function putTabsPos():void
		{
			for(var i:int = 0; i < tabs.length; i++)
			{
				var tab:TaskItemTab = tabs[i];
				tab.x = 0;
				tab.y = i * 30;
			}
		}
		
		/** TaskItemTab点击之后呈现任务内容 */
		public function presentTask(info:TaskItem):void
		{
			this.showInfo = info;
			if(!info)
			{
				//如果没有任务信息的时候
				nameValue.text = "";
				typeValue.text = "";
				descValue.text = "";
				rwdCoinsLabel.text = "0";
				rwdBindCoinsLabel.text = "0";
				rwdIngotLabel.text = "0";
				rwdBindIngotLabel.text = "0";
				complexLine.visible = false;
				rplNpcLink.visible = false;
				return;
			}
			complexLine.visible = true;
			rplNpcLink.visible = true;
			
			var posY:int = 105;
			
			nameValue.text = info.config.name;
			typeValue.text = info.config.typeStr();
			
			descValue.text = info.config.desc;
			descValue.draw();
			posY += descValue.contentHeight();
			
			actionKey.y = posY;
			
			posY += 24;
			complexLine.x = 22;
			complexLine.y = posY;
			complexLine.present(info);
			posY += complexLine.getHeight();
			
			replyKey.y = posY;
			
			rplNpcLink.x = 90;
			rplNpcLink.y = posY;
			rplNpcLink.setup(info.config.endNpc);
			
			posY += 24;
			
			
			rwdKey.y = posY;
			posY += 24;
			
			if(info.config.rwdCoins > 0)
			{
				rwdCoinsLine.visible = true;
				rwdCoinsLine.y = posY;
				posY += 32;
				rwdCoinsLabel.text = info.config.rwdCoins.toString();
			}
			else
			{
				rwdCoinsLine.visible = false;
			}
			
			if(info.config.rwdBindCoins > 0)
			{
				rwdBindCoinsLine.visible = true;
				rwdBindCoinsLine.y = posY;
				posY += 32;
				rwdBindCoinsLabel.text = info.config.rwdBindCoins.toString();
			}
			else
			{
				rwdBindCoinsLine.visible = false;
			}
			
			if(info.config.rwdIngot > 0)
			{
				rwdIngotLine.visible = true;
				rwdIngotLine.y = posY;
				posY += 32;
				rwdIngotLabel.text = info.config.rwdIngot.toString();
			}
			else
			{
				rwdIngotLine.visible = false;
			}
			
			if(info.config.rwdBindIngot > 0)
			{
				rwdBindIngotLine.visible = true;
				rwdBindIngotLine.y = posY;
				posY += 32;
				rwdBindIngotLabel.text = info.config.rwdBindIngot.toString();
			}
			else
			{
				rwdBindIngotLine.visible = false;
			}
			
			rwdGoodsCtn.y = posY;
			rwdGoodsCtn.clearContent();
			for(var i:int = 0; i < info.config.rwdGoodsList.length; i++)
			{
				var p:PairIntInt = info.config.rwdGoodsList[i];
				var gi:GoodsInfo = GoodsFactory.createInfo(p.key);
				gi.num = p.value;
				var icon:GoodsIcon = new GoodsIcon();
				icon.setup(gi);
				icon.x = 49 * i + 8;
				icon.y = 8;
				rwdGoodsCtn.addChild(icon);
			}
		}
		
	}
}