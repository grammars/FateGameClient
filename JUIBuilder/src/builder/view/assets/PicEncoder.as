package builder.view.assets
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class PicEncoder
	{
		public static const MIN_QUALITY:int = 10;
		public static const MAX_QUALITY:int = 100;
		public static const DEFAULT_QUALITY:int = 80;
		
		private static var _instance:PicEncoder;
		public static function get instance():PicEncoder
		{
			if(_instance == null) { _instance = new PicEncoder(); }
			return _instance;
		}
		
		private var core:JPGEncoder;
		
		public function PicEncoder()
		{
			changeQuality(DEFAULT_QUALITY);
		}
		
		public function changeQuality(q:int):void
		{
			core = new JPGEncoder(q);
		}
		
		public function encode(bmd:BitmapData):ByteArray
		{
			return core.encode(bmd);
		}
		
	}
}