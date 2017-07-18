package controller
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import model.MapConfig;
	import model.WorkConfig;
	
	import view.AlertWnd;

	public class MainCtrl
	{
		private static var _me:MainCtrl;
		public static function me():MainCtrl
		{
			if(_me == null) { _me = new MainCtrl(); }
			return _me;
		}
		
		public function MainCtrl()
		{
		}
		
		public function loadWorkSpace():void
		{
			var metaLoader:URLLoader = new URLLoader();
			metaLoader.addEventListener(IOErrorEvent.IO_ERROR, __metaError);
			metaLoader.addEventListener(Event.COMPLETE, __metaLoaded);
			var metaUrl:URLRequest = new URLRequest( WorkConfig.me().getMapSpaceDir() + "\\metadata" );
			metaLoader.load(metaUrl);
		}
		
		private function __metaError(e:IOErrorEvent):void
		{
			trace("__metaError");
			AlertWnd.me().show("无效的工作空间");
		}
		
		private function __metaLoaded(e:Event):void
		{
			trace("__metaLoaded");
			var l:URLLoader = (e.target) as URLLoader;
			var content:String = new String(l.data);
			WorkConfig.me().decode(content);
			if(WorkConfig.me().isLegal())
			{
				MapPicCtrl.me().loadMapPic();
			}
			else
			{
				clearWorkSpace();
				AlertWnd.me().show("无效的工作空间");
			}
		}
		
		public function clearWorkSpace():void
		{
			WorkConfig.me().clear();
			MapPicCtrl.me().clear();
			MapConfig.me().uninstall();
		}
		
		public function saveWorkSpace():void
		{
			var OF:File = new File(WorkConfig.me().getMapSpaceDir() + "\\metadata");
			var OFS:FileStream = new FileStream();
			OFS.open(OF, FileMode.WRITE);
			OFS.writeMultiByte(WorkConfig.me().encode(), "UTF-8");
			OFS.close();
		}
		
		public function saveMapConfig():void
		{
			if(WorkConfig.me().isLegal())
			{
				var OF:File = new File(WorkConfig.me().getMapSpaceDir() + "\\" + WorkConfig.me().getMapId() + ".map");
				var OFS:FileStream = new FileStream();
				OFS.open(OF, FileMode.WRITE);
				OFS.writeBytes(MapConfig.me().encode());
				OFS.close();
			}
			else
			{
				AlertWnd.me().show("无效的保存命令");
			}
		}
		
	}
}