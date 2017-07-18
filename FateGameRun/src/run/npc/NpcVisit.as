package run.npc
{
	import central.Game;
	
	import cfg.NpcInfoCfg;
	
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.utils.GeomUtils;
	
	import net.msg.npc.NpcMsg;
	
	import run.scene.avatar.action.Traveller;
	
	public class NpcVisit extends Traveller
	{
		/** 想要去访问的npc的配置 */
		private var nic:NpcInfoCfg;
		
		public function NpcVisit()
		{
			super();
		}
		
		public function visit(npcId:int):void
		{
			nic = NpcInfoCfg.get(npcId);
			if(!nic)
			{
				Game.info.notice("不存在这个想要去访问的npc唉");
				return;
			}
			execute(nic.mapId, nic.mapX, nic.mapY);
		}
		
		override protected function reached():void
		{
			if(!nic)
			{
				cancel();
				return;
			}
			NpcMsg.getInstance().sendTalkWithNpcReq_C2G(nic.id);
			cancel();
		}
		
	}
}