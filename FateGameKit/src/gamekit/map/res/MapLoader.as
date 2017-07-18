package gamekit.map.res
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.Timer;
	
	import gamekit.FateGameKit;
	import gamekit.GameScene;
	import gamekit.map.MapFacade;
	import gamekit.map.MapRule;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.map.material.MapConfig;
	import gamekit.map.material.MapLayer;
	import gamekit.map.material.MapTile;
	import gamekit.utils.IntervalCounter;

	public class MapLoader
	{
		private static var instance:MapLoader;
		
		public static function getInstance():MapLoader
		{
			if(instance == null) { instance = new MapLoader(); }
			return instance;
		}
		
		
		private var curLayer:MapLayer;
		private var curConfig:MapConfig;
		
		private var measureIC:IntervalCounter = new IntervalCounter(30);
		
		public function MapLoader()
		{
			if(instance != null) { throw new Error("MapLoader should be single!"); }
			instance = this;
		}
		
		/** nextFrame */
		public function nextFrame():void
		{
			if(measureIC.trigger())
			{
				if(curConfig == null) { return; }
				if(curLayer == null) { return; }
				
				var cansee:Rectangle = new Rectangle();
				cansee.x = Math.abs(GameScene.getInstance().x);
				cansee.y = Math.abs(GameScene.getInstance().y);
				cansee.width = FateGameKit.STAGE.stageWidth;
				cansee.height = FateGameKit.STAGE.stageHeight;
				
				const EXTEND_BUF:int = 1;
				var BEG_IND_X:int = Math.floor( cansee.x / curConfig.getTileWidth() ) - EXTEND_BUF;
				var BEG_IND_Y:int = Math.floor( cansee.y / curConfig.getTileHeight() ) - EXTEND_BUF;
				var END_IND_X:int = Math.ceil( cansee.right / curConfig.getTileWidth() ) + EXTEND_BUF;
				var END_IND_Y:int = Math.ceil( cansee.bottom / curConfig.getTileHeight() ) + EXTEND_BUF;
				if(BEG_IND_X < 0) { BEG_IND_X = 0; }
				if(BEG_IND_Y < 0) { BEG_IND_Y = 0; }
				if(END_IND_X >= curConfig.getTileCol()) { END_IND_X = curConfig.getTileCol() - 1; }
				if(END_IND_Y >= curConfig.getTileRow()) { END_IND_Y = curConfig.getTileRow() - 1; }
				
				MapTile.invalidPool();
				for(var ix:int = BEG_IND_X; ix <= END_IND_X; ix++)
				{
					for(var iy:int = BEG_IND_Y; iy <= END_IND_Y; iy++)
					{
						const url:String = FateGameKit.RES_ROOT + "map/" + curConfig.getMapId() + "/tiles/" + iy + "_" + ix + ".jpg";
						var t:MapTile = MapTile.getTile(url);
						t.load(url, curConfig.getTileWidth(), curConfig.getTileHeight());
						t.x = ix * curConfig.getTileWidth();
						t.y = iy * curConfig.getTileHeight();
					}
				}
				MapTile.renderPool(curLayer.getBackground());
				//trace("测量一次  x["+BEG_IND_X+","+END_IND_X+"] y["+BEG_IND_Y+","+END_IND_Y+"]");
			}
		}
		
		/** 加载配置 */
		public function loadConfig(mapId:int):void
		{
			new MetaLoader(mapId, MapRule.getMetaAddr(mapId));
			new CfgLoader(mapId, MapRule.getCfgAddr(mapId));
		}
		
		/** 改变地图 */
		public function changeMap(l:MapLayer, c:MapConfig):void
		{
			curLayer = l;
			curConfig = c;
			var event:MapEvent = new MapEvent(MapEvent.CHANGE);
			MapMonitor.getInstance().dispatchEvent(event);
		}
		
		
	}
}


import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.utils.ByteArray;

import gamekit.map.MapFacade;
import gamekit.map.material.MapConfig;

class MetaLoader extends URLLoader
{
	public var mapId:int;
	
	public function MetaLoader(mapId:int, addr:String)
	{
		this.mapId = mapId;
		this.addEventListener(Event.COMPLETE, __loaded);
		this.addEventListener(IOErrorEvent.IO_ERROR, __loadErr);
		this.load(new URLRequest(addr));
	}
	
	private function __loaded(e:Event):void
	{
		//trace("MetaLoader::__loaded");
		var l:MetaLoader = (e.target) as MetaLoader;
		l.removeEventListener(Event.COMPLETE, __loaded);
		l.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
		var content:String = new String(l.data);
		var config:MapConfig = MapFacade.getInstance().retrieveConfig(mapId);
		config.decodeMeta(content);
		config.metaDone();
	}
	
	private function __loadErr(e:Event):void
	{
		trace("MetaLoader::__loadErr");
		var l:MetaLoader = (e.target) as MetaLoader;
		l.removeEventListener(Event.COMPLETE, __loaded);
		l.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
	}
}

class CfgLoader extends URLLoader
{
	public var mapId:int;
	
	public function CfgLoader(mapId:int, addr:String):void
	{
		this.dataFormat = URLLoaderDataFormat.BINARY;
		this.mapId = mapId;
		this.addEventListener(Event.COMPLETE, __loaded);
		this.addEventListener(IOErrorEvent.IO_ERROR, __loadErr);
		this.load(new URLRequest(addr));
	}
	
	private function __loaded(e:Event):void
	{
		//trace("CfgLoader::__loaded");
		var l:CfgLoader = (e.target) as CfgLoader;
		l.removeEventListener(Event.COMPLETE, __loaded);
		l.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
		var bytes:ByteArray = l.data as ByteArray;
		var config:MapConfig = MapFacade.getInstance().retrieveConfig(mapId);
		config.decodeCfg(bytes);
		config.cfgDone();
	}
	
	private function __loadErr(e:Event):void
	{
		trace("CfgLoader::__loadErr");
		var l:CfgLoader = (e.target) as CfgLoader;
		l.removeEventListener(Event.COMPLETE, __loaded);
		l.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
	}
}
