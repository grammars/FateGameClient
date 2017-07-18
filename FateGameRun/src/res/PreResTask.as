package res
{
	import com.anstu.jload.JLoadTask;
	
	import gamekit.FateGameKit;
	
	public class PreResTask extends JLoadTask
	{
		public var tag:String;
		
		public function PreResTask(tag:String, url:String)
		{
			super(JLoadTask.TYPE_DISPLAY_CONTENT, url, FateGameKit.SAME_DOMAIN, 999);
			this.tag = tag;
			this.onComplete = PreRes.picLoaded;
		}
	}
}