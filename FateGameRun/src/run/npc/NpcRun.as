package run.npc
{
	import central.Game;
	import central.View;
	
	import cfg.NpcInfoCfg;
	
	import gamekit.avatar.AvatarRule;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.map.MapFacade;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.map.material.AStarNode;
	import gamekit.utils.GeomUtils;
	
	import net.msg.npc.NpcMsg;
	
	import run.AbstractRunHandler;
	import run.action.GotoNpcAction;
	import run.scene.avatar.NpcAvt;
	import run.scene.avatar.action.Traveller;
	
	public class NpcRun extends AbstractRunHandler
	{
		private var visit:NpcVisit = new NpcVisit();
		
		public function NpcRun()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			super.startup();
		}
		
		/** 访问npc */
		public function visitNpc(npcId:int):void
		{
			visit.visit(npcId);
		}
		
		/** 取消访问npc */
		private function cancelVisitNpc():void
		{
			visit.cancel();
		}
		
		
		
		/** 开启对话 */
		public function openTalk(content:NpcTalkContent):void
		{
			View.npcTalkFrame.updateContent(content);
			View.npcTalkFrame.show();
		}
		
	}
}