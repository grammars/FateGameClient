package res
{
	import central.Centre;
	
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import gamekit.utils.StrUtils;

	public class Res
	{
		/** ui资源包最主要的命名空间 */
		public static const NS:String = "fate";
		
		/** 包装资源URL */
		public static function URL(ru:String):String
		{
			return Centre.RES_ROOT + ru;
		}
		
		/** 判断资源字符串是否属于空的情况 */
		public static function isNull(str:String):Boolean
		{
			if(str == null) { return true; }
			if(str == "") { return true; }
			if(str == "null" || str == "NULL" || str == "Null") { return true; }
			return false;
		}
		
		private static var loader:JLoader = new JLoader(4);
		
		public function Res()
		{
		}
		
		private static var taskCache:Dictionary = new Dictionary();
		
		public static function fillIcon(bmp:Bitmap, filePath:String, __onComplete:Function=null):void
		{
			var url:String = Centre.RES_ROOT + "/icon/" + filePath;
			var task:ResTask = new ResTask(JLoadTask.TYPE_DISPLAY_CONTENT, url);
			task.__onComplete = __onComplete;
			task.bmpToFill = bmp;
			task.onComplete = __fillIcon;
			taskCache[task]
			loader.add(task);
			loader.start();
		}
		
		private static function __fillIcon(task:JLoadTask):void
		{
			var rt:ResTask = task as ResTask;
			if(rt)
			{
				if(rt.bmpToFill) { rt.bmpToFill.bitmapData = rt.result.getBmp().bitmapData; }
				if(rt.__onComplete != null) { rt.__onComplete(); }
			}
		}
		
	}
}