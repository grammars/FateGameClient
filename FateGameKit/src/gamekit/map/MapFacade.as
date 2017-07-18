package gamekit.map
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import gamekit.FateGameKit;
	import gamekit.GameScene;
	import gamekit.avatar.AvatarFacade;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.layer.Layer;
	import gamekit.map.deco.MapDecorator;
	import gamekit.map.deco.struct.StMapDecoCfg;
	import gamekit.map.events.MapConfigEvent;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.map.material.MapConfig;
	import gamekit.map.material.MapLayer;
	import gamekit.map.res.MapLoader;

	public class MapFacade
	{
		private static var instance:MapFacade;
		
		public static function getInstance():MapFacade
		{
			if(instance == null) { instance = new MapFacade(); }
			return instance;
		}
		
		private var hero:AvatarDisplay;
		public function setHero(m:AvatarDisplay):void
		{
			this.hero = m;
			this.hero.isHero = true;
		}
		public function getHero():AvatarDisplay { return hero; }
		
		public function MapFacade()
		{
			if(instance != null) { throw new Error("MapFacade should be single!"); }
			instance = this;
		}
		
		/** 初始化 */
		public function initialize():void
		{
			MapMonitor.getInstance().addEventListener(MapConfigEvent.FULL_DONE, __ConfigDone);
			FateGameKit.STAGE.addEventListener(Event.RESIZE, __stageResize);
		}
		
		/** ENTER_FRAME */
		public function nextFrame():void
		{
			MapLoader.getInstance().nextFrame();
			MapDecorator.getInstance().nextFrame();
		}
		
		/** stageResize */
		private function __stageResize(e:Event):void
		{
			focusHero();
		}
		
		private function focusHero():void
		{
			if(hero)
			{
				GameScene.getInstance().focusTarget(hero);
			}
		}
		
		/** 地图配置集<br>
		 * key:mapId(int) <br>
		 * value:对应的配置(MapConfig) */
		private var configDic:Object = new Object();
		/** 插入地图配置 */
		public function insertConfig(mapId:int, config:MapConfig):void
		{
			configDic[mapId] = config;
		}
		/** 获取地图配置 */
		public function retrieveConfig(mapId:int):MapConfig
		{
			if(configDic[mapId] == null) { configDic[mapId] = new MapConfig(); }
			return configDic[mapId];
		}
		/** 窥探地图配置，如果没有该配置，则返回null */
		public function peekConfig(mapId:int):MapConfig
		{
			return configDic[mapId];
		}
		
		/** 加载地图配置(但不会应用此配置) */
		public function loadConfig(mapId:int):void
		{
			MapLoader.getInstance().loadConfig(mapId);
		}
		
		/** 某一组metadata和.map部署完毕 */
		private function __ConfigDone(e:MapConfigEvent):void
		{
			trace("__ConfigDone", e.config);
			if(needLoadCfg && e.config.getMapId() == curMapId)
			{
				MapLoader.getInstance().changeMap(Layer.map, e.config);
				needLoadCfg = false;
				focusHero();
				if(FateGameKit.MAP_BLOCK_DEBUG)
				{
					paintBlockOnDebugShape(e.config);
				}
			}
		}
		//在地图的调试层上绘制阻碍点
		private function paintBlockOnDebugShape(cfg:MapConfig):void
		{
			var g:Graphics = Layer.map.getDebugShape().graphics;
			g.clear();
			for(var i:int = 0; i < cfg.getGrids().length; i++)
			{
				if(cfg.getGrids()[i].isBlock)
				{
					g.beginFill(0xff0000, 0.5);
					const indX:int = i % cfg.getGridCountX();
					const indY:int = Math.floor(i / cfg.getGridCountX());
					g.drawRect(indX*cfg.getGridW(), indY*cfg.getGridH(), cfg.getGridW(), cfg.getGridH());
					g.endFill();
				}
			}
			//
			g.lineStyle(1, 0xffff00, 0.6);
			for(var x:int = 1; x < cfg.getGridCountX(); x++)
			{
				g.moveTo(x*cfg.getGridW(), 0);
				g.lineTo(x*cfg.getGridW(), cfg.getMapHeight());
			}
			for(var y:int = 1; y < cfg.getGridCountY(); y++)
			{
				g.moveTo(0, y*cfg.getGridH());
				g.lineTo(cfg.getMapWidth(), y*cfg.getGridH());
			}
		}
		
		/** 获取当前MapConfig */
		public function getCurConfig():MapConfig
		{
			return peekConfig(curMapId);
		}
		
		/** 当前地图像素宽 */
		public function get curMapWidth():int
		{
			var cfg:MapConfig = getCurConfig();
			if(cfg) { return cfg.getMapWidth(); }
			return 0;
		}
		/** 当前地图像素高 */
		public function get curMapHeight():int
		{
			var cfg:MapConfig = getCurConfig();
			if(cfg) { return cfg.getMapHeight(); }
			return 0;
		}
		
		/** 是否需要下载地图配置 */
		private var needLoadCfg:Boolean = false;
		/** 当前地图ID */
		private var curMapId:int = 0;
		/** 获取当前地图ID */
		public function getCurMapId():int { return curMapId; }
		
		/** 切换地图 */
		public function changeMap(mapId:int):void
		{
			if(curMapId == mapId) { return; }
			curMapId = mapId;
			if(peekConfig(mapId))
			{
				var cfg:MapConfig = peekConfig(mapId);
				MapConfigEvent.dispatchMapConfigFullDone(cfg);
				MapLoader.getInstance().changeMap(Layer.map, cfg);
			}
			else
			{
				needLoadCfg = true;
				loadConfig(mapId);
			}
//			var event:MapEvent = new MapEvent(MapEvent.CHANGE);
//			MapMonitor.getInstance().dispatchEvent(event);
		}
		
		/** 由像素x获得格子x */
		public function getGridX(pixelX:int):int
		{
			var cfg:MapConfig = getCurConfig();
			if(cfg == null) { return 0; }
			return Math.floor(pixelX/cfg.getGridW());
		}
		/** 由像素y获得格子y */
		public function getGridY(pixelY:int):int
		{
			var cfg:MapConfig = getCurConfig();
			if(cfg == null) { return 0; }
			return Math.floor(pixelY/cfg.getGridH());
		}
		/** 由格子x获得像素x */
		public function getPixelX(gridX:int):Number
		{
			var cfg:MapConfig = getCurConfig();
			if(cfg == null) { return 0; }
			//return int( cfg.getGridW() * (gridX+0.5) );
			return ( cfg.getGridW() * (gridX+0.5) );
		}
		/** 由格子y获得像素y */
		public function getPixelY(gridY:int):Number
		{
			var cfg:MapConfig = getCurConfig();
			if(cfg == null) { return 0; }
			//return int( cfg.getGridH() * (gridY+0.5) );
			return ( cfg.getGridH() * (gridY+0.5) );
		}
		
		/** 注册地图修饰 */
		public function regDecoration(decoCfg:StMapDecoCfg):void
		{
			MapDecorator.getInstance().regDecoration(decoCfg);
		}
		
		/** 取消地图修饰 */
		public function unregDecoration(decoCfgUid:int):void
		{
			MapDecorator.getInstance().unregDecoration(decoCfgUid);
		}
		
	}
}