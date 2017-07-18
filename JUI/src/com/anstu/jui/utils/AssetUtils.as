package com.anstu.jui.utils
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class AssetUtils
	{
		private var domain:ApplicationDomain;
		private var loadedBack:Function;
		private var loadErrBack:Function;
		
		public function AssetUtils()
		{
		}
		
		public function load(addr:String, loadedBack:Function=null, loadErrBack:Function=null):void
		{
			this.loadedBack = loadedBack;
			this.loadErrBack = loadErrBack;
			var l:Loader = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, __loaded);
			l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __loadErr);
			var c:LoaderContext = new LoaderContext(true, new ApplicationDomain(ApplicationDomain.currentDomain));
			var u:URLRequest = new URLRequest(addr);
			l.load(u, c);
		}
		
		private function __loaded(e:Event):void
		{
			var l:Loader = e.target.loader as Loader;
			l.contentLoaderInfo.removeEventListener(Event.COMPLETE, __loaded);
			l.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
			domain = l.contentLoaderInfo.applicationDomain;
			if(loadedBack != null) { loadedBack(); }
		}
		
		private function __loadErr(e:IOErrorEvent):void
		{
			var l:Loader = e.target.loader as Loader;
			l.contentLoaderInfo.removeEventListener(Event.COMPLETE, __loaded);
			l.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, __loadErr);
			if(loadErrBack != null) { loadErrBack(); }
		}
		
		public function getBmd(linkName:String):BitmapData
		{
			if(domain.hasDefinition(linkName))
			{
				var Clazz:Class = domain.getDefinition(linkName) as Class;
				return new Clazz(0,0) as BitmapData;
			}
			return null;
		}
		
	}
}