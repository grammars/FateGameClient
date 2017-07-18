package gamekit.avatar.res
{
	import com.anstu.jload.JLoadEvent;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import gamekit.FateGameKit;
	import gamekit.debug.AvtMonitor;

	public class AvatarPreRes
	{
		private static var loadedCallback:Function = null;
		
		
		/** 脚下阴影 */
		public static function get shadow():BitmapData { return _shadow; }
		private static var _shadow:BitmapData;
		private static function get shadowTask():JLoadTask
		{
			var url:String = FateGameKit.RES_ROOT + "loading/shadow.png";
			var task:JLoadTask = new JLoadTask(JLoadTask.TYPE_DISPLAY_CONTENT, url, FateGameKit.SAME_DOMAIN);
			task.onComplete = __shadowLoaded;
			task.onSecurityError = __loadFailed;
			return task;
		}
		private static function __shadowLoaded(t:JLoadTask):void
		{
			_shadow = t.result.getBmp().bitmapData;
		}
		
		
		/** 角色预替身 */
		public static function get preAvatar():BitmapData { return _preAvatar; }
		private static var _preAvatar:BitmapData;
		private static function get preAvatarTask():JLoadTask
		{
			var url:String = FateGameKit.RES_ROOT + "loading/preAvatar.png";
			var task:JLoadTask = new JLoadTask(JLoadTask.TYPE_DISPLAY_CONTENT, url, FateGameKit.SAME_DOMAIN);
			task.onComplete = __preAvatarLoaded;
			task.onSecurityError = __loadFailed;
			return task;
		}
		private static function __preAvatarLoaded(t:JLoadTask):void
		{
			_preAvatar = t.result.getBmp().bitmapData;
		}
		
		/** 角色选中 */
		public static function get avtSelect():BitmapData { return _avtSelect; }
		private static var _avtSelect:BitmapData;
		private static function get avtSelectTask():JLoadTask
		{
			var url:String = FateGameKit.RES_ROOT + "loading/avtSelect.png";
			var task:JLoadTask = new JLoadTask(JLoadTask.TYPE_DISPLAY_CONTENT, url, FateGameKit.SAME_DOMAIN);
			task.onComplete = __avtSelectLoaded;
			task.onSecurityError = __loadFailed;
			return task;
		}
		private static function __avtSelectLoaded(t:JLoadTask):void
		{
			_avtSelect = t.result.getBmp().bitmapData;
		}
		
		private static function __loadFailed(t:JLoadTask):void
		{
			AvtMonitor.getInstance().setMessage("AvatarPreRes.__loadFailed\n"+t.url+"\n"+t.message);
		}
		
		public function AvatarPreRes()
		{
		}
		
		public static function initialize(pLoadedCallback:Function=null):void
		{
			AvtMonitor.getInstance().setMessage("AvatarPreRes.initialize");
			loadedCallback = pLoadedCallback;
			
			var loader:JLoader = new JLoader();
			loader.addEventListener(JLoadEvent.FINISH, __loadedAll);
			loader.add(preAvatarTask);
			loader.add(shadowTask);
			loader.add(avtSelectTask);
			loader.start();
		}
		
		
		private static function __loadedAll(e:JLoadEvent):void
		{
			var loader:JLoader = e.currentTarget as JLoader;
			loader.removeEventListener(JLoadEvent.FINISH, __loadedAll);
			if(null != loadedCallback)
			{
				loadedCallback();
				loadedCallback = null;
			}
		}
		
	}
}