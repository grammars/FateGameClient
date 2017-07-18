package res
{
	import com.anstu.jload.JLoadTask;
	
	import flash.display.Bitmap;
	
	public class ResTask extends JLoadTask
	{
		/** 用于填充的Bitmap */
		public var bmpToFill:Bitmap;
		/** 完成之后的回调 */
		public var __onComplete:Function;
		
		public function ResTask(type:String, url:String, inSameDomain:Boolean=true, priority:int=0)
		{
			super(type, url, inSameDomain, priority);
		}
	}
}