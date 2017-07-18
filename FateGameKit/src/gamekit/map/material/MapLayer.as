package gamekit.map.material
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import gamekit.FateGameKit;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.map.MapFacade;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	
	public class MapLayer extends Sprite
	{
		private var background:Sprite = new Sprite();
		public function getBackground():Sprite { return background; }
		
		private var debugShape:Sprite = new Sprite();
		public function getDebugShape():Sprite { return debugShape; }
		
		private var astarShape:Shape = new Shape();
		public function getAstarShape():Shape { return astarShape; }
		
		private var astar:AStarEngine = new AStarEngine();
		
		private var enable:Boolean = true;
		public function setEnable(value:Boolean):void
		{
			this.enable = value;
			this.mouseChildren = this.mouseEnabled = this.enable;
		}
		public function getEnable():Boolean { return this.enable; }
		
		public function MapLayer()
		{
			super();
			this.addChild(background);
			this.addChild(debugShape);
			this.addChild(astarShape);
			debugShape.mouseEnabled = debugShape.mouseChildren = false;
			background.mouseChildren = false;
			this.addEventListener(MouseEvent.CLICK, __clickOnMap);
		}
		
		private var clickTime:Number = 0;
		private function __clickOnMap(e:MouseEvent):void
		{
			//控制点击地图的频率 ,大于一个走步时间->added by chenyong
			if (getTimer() - clickTime < FateGameKit.MAP_CLICK_INTERVAL)
			{
				//trace("点击太快");
				return;
			}
			clickTime = getTimer();
			//trace("__clickOnMap",e.target, e.localX, e.localY);
			var hero:AvatarDisplay = MapFacade.getInstance().getHero();
			if(hero == null) { return; }
			var cfg:MapConfig = MapFacade.getInstance().peekConfig(MapFacade.getInstance().getCurMapId());
			if(cfg == null) { return; }
			astar.setMapCfg(cfg);
			const startX:int = hero.getGridX();
			const startY:int = hero.getGridY();
			var endX:int = int(e.localX / cfg.getGridW());
			var endY:int = int(e.localY / cfg.getGridH());
			
			if(cfg.isBlock(endX,endY))
			{
				var nearNode:AStarNode = cfg.retrieveNonBlockNode(endX, endY);
				if(nearNode)
				{
					endX = nearNode.ind_X;
					endY = nearNode.ind_Y;
				}
			}
			
			var arr:Array = findPath(startX, startY, endX, endY);
			//trace("MapLayer::__clickOnMap寻路start("+startX+","+startY+") end("+endX+","+endY+")", arr);
			
			var clickBlock:Boolean = arr.length < 2 ? true : false;
			
			var evt:MapEvent = new MapEvent(MapEvent.CLICK);
			evt.clickBlock = clickBlock;
			evt.clickPx = e.localX;
			evt.clickPy = e.localY;
			evt.clickGx = endX;
			evt.clickGy = endY;
			MapMonitor.getInstance().dispatchEvent(evt);
			
			if(!clickBlock)
			{
				hero.go(arr);
			}
		}
		
		/** 获得寻路路径<br>
		 * 如果存在可行走的路径，则至少包含start和end两个节点<br>
		 * 否则返回空数组 */
		public function findPath(startGridX:int, startGridY:int, endGridX:int, endGridY:int):Array
		{
			var cfg:MapConfig = MapFacade.getInstance().peekConfig(MapFacade.getInstance().getCurMapId());
			if(cfg == null) { return []; }
			astar.setMapCfg(cfg);
			var startNode:AStarNode = cfg.getNonBlockNode(startGridX, startGridY);
			var astarPath:Array = astar.findPath(startGridX, startGridY, endGridX, endGridY);
			if(astarPath.length > 0)
			{
				astarPath.unshift(startNode);
			}
			return astarPath;
		}
		
	}
}