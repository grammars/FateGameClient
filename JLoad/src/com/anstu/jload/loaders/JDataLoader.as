package com.anstu.jload.loaders
{
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	public class JDataLoader extends JBaseLoader
	{
		public var loader:URLLoader = new URLLoader();
		
		public function JDataLoader(task:JLoadTask, leader:JLoader)
		{
			super(task, leader);
		}
		
		override public function load():void
		{
			super.load();
			
			switch(task.type)
			{
			case JLoadTask.TYPE_DATA_BINARY:
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				break;
			case JLoadTask.TYPE_DATA_TEXT:
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				break;
			case JLoadTask.TYPE_DATA_VARIABLES:
				loader.dataFormat = URLLoaderDataFormat.VARIABLES;
				break;
			case JLoadTask.TYPE_DATA_XML:
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				break;
			default:
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				break;
			}
			loader.addEventListener(ProgressEvent.PROGRESS, __progressHandler, false, 0, true);
			loader.addEventListener(Event.COMPLETE, __completeHandler, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler, false, 0, false);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __securityErrorHandler, false, 0, false);

			if(task.onOpen != null)
			{
				loader.addEventListener(Event.OPEN, __openHandler, false, 0, true); 
			}
			if(task.onHttpStatus != null)
			{
				loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, __httpStatusHandler, false, 0, true);
			}
			
			loader.load(new URLRequest(task.url));
		}
		
		override public function unload():void
		{
			loader.close();
			super.unload();
		}
		
		override protected function clean():void
		{
			loader.removeEventListener(ProgressEvent.PROGRESS, __progressHandler, false);
			loader.removeEventListener(Event.COMPLETE, __completeHandler, false);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler, false);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, __securityErrorHandler, false);
			
			loader.removeEventListener(Event.OPEN, __openHandler, false); 
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, __httpStatusHandler, false);
		}
		
		override protected function handleResult():void
		{
			super.handleResult();
			switch(task.type)
			{
				case JLoadTask.TYPE_DATA_BINARY:
					task.result.value = ByteArray(loader.data);
					break;
				case JLoadTask.TYPE_DATA_TEXT:
					task.result.value = new String(loader.data);
					break;
				case JLoadTask.TYPE_DATA_VARIABLES:
					task.result.value = new URLVariables(loader.data);
					break;
				case JLoadTask.TYPE_DATA_XML:
					task.result.value = new XML(loader.data);
					break;
				default:
					task.result.value = loader.data;
					break;
			}
		}
		
	}
}