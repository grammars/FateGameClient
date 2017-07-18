package ui.res
{
	import central.Centre;
	
	import com.anstu.jload.JLoadEvent;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	import com.anstu.jui.assets.JResource;
	
	import gamekit.FateGameKit;

	public class UILoader
	{
		private static var _instance:UILoader;
		public static function get instance():UILoader
		{
			if(_instance == null) { _instance = new UILoader(); }
			return _instance;
		}
		
		private const UI_RES_XML_URLS:Array = [];//["default_uir.xml", "base_uir.xml", "plugin_uir.xml"];
		private var taskPacks:Array = new Array();
		
		public function UILoader()
		{
			//
		}
		
		public function load():void
		{
			var xmlLoader:JLoader = new JLoader();
			for(var i:int = 0; i < UI_RES_XML_URLS.length; i++)
			{
				var url:String = Centre.RES_ROOT + "uir/" +  UI_RES_XML_URLS[i];
				var task:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_XML, url, FateGameKit.SAME_DOMAIN);
				task.onComplete = __xmlLoaded;
				xmlLoader.add(task);
			}
			xmlLoader.start();
		}
		
		private function __xmlLoaded(t:JLoadTask):void
		{
			var xml:XML = t.result.getXML();
			var ns:String = xml.property.@ns;
			var url:String = xml.property.@url;
			var swfUrl:String = Centre.RES_ROOT + "uir/" + url;
			taskPacks.push([ns,swfUrl,xml]);
			
			var swfLoader:JLoader = new JLoader();
			var swfTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_CLASS_DOMAIN, swfUrl, FateGameKit.SAME_DOMAIN);
			swfTask.onComplete = __swfLoaded;
			swfLoader.add(swfTask);
			swfLoader.start();
		}
		
		private function __swfLoaded(t:JLoadTask):void
		{
			for(var i:int = 0; i < taskPacks.length; i++)
			{
				var pack:Array = taskPacks[i];
				if(t.url == pack[1])
				{
					JResource.add(pack[2], t.result.getDomain());
					break;
				}
			}
		}
		
	}
}