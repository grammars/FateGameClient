package com.anstu.jload.loaders
{
	import com.anstu.jcommon.log.LogUtils;
	import com.anstu.jload.JLoadLog;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	import com.anstu.jload.struct.JVideoMetaData;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetDataEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.getTimer;
	
	public class JVideoLoader extends JBaseLoader
	{
		private var nc:NetConnection;
		private var stream:NetStream;
		private var dummyEventTrigger:Sprite;
		
		private var _bytesTotal:Number = 0;
		private var _bytesLoaded:Number = 0;
		
		public function JVideoLoader(task:JLoadTask, leader:JLoader)
		{
			super(task, leader);
		}
		
		override public function load():void
		{
			super.load();
			nc = new NetConnection();
			nc.connect(null);
			stream = new NetStream(nc);
			addListeners();
			try
			{
				stream.play(task.url, !task.inSameDomain);
			}
			catch(err:SecurityError)
			{
				__securityErrorHandler(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR, false, false, err.message, err.errorID));
			}
			stream.seek(0);
		}
		
		private function addListeners():void
		{
			stream.addEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler, false, 0, true);
			stream.addEventListener(NetStatusEvent.NET_STATUS, __netStatus, false, 0, true);
			stream.addEventListener(NetDataEvent.MEDIA_TYPE_DATA, __mediaTypeData, false, 0, true);
			dummyEventTrigger = new Sprite();
			dummyEventTrigger.addEventListener(Event.ENTER_FRAME, __createNetStreamEvent, false, 0, false);
			var customClient:Object = new Object();
			customClient.onCuePoint = __clientOnCuePoint;
			customClient.onMetaData = __clientOnMetadata;
			customClient.onPlayStatus = __clientOnPlayStatus;
			stream.client = customClient;
		}
		
		private function removeListeners():void
		{
			nc = null;
			if(stream)
			{
				stream.removeEventListener(IOErrorEvent.IO_ERROR, __IOErrorHandler, false);
				stream.removeEventListener(NetStatusEvent.NET_STATUS, __netStatus, false);
				stream.removeEventListener(NetDataEvent.MEDIA_TYPE_DATA, __mediaTypeData, false);
				stream = null;
			}
			if(dummyEventTrigger)
			{
				dummyEventTrigger.removeEventListener(Event.ENTER_FRAME, __createNetStreamEvent, false);
				dummyEventTrigger = null;
			}
		}
		
		private function __mediaTypeData(e:NetDataEvent):void
		{
			//trace("JVideoLoader::__mediaTypeData(e:NetDataEvent) info.handler=", e.info.handler, " args=", e.info.args);
		}
		
		private function __createNetStreamEvent(e:Event):void
		{
			if(_bytesTotal == _bytesLoaded && _bytesTotal > 8)
			{
				removeListeners();
				var ce:Event = new Event(Event.COMPLETE);
				__completeHandler(ce);
			}
			else if(_bytesTotal == 0 && stream && stream.bytesTotal > 4)
			{
				var oe:Event = new Event(Event.OPEN);
				____openHandler(oe);
				_bytesLoaded = stream.bytesLoaded;
				_bytesTotal = stream.bytesTotal;
				
			}
			else if(stream)
			{
				_bytesLoaded = stream.bytesLoaded;
				_bytesTotal = stream.bytesTotal;
				var pe:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS, false, false, _bytesLoaded, _bytesTotal);
				__progressHandler(pe);
			}
		}
		
		
		protected function ____openHandler(evt:Event):void
		{
			task.result.value = stream;
			super.__openHandler(evt);
		}
		
		override protected function clean():void
		{
			removeListeners();
			
			super.clean();
		}
		
		
		private function __netStatus(e:NetStatusEvent):void
		{
			if(!stream)
			{
				return;
			}
			//
			if(e.info.code == "NetStream.Play.Start")
			{
				task.result.value = stream;
				var oe:Event = new Event(Event.OPEN);
				____openHandler(oe);
			}
			else if(e.info.code == "NetStream.Play.StreamNotFound")
			{
				__IOErrorHandler(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, "[JVideoLoader] NetStream not found at " + task.url));
			}
		}
		
		
		internal function __clientOnCuePoint(param:*):void
		{
			//@SupressWarnings(value={"unused"})
		}
		
		internal function __clientOnMetadata(param:*):void
		{
			task.info.videoMetaData = new JVideoMetaData(param);
			if(task.onVideoMetaData != null)
			{
				task.onVideoMetaData(task);
			}
		}
		
		internal function __clientOnPlayStatus(param:*):void
		{
			//@SupressWarnings(value={"unused"})
		}

		override protected function handleResult():void
		{
			super.handleResult();
			task.result.value = stream;
		}
		
	}
}