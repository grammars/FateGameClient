package
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.build.doc.UIPack;
	import com.anstu.jui.build.pack.PackItem;
	import com.anstu.jui.build.pack.PackTool;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JList;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class JUITest extends Sprite
	{
		private var domain:ApplicationDomain;
		
		private var projName:String = "default";
		private var demoDoc:String = "demo";
		
		public function JUITest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			load_assetsSwf();
		}
		
		private function load_assetsSwf():void
		{
			var assetsSwfLoader:Loader = new Loader();
			var assetsSwfUrl:URLRequest = new URLRequest("ui/"+projName+"_assets.swf");
			assetsSwfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, __assetsSwfLoaded);
			var ctx:LoaderContext = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
			assetsSwfLoader.load(assetsSwfUrl, ctx);
		}
		
		private function __assetsSwfLoaded(e:Event):void
		{
			var li:LoaderInfo = e.target as LoaderInfo;
			this.domain = li.applicationDomain;
			
			load_assetsXml();
		}
		
		//--------------------------------------------------------------------------
		
		private function load_assetsXml():void
		{
			var assetsXmlLoader:URLLoader = new URLLoader();
			assetsXmlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			var assetsXmlUrl:URLRequest = new URLRequest("ui/"+projName+"_assets.zlib");
			assetsXmlLoader.addEventListener(Event.COMPLETE, __assetsXmlLoaded);
			assetsXmlLoader.load(assetsXmlUrl);
		}
		
		private function __assetsXmlLoaded(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			var bytes:ByteArray = loader.data as ByteArray;
			bytes.uncompress();
			var content:String = bytes.readMultiByte(bytes.bytesAvailable, "UTF-8");
			var assetsXml:XML = XML(content);
			//trace(assetsXml);
			JResource.add(assetsXml, domain);
			
			//var dis:DisplayObject = JResource.getBmp("bg_paneRect$png", "uidoc");
			//this.addChild(dis);
			
			load_templates();
		}
		
		//--------------------------------------------------------------------------
		
		private function load_templates():void
		{
			var templatesXmlLoader:URLLoader = new URLLoader();
			templatesXmlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			var templatesXmlUrl:URLRequest = new URLRequest("ui/"+projName+"_templates.zlib");
			templatesXmlLoader.addEventListener(Event.COMPLETE, __templatesXmlLoaded);
			templatesXmlLoader.load(templatesXmlUrl);
		}
		
		private function __templatesXmlLoaded(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			var bytes:ByteArray = loader.data as ByteArray;
			
			var items:Vector.<PackItem> = PackTool.decode(bytes);
			//PackTool.dump(items);
			JFactory.regTemplates(items, projName);
			
			load_docs();
		}
		
		//--------------------------------------------------------------------------
		
		private function load_docs():void
		{
			var docsXmlLoader:URLLoader = new URLLoader();
			docsXmlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			var docsXmlUrl:URLRequest = new URLRequest("ui/"+projName+"_docs.zlib");
			docsXmlLoader.addEventListener(Event.COMPLETE, __docsXmlLoaded);
			docsXmlLoader.load(docsXmlUrl);
		}
		
		private function __docsXmlLoaded(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			var bytes:ByteArray = loader.data as ByteArray;
			
			var items:Vector.<PackItem> = PackTool.decode(bytes);
			//PackTool.dump(items);
			JFactory.regDocs(items, projName);
			
			present();
		}
		
		//--------------------------------------------------------------------------
		
		/** 呈现Demo */
		private function present():void
		{
			var p:UIPack = JFactory.create(demoDoc);
			p.addToContainer(this);
			
			var cbx:JComboBox = p.getComboBox("myComboBox");
			cbx.items = ["Test0", "测试1", "テスト2", "테스트3", "IL Test4", 
				"Ensayo5", "اختبار6", "испытания7", "Der test8"];
			
			var list:JList = p.getList("myList");
			list.items = ["Test0", "测试1", "テスト2", "테스트3", "IL Test4", 
				"Ensayo5", "اختبار6", "испытания7", "Der test8"];
		}
		
	}
}