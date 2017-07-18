package run.scene.avatar.action
{
	import central.Game;
	
	import cfg.MapDoorCfg;
	import cfg.MapInfoCfg;
	import cfg.NpcInfoCfg;
	
	import gamekit.algorithm.dijkstra.Digraph;
	import gamekit.algorithm.dijkstra.DigraphVertex;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.map.MapFacade;
	import gamekit.map.events.MapConfigEvent;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.utils.GeomUtils;
	
	import net.msg.npc.NpcMsg;
	
	import run.scene.avatar.NpcAvt;

	public class Traveller
	{
		private static var instance:Traveller;
		public static function getInstance():Traveller
		{
			if(instance == null) { instance = new Traveller(); }
			return instance;
		}
		
		
		/** 目标地图id */
		protected var tarMapId:int;
		/** 目标地图x */
		protected var tarMapX:int;
		/** 目标地图y */
		protected var tarMapY:int;
		
		/** 是否是最后一张走的地图 */
		//protected var isLastMap:Boolean = false;
		
		public function Traveller()
		{
		}
		
		/** 是否抵达目标地图 */
		private function inTargetMap():Boolean
		{
			var cmid:int = MapFacade.getInstance().getCurMapId();
			if(this.tarMapId != cmid) { return false; }
			return true;
		}
		
		/** 是否抵达目的地 */
		private function hasReached():Boolean
		{
			if(!inTargetMap()) { return false; }
			if(tarMapX < 0 || tarMapY < 0) { return true; }
			var dist:Number = GeomUtils.distance(tarMapX, tarMapY, Game.scene.hero.getGridX(), Game.scene.hero.getGridY());
			if(dist > AvatarDisplay.TOWARD_DISTANCE) { return false; }
			return true;
		}
		
		public function execute(tarMapId:int, tarMapX:int=-1, tarMapY:int=-1):void
		{
			this.tarMapId = tarMapId;
			this.tarMapX = tarMapX;
			this.tarMapY = tarMapY;
			
			var cmid:int = MapFacade.getInstance().getCurMapId();
			Game.scene.hero.addEventListener(AvatarEvent.WALK_STOP, __heroWalkStop);
			MapMonitor.getInstance().addEventListener(MapEvent.CLICK, __mapClick);
			if(tarMapId == cmid)
			{
				//在同一张地图上
				Game.scene.hero.to(tarMapX, tarMapY);
			}
			else
			{
				//在不同的地图上
				countMapRoute(cmid, tarMapId);
				MapMonitor.getInstance().addEventListener(MapEvent.CHANGE, __mapChange);
				move();
			}
		}
		
		private function __mapClick(e:MapEvent):void
		{
			if(!e.clickBlock)
			{
				cancel();
			}
		}
		
		private var route:Vector.<DigraphVertex>;
		
		private function countMapRoute(fromMapId:int, toMapId:int):void
		{
			var gra:Digraph = new Digraph();
			var i:int = 0;
			var v:DigraphVertex;
			for(i = 0; i < MapInfoCfg.getAll().length; i++)
			{
				var mic:MapInfoCfg = MapInfoCfg.getAll()[i];
				v = new DigraphVertex(mic.id.toString());
				gra.addVertex(v);
			}
			
			for(i = 0; i < MapDoorCfg.cfgs.length; i++)
			{
				var mdc:MapDoorCfg = MapDoorCfg.cfgs[i];
				gra.setValue(mdc.fromMapId.toString(), mdc.toMapId.toString(), 1);
			}
			
			route = gra.find(fromMapId.toString(), toMapId.toString());
			//gra.print(fromMapId.toString(), toMapId.toString());
		}
		
		/** 取消访问npc */
		public function cancel():void
		{
			Game.scene.hero.removeEventListener(AvatarEvent.WALK_STOP, __heroWalkStop);
			MapMonitor.getInstance().removeEventListener(MapEvent.CLICK, __mapClick);
			MapMonitor.getInstance().removeEventListener(MapEvent.CHANGE, __mapChange);
		}
		
		private function move():void
		{
			if(route == null || route.length <= 0)
			{
				route = null;
				Game.scene.hero.to(tarMapX, tarMapY);
				return;
			}
			
			var cmid:int = MapFacade.getInstance().getCurMapId();
			
			var v:DigraphVertex = route.pop();
			var toMapId:int = parseInt(v.name);
			if(cmid == toMapId && route.length > 0)
			{
				v = route.pop();
				toMapId = parseInt(v.name);
			}
			
			var mdc:MapDoorCfg = MapDoorCfg.findDoor(cmid, toMapId);
			trace("跨图步骤：：：" + mdc);
			if(mdc == null)
			{
				route = null;
				return;
			}
			else
			{
				Game.scene.hero.to(mdc.fromMapX, mdc.fromMapY);
			}
		}
		
		private function __mapChange(e:MapEvent):void
		{
			Game.info.notice("Traveller::__mapChange");
			if(inTargetMap())
			{
				MapMonitor.getInstance().removeEventListener(MapEvent.CHANGE, __mapChange);
				
			}
			move();
		}
		
		private function __heroWalkStop(e:AvatarEvent):void
		{
			Game.info.notice("Traveller::__heroWalkStop");
			if(hasReached())
			{
				reached();
			}
		}
		
		/** 抵达目标地 */
		protected function reached():void
		{
			//Game.info.notice("抵达目的地");
		}
		
	}
}