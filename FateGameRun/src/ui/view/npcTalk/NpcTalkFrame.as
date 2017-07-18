package ui.view.npcTalk
{
	import central.Game;
	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.*;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import net.msg.task.TaskMsg;
	
	import run.npc.NpcTalkContent;
	
	import ui.skin.font.DefaultFont;
	import ui.view.ViewWnd;
	
	public class NpcTalkFrame extends ViewWnd
	{
		private var closeBtn:JPushButton;
		private var contentPane:JScrollPanel;
		private var cmdBtn:JPushButton;
		
		private var content:NpcTalkContent;
		
		public function NpcTalkFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("npc_talk");
			pane = uiPack.getCtrl("root");
			closeBtn = uiPack.getPushButton("closeBtn");
			contentPane = uiPack.getScrollPanel("contentPane");
			cmdBtn = uiPack.getPushButton("cmdBtn");
			
			canDrag(true);
			canBringTop(true);
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtnClick);
			cmdBtn.addEventListener(MouseEvent.CLICK, __cmdBtnClick);
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
		
		private function __cmdBtnClick(e:MouseEvent):void
		{
			if(!content) { hide();return; }
			if(content.hasDoneTask)
			{
				Game.info.notice("请求完成任务");
				TaskMsg.getInstance().sendFinishTaskReq_C2G(content.taskId);
			}
			else if(content.hasAcceptableTask)
			{
				Game.info.notice("请求接受任务");
				TaskMsg.getInstance().sendAcceptTaskReq_C2G(content.taskId);
			}
			else if(content.hasDoingTask)
			{
				Game.info.notice("任 务 进 行 中...");
			}
			hide();
		}
		
		/** 更新内容 */
		public function updateContent(content:NpcTalkContent):void
		{
			this.content = content;
			contentPane.clearContent();
			
			var textLabel:JLabel = new JLabel(content.text);
			textLabel.textFormat = DefaultFont.create();
			textLabel.usePack = true;
			textLabel.draw();
			textLabel.move(0,0);
			contentPane.addChild(textLabel);
			if(content.hasDoneTask)
			{
				cmdBtn.caption = "完 成 任 务";
				cmdBtn.disabled = false;
			}
			else if(content.hasAcceptableTask)
			{
				cmdBtn.caption = "接 受 任 务";
				cmdBtn.disabled = false;
			}
			else if(content.hasDoingTask)
			{
				cmdBtn.caption = "任 务 进 行 中...";
				cmdBtn.disabled = true;
			}
			else
			{
				cmdBtn.caption = "再      见";
				cmdBtn.disabled = false;
			}
		}
		
	}
}