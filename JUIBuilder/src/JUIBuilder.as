package
{
	import builder.Builder;
	import builder.BuilderCfg;
	import builder.FontCfg;
	import builder.view.MenuBar;
	import builder.view.PropBox;
	import builder.view.StatusBar;
	import builder.view.ToolBox;
	import builder.view.UIBox;
	import builder.view.UICanvas;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.skin.JPushButtonSkin;
	
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
	
	public class JUIBuilder extends Sprite
	{
		public function JUIBuilder()
		{
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = 0;
			stage.nativeWindow.width = Capabilities.screenResolutionX * 0.9;
			stage.nativeWindow.height = Capabilities.screenResolutionY * 0.9;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Builder.root = this;
			Builder.stage = stage;
			Builder.initialize();
			BuilderCfg.setup();
			FontCfg.setup();
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
			
			this.addChild(MenuBar.instance);
			this.addChild(UIBox.instance);
			this.addChild(ToolBox.instance);
			this.addChild(UICanvas.instance);
			this.addChild(PropBox.instance);
			this.addChild(StatusBar.instance);
			
			stage.addEventListener(Event.RESIZE, putPos);
			putPos();
			
			Builder.setup();
		}
		
		private function putPos(e:Event=null):void
		{
			MenuBar.instance.x = 0;
			MenuBar.instance.y = 0;
			UIBox.instance.x = 0;
			UIBox.instance.y = MenuBar.instance.H;
			ToolBox.instance.x = 0;
			ToolBox.instance.y = Builder.stage.stageHeight - ToolBox.instance.H - StatusBar.instance.H;
			UICanvas.instance.x = UIBox.instance.W;
			UICanvas.instance.y = MenuBar.instance.H;
			StatusBar.instance.x = 0;
			StatusBar.instance.y = Builder.stage.stageHeight - StatusBar.instance.H;
			
			PropBox.instance.x = Builder.stage.stageWidth - PropBox.instance.width;
			PropBox.instance.y = (Builder.stage.stageHeight - PropBox.instance.height)/2;
		}
		
	}
}