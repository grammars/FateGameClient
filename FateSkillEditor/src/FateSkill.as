package
{
	import com.anstu.jui.assets.JResource;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	
	import ui.MenuBar;
	import ui.StatusBar;
	import ui.GridsCanvas;
	
	public class FateSkill extends Sprite
	{
		public function FateSkill()
		{
			stage.nativeWindow.width = 1000;
			stage.nativeWindow.height = 800;
			stage.nativeWindow.x = (Capabilities.screenResolutionX-stage.nativeWindow.width)/2;
			stage.nativeWindow.y = (Capabilities.screenResolutionY-stage.nativeWindow.height)/2;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//
			Editor.initialize(this, stage);
			//
			loadBaseUiRes();
		}
		
		/** 加载基础资源包 */
		private function loadBaseUiRes():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, __xmlIoError);
			xmlLoader.addEventListener(Event.COMPLETE, __xmlLoaded);
			xmlLoader.load(new URLRequest("default_uir.xml"));
		}
		
		private function __xmlIoError(e:IOErrorEvent):void
		{
			trace("__xmlIoError::" + e.toString());
		}
		private var pluginXml:XML;
		private function __xmlLoaded(e:Event):void
		{
			var xmlLoader:URLLoader = e.target as URLLoader;
			pluginXml = new XML(xmlLoader.data);
			var ns:String = pluginXml.property.@ns;
			var url:String = pluginXml.property.@url;
			var domainLoader:Loader = new Loader();
			var domainReq:URLRequest = new URLRequest(url);
			var domainCtx:LoaderContext = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
			domainLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, __domainLoaded);
			domainLoader.load(domainReq, domainCtx);
		}
		private function __domainLoaded(e:Event):void
		{
			var li:LoaderInfo = e.target as LoaderInfo;
			JResource.add(pluginXml, li.applicationDomain);
			
			Editor.setup();
			
			this.addChild(MenuBar.instance);
			this.addChild(StatusBar.instance);
			this.addChild(Editor.output);
			this.addChild(GridsCanvas.instance);
			
			stage.addEventListener(Event.RESIZE, putPos);
			putPos();
		}
		
		private function putPos(e:Event=null):void
		{
			MenuBar.instance.x = 0;
			MenuBar.instance.y = 0;
			Editor.output.x = Editor.stage.stageWidth - Editor.output.width;
			Editor.output.y = MenuBar.instance.H;
			GridsCanvas.instance.x = 0;
			GridsCanvas.instance.y = MenuBar.instance.H;
			StatusBar.instance.x = 0;
			StatusBar.instance.y = Editor.stage.stageHeight - StatusBar.instance.H;
		}
	}
}