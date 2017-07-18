package run.action
{
	import central.Game;
	
	import cfg.MapDoorCfg;
	import cfg.MapInfoCfg;
	import cfg.NpcInfoCfg;
	
	import gamekit.algorithm.dijkstra.Digraph;
	import gamekit.algorithm.dijkstra.DigraphVertex;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.map.MapFacade;
	import gamekit.map.events.MapConfigEvent;
	import gamekit.map.events.MapMonitor;
	
	import run.scene.avatar.NpcAvt;

	public class GotoNpcAction extends IAction
	{
		private var npcId:int;
		private var needTalk:Boolean;
		private var npcCfg:NpcInfoCfg
		
		public function GotoNpcAction(npcId:int, needTalk:Boolean)
		{
			super(false);
			this.npcId = npcId;
			this.needTalk = needTalk;
			this.type = IAction.GO;
		}
		
		override public function start():void
		{
			if(!npcCfg) { done();return; }
			
		}
		
		
		
		private static var MODED:Boolean = false;
		private static function modMapDoorCfgs():void
		{
			if(MODED) { return; }
			var c:MapDoorCfg;
			
			c = new MapDoorCfg();
			c.fromMapId = 8001;
			c.toMapId = 8001;
			c.desc = "水";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8001;
			c.toMapId = 8002;
			c.desc = "甲";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8001;
			c.toMapId = 8003;
			c.desc = "地";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8002;
			c.toMapId = 8004;
			c.desc = "乙";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8002;
			c.toMapId = 8003;
			c.desc = "法";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8002;
			c.toMapId = 8004;
			c.desc = "亿";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8003;
			c.toMapId = 8013;
			c.desc = "干";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8004;
			c.toMapId = 8005;
			c.desc = "丙";
			MapDoorCfg.cfgs.push(c);
			
			c = new MapDoorCfg();
			c.fromMapId = 8005;
			c.toMapId = 8015;
			c.desc = "绕";
			MapDoorCfg.cfgs.push(c);
			
			MODED = true;
		}
		
		
		
		override public function stop():void
		{
			
		}
		
		override public function killTypes():Array
		{
			return [IAction.GO];
		}
	}
}