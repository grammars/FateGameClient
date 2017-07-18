package central
{
	import cfg.CfgManage;
	
	import flash.display.Stage;
	
	import gamekit.FateGameKit;
	import gamekit.avatar.AvatarFacade;
	import gamekit.map.MapFacade;
	import gamekit.map.deco.MapDecorator;
	
	import keyboard.KeyManage;
	
	import mouse.MouseManage;
	
	import net.NetManage;
	
	import run.RunManage;
	
	import test.TestManage;
	
	import ui.UIManage;
	

	public class Centre
	{
		public static const VERSION:String = "1.6.10";
		
		private static var _stage:Stage;
		public static function get stage():Stage { return _stage; }
		
		public static function get stageW():int { return _stage.stageWidth; }
		public static function get stageH():int { return _stage.stageHeight; }
		public static function get mouseX():Number { return _stage.mouseX; }
		public static function get mouseY():Number { return _stage.mouseY; }
		
		/** 获取基础资源路径
		 * http://192.168.1.109/classicgame/ */
		public static function get RES_ROOT():String
		{
			return "http://192.168.1.100/classicgame/";
		}
		
		/** 文件目录分隔符,即斜杠 */
		public static const FS:String = "/";
		
		/** 配置 */
		public static var CFG:CfgManage;
		/** UI */
		public static var UI:UIManage;
		/** 网络 */
		public static var NET:NetManage;
		/** 游戏逻辑 */
		public static var RUN:RunManage;
		/** 键盘 */
		public static var KEY:KeyManage;
		/** 鼠标 */
		public static var MOUSE:MouseManage;
		/** 测试 */
		public static var TEST:TestManage;
		
		public function Centre()
		{
		}
		
		public static function startup(stg:Stage, sameDomain:Boolean):void
		{
			_stage = stg;
			
			FateGameKit.install(Centre.stage, sameDomain, RES_ROOT, __kitReady);
		}
		
		private static function __kitReady():void
		{
			CFG = new CfgManage();
			UI = new UIManage();
			NET = new NetManage();
			RUN = new RunManage();
			KEY = new KeyManage();
			MOUSE = new MouseManage();
			TEST = new TestManage();
			
			CFG.startupCompleteCallback = UI.startup;
			UI.startupCompleteCallback = NET.startup;
			NET.startupCompleteCallback = RUN.startup;
			RUN.startupCompleteCallback = KEY.startup;
			KEY.startupCompleteCallback = MOUSE.startup;
			MOUSE.startupCompleteCallback = TEST.startup;
			CFG.startup();
		}
		
	}
}