package com.anstu.jload.loaders
{
	import com.anstu.jload.JLoadLog;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	public class JSoundLoader extends JBaseLoader
	{
		public var loader:Sound;
		
		public function JSoundLoader(task:JLoadTask, leader:JLoader)
		{
			super(task, leader);
		}
		
		override public function load():void
		{
			super.load();
			
			var context:SoundLoaderContext = new SoundLoaderContext(task.soundBufferTime, !task.inSameDomain);
			loader = new Sound(new URLRequest(task.url), context);
			
			loader.addEventListener(ProgressEvent.PROGRESS, __progressHandler, false, 0, true);
			loader.addEventListener(Event.COMPLETE, __completeHandler, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler, false, 0, false);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __securityErrorHandler, false, 0, false);
			
			if(task.onOpen != null)
			{
				loader.addEventListener(Event.OPEN, __openHandler, false, 0, true); 
			}
			//
			task.result.value = loader;
		}
		
		override public function unload():void
		{
			try
			{
				loader.close();
			}
			catch(err:IOError)
			{
				JLoadLog.log("JSoundLoader::unload() 无法关闭该流，或者该流未打开");
			}
			
			super.unload();
		}
		
		override protected function clean():void
		{
			loader.removeEventListener(ProgressEvent.PROGRESS, __progressHandler, false);
			loader.removeEventListener(Event.COMPLETE, __completeHandler, false);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler, false);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, __securityErrorHandler, false);
			loader.removeEventListener(Event.OPEN, __openHandler, false);
		}
		
		override protected function handleResult():void
		{
			super.handleResult();
		}
		
	}
}