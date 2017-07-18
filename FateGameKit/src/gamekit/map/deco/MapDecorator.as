package gamekit.map.deco
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import gamekit.FateGameKit;
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	import gamekit.map.deco.struct.StMapDecoCfg;
	import gamekit.map.material.MapConfig;
	import gamekit.utils.IntervalCounter;

	public class MapDecorator
	{
		private static var instance:MapDecorator;
		
		public static function getInstance():MapDecorator
		{
			if(instance == null) { instance = new MapDecorator(); }
			return instance;
		}
		
		/** 所有配置 */
		private var cfgs:Vector.<StMapDecoCfg> = new Vector.<StMapDecoCfg>();
		/** 测量间隔 */
		private var measureIC:IntervalCounter = new IntervalCounter(30);
		/** swfs */
		private var swfs:Vector.<MapDecoSwf> = new Vector.<MapDecoSwf>();
		
		public function MapDecorator()
		{
		}
		
		/** 注册地图修饰 */
		public function regDecoration(decoCfg:StMapDecoCfg):void
		{
			cfgs.push(decoCfg);
		}
		
		/** 取消地图修饰 */
		public function unregDecoration(decoCfgUid:int):void
		{
			for(var i:int = 0; i < cfgs.length; i++)
			{
				if(cfgs[i].uid == decoCfgUid)
				{
					cfgs.splice(i, 1);
					break;
				}
			}
		}
		
		/** 获取对应的Swf,如果原本没有的，就new一个出来 */
		private function retrieveSwf(cfg:StMapDecoCfg):MapDecoSwf
		{
			for(var i:int = 0; i < swfs.length; i++)
			{
				if(swfs[i].getCfg().uid == cfg.uid)
				{
					return swfs[i];
				}
			}
			var swf:MapDecoSwf = new MapDecoSwf(cfg);
			swfs.push(swf);
			return swf;
		}
		
		/** nextFrame */
		public function nextFrame():void
		{
			if(measureIC.trigger())
			{
				var mapCfg:MapConfig = MapFacade.getInstance().getCurConfig();
				if(mapCfg != null)
				{
					var cansee:Rectangle = new Rectangle();
					cansee.x = Math.abs(Layer.map.x);
					cansee.y = Math.abs(Layer.map.y);
					cansee.width = FateGameKit.STAGE.stageWidth;
					cansee.height = FateGameKit.STAGE.stageHeight;
					
					const EXTEND_BUF:int = 1;
					var BEG_GX:int = Math.floor( cansee.x / mapCfg.getGridW() ) - EXTEND_BUF;
					var BEG_GY:int = Math.floor( cansee.y / mapCfg.getGridH() ) - EXTEND_BUF;
					var END_GX:int = Math.ceil( cansee.right / mapCfg.getGridW() ) + EXTEND_BUF;
					var END_GY:int = Math.ceil( cansee.bottom / mapCfg.getGridH() ) + EXTEND_BUF;
					if(BEG_GX < 0) { BEG_GX = 0; }
					if(BEG_GY < 0) { BEG_GY = 0; }
					if(END_GX >= mapCfg.getGridCountX()) { END_GX = mapCfg.getGridCountX() - 1; }
					if(END_GY >= mapCfg.getGridCountY()) { END_GY = mapCfg.getGridCountY() - 1; }
					
					for(var i:int = 0; i < cfgs.length; i++)
					{
						if(cfgs[i].isInSight(mapCfg.getMapId(), BEG_GX, BEG_GY, END_GX, END_GY))
						{
							var swf:MapDecoSwf = retrieveSwf(cfgs[i]);
							if(swf.getContainer() == null)
							{
								swf.x = (cfgs[i].mapX + 0.5) * mapCfg.getGridW();
								swf.y = (cfgs[i].mapY + 0.5) * mapCfg.getGridH();
								swf.load(cfgs[i].swfUrl, cfgs[i].className);
								swf.addTo(Layer.background);
								trace("添加地图装饰成功 添加在"+mapCfg.getMapId()+"("+cfgs[i].mapX+","+cfgs[i].mapY+")", cfgs[i].swfUrl, cfgs[i].className);
							}
						}
					}
					
					for(var j:int = swfs.length-1; j >= 0; j--)
					{
						if( swfs[j].getCfg().isInSight(mapCfg.getMapId(), BEG_GX, BEG_GY, END_GX, END_GY) )
						{
							
						}
						else
						{
							//var outCfg:StMapDecoCfg = swfs[j].getCfg();
							//trace("超出视野", outCfg.mapId, outCfg.mapX, outCfg.mapY, mapCfg.getMapId(), BEG_GX, BEG_GY, END_GX, END_GY);
							swfs[j].remove();
							swfs.splice(j, 1);
						}
					}
				}
			}
		}
		
		
		
	}
}