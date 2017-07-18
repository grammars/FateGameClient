package com.anstu.jload.loaders
{
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	public class JDisplayLoader extends JBaseLoader
	{
		protected var loader:Loader = new Loader();
		
		public function JDisplayLoader(task:JLoadTask, leader:JLoader)
		{
			super(task, leader);
		}
		
		override public function load():void
		{
			super.load();
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, __progressHandler, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE , __completeHandler, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler, false, 100, false);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __securityErrorHandler, false, 0, false);
			
			if(task.onOpen != null)
			{
				loader.contentLoaderInfo.addEventListener(Event.OPEN, __openHandler, false, 0, true); 
			}
			if(task.onInit != null)
			{
				loader.contentLoaderInfo.addEventListener(Event.INIT, __initHandler, false, 0, true);
			}
			if(task.onHttpStatus != null)
			{
				loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, __httpStatusHandler, false, 0, true);
			}
			
			var context:LoaderContext = new LoaderContext(!task.inSameDomain, new ApplicationDomain(ApplicationDomain.currentDomain));
			if(task.inSameDomain == false)
			{
				context.securityDomain = SecurityDomain.currentDomain;
			}
			loader.load(new URLRequest(task.url), context);
		}
		
		override protected function handleResult():void
		{
			super.handleResult();
			task.result.value = loader.content;
		}
		
		override protected function clean():void
		{
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, __securityErrorHandler);
			loader.unload();
			loader = null;
		}
		
	}
}