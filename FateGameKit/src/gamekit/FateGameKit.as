package gamekit
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import gamekit.avatar.AvatarFacade;
	import gamekit.avatar.res.AvatarPreRes;
	import gamekit.debug.AvtMonitor;
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	import gamekit.map.deco.MapDecorator;

	public class FateGameKit
	{
		public static const VERSION:String = "1.0.0";
		
		private static var _sameDomain:Boolean = true;
		public static function get SAME_DOMAIN():Boolean { return _sameDomain; }
		
		private static var _stage:Stage;
		public static function get STAGE():Stage { return _stage; }
		
		private static var _resRoot:String = "http://127.0.0.1/";
		public static function get RES_ROOT():String { return _resRoot; }
		
		private static var _readyCallback:Function = null;
		
		
		/** 地图有效点击的间隔毫秒数 */
		public static function get MAP_CLICK_INTERVAL():int { return 200; }
		
		public function FateGameKit()
		{
		}
		
		public static function install(stage:Stage, sameDomain:Boolean, resRoot:String, readyCallback:Function=null):void
		{
			_stage = stage;
			_sameDomain = sameDomain;
			_resRoot = resRoot;
			_readyCallback = readyCallback;
			
			MapFacade.getInstance().initialize();
			AvatarFacade.getInstance().initialize();
			
			Layer.setup(_stage);
			
			_stage.addEventListener(Event.ENTER_FRAME, __nextFrame);
			
			AvatarPreRes.initialize(_readyCallback);
		}
		
		private static function __nextFrame(e:Event):void
		{
			AvatarFacade.getInstance().nextFrame();
			MapFacade.getInstance().nextFrame();
		}
		
		/** 是否开启地图阻碍点调试模式 */
		public static var MAP_BLOCK_DEBUG:Boolean = false;
		/** 是否开启Avatar监控模式 */
		public static var AVATAR_MONITOR_DEBUG:Boolean = true;
		
	}
}