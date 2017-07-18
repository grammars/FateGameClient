package run.scene.map
{
	import central.Centre;
	
	import cfg.MapDoorCfg;
	
	import gamekit.map.MapFacade;
	import gamekit.map.deco.struct.StMapDecoCfg;

	/** 地图装饰处理  */
	public class MapDecoHandler
	{
		public function MapDecoHandler()
		{
		}
		
		/** setup */
		public static function setup():void
		{
//			for(var i:int = 0; i < MapDoorCfg.cfgs.length; i++)
//			{
//				var mgc:MapDoorCfg = MapDoorCfg.cfgs[i];
//				var mdc:StMapDecoCfg = new StMapDecoCfg(mgc.fromMapId, mgc.fromMapX, mgc.fromMapY);
//				mdc.swfUrl = Centre.RES_ROOT + "map/deco/mapgate.swf";
//				mdc.className = "MapGateEff";
//				MapFacade.getInstance().regDecoration(mdc);
//			}
		}
		
	}
}