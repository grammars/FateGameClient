package res
{
	import central.Centre;
	
	import com.anstu.jload.JLoadEvent;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import gamekit.FateGameKit;

	public class PreRes
	{
		private static var nextFunc:Function;
		
		/** 默认icon */
		public static var icon:BitmapData;
		/** 分割条 */
		public static var split:BitmapData;
		
		public function PreRes()
		{
		}
		
		public static function load(pNextFunc:Function):void
		{
			nextFunc = pNextFunc;
			var jl:JLoader = new JLoader(5);
			jl.add( new PreResTask("icon", Res.URL("icon/default.jpg")) );
			jl.add( new PreResTask("split", Res.URL("uir/pre/split.png")) );
			jl.addEventListener(JLoadEvent.FINISH, __allLoaded);
			jl.start();
		}
		
		public static function picLoaded(task:PreResTask):void
		{
			switch(task.tag)
			{
			case "icon":
				icon = task.result.getBmp().bitmapData;
				break;
			case "split":
				split = task.result.getBmp().bitmapData;
				break;
			}
		}
		
		private static function __allLoaded(e:JLoadEvent):void
		{
			nextFunc();
			nextFunc = null;
		}
		
	}
}