package ui
{
	import central.AbstractManage;
	import central.Centre;
	import central.View;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jload.JLoadEvent;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.build.pack.PackItem;
	import com.anstu.jui.build.pack.PackTool;
	
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	
	import gamekit.FateGameKit;
	
	import res.PreRes;
	import res.Res;
	
	import ui.res.UILoader;
	import ui.view.chatBox.ChatBoxPane;
	import ui.view.debug.ActionDebugger;
	import ui.view.heroCorner.HeroCornerPane;
	import ui.view.mapRadar.MapRadarPane;
	import ui.view.operate.OperPane;
	import ui.view.topTar.TopTarPane;
	
	/** 管理UI */
	public class UIManage extends AbstractManage
	{
		private static function get NS():String { return Res.NS; }
		
		private var templatesItems:Vector.<PackItem>;
		private var docsItems:Vector.<PackItem>;
		private var assetsXml:XML;
		private var assetsDomain:ApplicationDomain;
		
		public function UIManage()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			Log.print("UIManage::startup()");
			super.startup();
			
			PreRes.load(loadUiTxt);
			
			UILoader.instance.load();
		}
		
		private function loadUiTxt():void
		{
			var jl:JLoader = new JLoader();
			var templatesTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_BINARY, Centre.RES_ROOT+"ui/"+NS+"_templates.zlib", FateGameKit.SAME_DOMAIN);
			templatesTask.onComplete = __templatesLoaded;
			var docsTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_BINARY, Centre.RES_ROOT+"ui/"+NS+"_docs.zlib", FateGameKit.SAME_DOMAIN);
			docsTask.onComplete = __docsLoaded;
			jl.add(templatesTask);
			jl.add(docsTask);
			jl.addEventListener(JLoadEvent.FINISH, __txtLoaded);
			jl.start();
		}
		
		private function __templatesLoaded(task:JLoadTask):void
		{
			templatesItems = PackTool.decode(task.result.getBinary());
		}
		
		private function __docsLoaded(task:JLoadTask):void
		{
			docsItems = PackTool.decode(task.result.getBinary());
		}
		
		private function __txtLoaded(e:JLoadEvent):void
		{
			(e.target as JLoader).removeEventListener(JLoadEvent.FINISH, __txtLoaded);
			JFactory.regTemplates(templatesItems, NS);
			JFactory.regDocs(docsItems, NS);
			
			setupView();
			startupComplete();
			
			var jl:JLoader = new JLoader();
			var assetsXmlTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_BINARY, Centre.RES_ROOT+"ui/"+NS+"_assets.zlib", FateGameKit.SAME_DOMAIN);
			assetsXmlTask.onComplete = __assetsXmlLoaded;
			var assetsSwfTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_CLASS_DOMAIN, Centre.RES_ROOT+"ui/"+NS+"_assets.swf", FateGameKit.SAME_DOMAIN);
			assetsSwfTask.onComplete = __assetsSwfLoaded;
			jl.add(assetsXmlTask);
			jl.add(assetsSwfTask);
			jl.addEventListener(JLoadEvent.FINISH, __assetsLoaded);
			jl.start();
		}
		
		private function __assetsXmlLoaded(task:JLoadTask):void
		{
			var bytes:ByteArray = task.result.getBinary();
			bytes.uncompress();
			var content:String = bytes.readMultiByte(bytes.bytesAvailable, "UTF-8");
			assetsXml = XML(content);
		}
		
		private function __assetsSwfLoaded(task:JLoadTask):void
		{
			assetsDomain = task.result.getDomain();
		}
		
		private function __assetsLoaded(e:JLoadEvent):void
		{
			(e.target as JLoader).removeEventListener(JLoadEvent.FINISH, __assetsSwfLoaded);
			JResource.add(assetsXml, assetsDomain);
		}
		
		/** 设置View */
		private function setupView():void
		{
			View.startup();
		}
		
		public function showBaseUI():void
		{
			View.operPane.show();
			View.heroCornerPane.show();
			View.chatBoxPane.show();
			View.mapRadarPane.show();
		}
		
		public function hideBaseUI():void
		{
			View.operPane.hide();
			View.heroCornerPane.hide();
			View.topTarPane.hide();
			View.chatBoxPane.hide();
			View.mapRadarPane.hide();
		}
		
	}
}