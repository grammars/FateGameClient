package com.anstu.jload.past
{
	import com.anstu.jcommon.log.Log;
	
	import flash.display.LoaderInfo;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;

	public class LoaderKit
	{
		private static var _me:LoaderKit;
		public static function get me():LoaderKit
		{
			if(_me == null) { _me = new LoaderKit(); }
			return _me;
		}
		
		private var questQueue:Vector.<LoaderQuest>;
		
		private var Locked:Boolean = false;
		
		/** 最大尝试次数[默认为3] */
		public var MaxTry:int = 3;
		
		public function LoaderKit()
		{
			questQueue = new Vector.<LoaderQuest>();
		}
		
		/** 加载 */
		public function load(quest:LoaderQuest, loadNow:Boolean=true):void
		{
			questQueue.push(quest);
			if(loadNow)
			{
				runQueue();
			}
		}
		
		/** 运行等待的加载队列 */
		public function runQueue():void
		{
			if(questQueue.length > 0)
			{
				var quest:LoaderQuest = questQueue.shift();
				if(quest.reqType == LoadTarType.APP_DOMAIN)
				{
					loadForDomain(quest);
				}
				else if(quest.reqType == LoadTarType.DIS_CONTENT)
				{
					loadForContent(quest);
				}
				else
				{
					loadForData(quest);
				}
			}
		}
		
		/** loadForDomain */
		private function loadForDomain(quest:LoaderQuest):void
		{
			var loader:RichLoader = new RichLoader();
			loader.quest = quest;
			if(quest.onComplete != null)
			{
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, domainLoaded);
			}
			if(quest.onLoading != null)
			{
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, domainLoading);
			}
			if(quest.onIOError != null)
			{
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, domainLoadError);
			}
			var context:LoaderContext = new LoaderContext(true, new ApplicationDomain(ApplicationDomain.currentDomain));
			if(quest.inSameDomain == false)
			{
				context.securityDomain = SecurityDomain.currentDomain;
			}
			loader.load(new URLRequest(quest.addr), context);
		}
		
		/** domainLoaded */
		private function domainLoaded(event:Event):void
		{
			var loader:RichLoader = LoaderInfo(event.target).loader as RichLoader;
			removeDomainListen(loader);
			var result:LoadResult = new LoadResult();
			result.domain = loader.contentLoaderInfo.applicationDomain;
			result.args = loader.quest.args;
			loader.quest.onComplete.call(loader.quest.owner, result);
			Locked = false;
			if(questQueue.length > 0)
			{
				runQueue();
			}
		}
		
		/** domainLoading */
		private function domainLoading(event:ProgressEvent):void
		{
			var loader:RichLoader = LoaderInfo(event.target).loader as RichLoader;
			var result:LoadResult = new LoadResult();
			result.bytesLoaded = event.bytesLoaded;
			result.bytesTotal = event.bytesTotal;
			result.args = loader.quest.args;
			loader.quest.onLoading.call(loader.quest.owner, result);
		}
		
		/** domainLoadError */
		private function domainLoadError(event:IOErrorEvent):void
		{
			Locked = false;
			var loader:RichLoader = LoaderInfo(event.target).loader as  RichLoader;
			removeDomainListen(loader);
			var result:LoadResult = new LoadResult();
			result.args = loader.quest.args;
			loader.quest.onIOError.call(loader.quest.owner, result);
			loader.quest.tryTimes++;
			Log.error("加载", loader.quest.addr, "失败，失败次数", loader.quest.tryTimes);
			if(questQueue.length > 0)
			{
				runQueue();
			}
			if(loader.quest.tryTimes >= MaxTry)
			{
				Log.error("放弃加载", loader.quest.addr, "失败次数超过限定", MaxTry);
			}
			else
			{
				questQueue.push(loader.quest);
			}
		}
		
		
		/** loadForContent */
		private function loadForContent(quest:LoaderQuest):void
		{
			var loader:RichLoader = new RichLoader();
			loader.quest = quest;
			if(quest.onComplete != null)
			{
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaded);
			}
			if(quest.onLoading != null)
			{
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, contentLoading);
			}
			if(quest.onIOError != null)
			{
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, contentLoadError);
			}
			var context:LoaderContext = new LoaderContext(true);
			if(quest.inSameDomain == false)
			{
				//context.securityDomain = SecurityDomain.currentDomain;
			}
			loader.load(new URLRequest(quest.addr), context);
		}
		
		/** contentLoaded */
		private function contentLoaded(event:Event):void
		{
			var loader:RichLoader = LoaderInfo(event.target).loader as RichLoader;
			removeContentListen(loader);
			var result:LoadResult = new LoadResult();
			result.content = loader.content;
			result.args = loader.quest.args;
			loader.quest.onComplete.call(loader.quest.owner, result);
			Locked = false;
			if(questQueue.length > 0)
			{
				runQueue();
			}
		}
		
		/** contentLoading */
		private function contentLoading(event:ProgressEvent):void
		{
			var loader:RichLoader = LoaderInfo(event.target).loader as RichLoader;
			var result:LoadResult = new LoadResult();
			result.bytesLoaded = event.bytesLoaded;
			result.bytesTotal = event.bytesTotal;
			result.args = loader.quest.args;
			loader.quest.onLoading.call(loader.quest.owner, result);
		}
		
		/** contentLoadError */
		private function contentLoadError(event:IOErrorEvent):void
		{
			Locked = false;
			var loader:RichLoader = LoaderInfo(event.target).loader as  RichLoader;
			removeContentListen(loader);
			var result:LoadResult = new LoadResult();
			result.args = loader.quest.args;
			loader.quest.onIOError.call(loader.quest.owner, result);
			loader.quest.tryTimes++;
			Log.error("加载", loader.quest.addr, "失败，失败次数", loader.quest.tryTimes);
			if(questQueue.length > 0)
			{
				runQueue();
			}
			if(loader.quest.tryTimes >= MaxTry)
			{
				Log.error("放弃加载", loader.quest.addr, "失败次数超过限定", MaxTry);
			}
			else
			{
				questQueue.push(loader.quest);
			}
		}
		
		
		/** 加载数据系资源 */
		private function loadForData(quest:LoaderQuest):void
		{
			var loader:DataLoader = new DataLoader();
			loader.dataFormat = quest.reqType;
			loader.quest = quest;
			if(quest.onComplete != null)
			{
				loader.addEventListener(Event.COMPLETE, dataLoaded);
			}
			if(quest.onLoading != null)
			{
				loader.addEventListener(ProgressEvent.PROGRESS, dataLoading);
			}
			if(quest.onIOError != null)
			{
				loader.addEventListener(IOErrorEvent.IO_ERROR, dataLoadError);
			}
			loader.load(new URLRequest(quest.addr));
		}
		
		/** dataLoaded */
		private function dataLoaded(event:Event):void
		{
			var loader:DataLoader = event.target as DataLoader;
			removeDataListen(loader);
			var result:LoadResult = new LoadResult();
			result.data = loader.data;
			result.args = loader.quest.args;
			loader.quest.onComplete.call(loader.quest.owner, result);
			Locked = false;
			if(questQueue.length > 0)
			{
				runQueue();
			}
		}
		
		/** dataLoading */
		private function dataLoading(event:ProgressEvent):void
		{
			var loader:DataLoader = event.target as DataLoader;
			var result:LoadResult = new LoadResult();
			result.bytesLoaded = event.bytesLoaded;
			result.bytesTotal = event.bytesTotal;
			result.args = loader.quest.args;
			loader.quest.onLoading.call(loader.quest.owner, result);
		}
		
		/** dataLoadError */
		private function dataLoadError(event:IOErrorEvent):void
		{
			Locked = false;
			var loader:DataLoader = event.target as DataLoader;
			removeDataListen(loader);
			var result:LoadResult = new LoadResult();
			result.args = loader.quest.args;
			loader.quest.onIOError.call(loader.quest.owner, result);
			loader.quest.tryTimes++;
			Log.error("加载", loader.quest.addr, "失败，失败次数", loader.quest.tryTimes);
			if(questQueue.length > 0)
			{
				runQueue();
			}
			if(loader.quest.tryTimes >= MaxTry)
			{
				Log.error("放弃加载", loader.quest.addr, "失败次数超过限定", MaxTry);
			}
			else
			{
				questQueue.push(loader.quest);
			}
		}
		
		
		/** 移除Domain-Loader的监听 */
		private function removeDomainListen(loader:RichLoader):void
		{
			if(loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, domainLoaded);
			}
			if(loader.contentLoaderInfo.hasEventListener(ProgressEvent.PROGRESS))
			{
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, domainLoading);
			}
			if(loader.contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR))
			{
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, domainLoadError);
			}
		}
		
		/** 移除Content-Loader的监听 */
		private function removeContentListen(loader:RichLoader):void
		{
			if(loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, contentLoaded);
			}
			if(loader.contentLoaderInfo.hasEventListener(ProgressEvent.PROGRESS))
			{
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, contentLoading);
			}
			if(loader.contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR))
			{
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, contentLoadError);
			}
		}
		
		/** 移除DataLoader的监听 */
		private function removeDataListen(loader:DataLoader):void
		{
			if(loader.hasEventListener(Event.COMPLETE))
			{
				loader.removeEventListener(Event.COMPLETE, dataLoaded);
			}
			if(loader.hasEventListener(ProgressEvent.PROGRESS))
			{
				loader.removeEventListener(ProgressEvent.PROGRESS, dataLoading);
			}
			if(loader.hasEventListener(IOErrorEvent.IO_ERROR))
			{
				loader.removeEventListener(IOErrorEvent.IO_ERROR, dataLoadError);
			}
		}
		
	}
}