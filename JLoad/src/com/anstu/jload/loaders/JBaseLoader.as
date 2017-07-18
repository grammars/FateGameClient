package com.anstu.jload.loaders
{
	import com.anstu.jload.JLoadLog;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	
	public class JBaseLoader
	{
		/** 指派任务者 */
		protected var leader:JLoader;
		/** 指派的任务 */
		protected var task:JLoadTask;
		
		/** 上一次已加载到的数据  */
		protected var lastBytesLoaded:Number = 0;
		
		public function JBaseLoader(task:JLoadTask, leader:JLoader)
		{
			super();
			this.task = task;
			this.leader = leader;
			this.task.setLoader(this);
		}
		
		/** 创建加载器 */
		public static function createLoader(task:JLoadTask, leader:JLoader):JBaseLoader
		{
			switch(task.type)
			{
			case JLoadTask.TYPE_CLASS_DOMAIN:
				return new JClassLoader(task, leader);
			case JLoadTask.TYPE_DISPLAY_CONTENT:
				return new JDisplayLoader(task, leader);
			case JLoadTask.TYPE_DATA_BINARY:
				return new JDataLoader(task, leader);
			case JLoadTask.TYPE_DATA_TEXT:
				return new JDataLoader(task, leader);
			case JLoadTask.TYPE_DATA_VARIABLES:
				return new JDataLoader(task, leader);
			case JLoadTask.TYPE_DATA_XML:
				return new JDataLoader(task, leader);
			case JLoadTask.TYPE_SOUND:
				return new JSoundLoader(task, leader);
			case JLoadTask.TYPE_VIDEO:
				return new JVideoLoader(task, leader);
			}
			return new JBaseLoader(task, leader);
		}
		
		/** 开始加载 */
		public function load():void
		{
			task.status.started = true;
			task.status.curTry++;
			if(task.onStart != null)
			{
				task.onStart(task);
			}
		}
		
		/** 卸载 */
		public function unload():void
		{
			clean();
		}
		
		/** 清理 */
		protected function clean():void
		{
			leader = null;
			task = null;
		}
		
		protected function __progressHandler(e:ProgressEvent):void
		{
			task.status.bytesLoaded = e.bytesLoaded;
			task.status.bytesTotal = e.bytesTotal;
			var bytesAdded:Number = e.bytesLoaded - lastBytesLoaded;
			lastBytesLoaded = e.bytesLoaded;
			leader.progressHandler(bytesAdded);
			if(task.onProgress != null)
			{
				task.onProgress(task);
			}
		}
		
		protected function __initHandler(e:Event):void
		{
			task.onInit(task);
		}
		
		protected function __openHandler(e:Event):void
		{
			task.onOpen(task);
		}
		
		protected function __httpStatusHandler(e:HTTPStatusEvent):void
		{
			if(e.hasOwnProperty("responseHeaders") &&  e.responseHeaders != null)
			{
				task.status.responseHeaders = e.responseHeaders.concat();
			}
			if(e.hasOwnProperty("responseURL") &&  e.responseURL != null)
			{
				task.status.responseURL = e.responseURL;
			}
			
			task.status.httpStatus = e.status;
			task.onHttpStatus(task);
		}
		
		protected function __completeHandler(e:Event):void
		{
			try
			{
				handleResult();
				task.status.loaded = true;
				if(task.onComplete != null)
				{
					task.onComplete(task);
				}
				leader.completeHandler();
				clean();
			}
			catch(error:SecurityError)
			{
				__securityErrorHandler(null);
			}
		}
		
		protected function handleResult():void
		{
			//
		}
		
		protected function __IOErrorHandler(e:IOErrorEvent):void
		{
			tryAgain();
			if(task.onIOError != null)
			{
				task.onIOError(task);
			}
			leader.IOErrorHandler();
			clean();
		}
		
		protected function __securityErrorHandler(e:SecurityErrorEvent):void
		{
			tryAgain();
			if(task.onSecurityError != null)
			{
				task.message = "errorID="+e;
				task.onSecurityError(task);
			}
			leader.securityErrorHandler();
			clean();
		}
		
		private function tryAgain():void
		{
			if(task.status.curTry >= task.status.maxTry)
			{
				task.status.failed = true;
				if(task.onFail != null)
				{
					task.onFail(task);
				}
			}
			else
			{
				//因失败而变更优先级
				task.priority += task.failPriorityChange;
				leader.add(task);
				JLoadLog.log("task重新加入队列:", task.name, task.uuid, task.url, task.priority);
			}
		}
		
	}
}