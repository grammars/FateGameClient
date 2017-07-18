package com.anstu.jload
{
	import com.anstu.jload.loaders.JBaseLoader;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="FINISH", type="com.anstu.jload.JLoadEvent")]
	
	[Event(name="PROGRESS", type="com.anstu.jload.JLoadEvent")]
	
	public class JLoader extends EventDispatcher
	{
		/** 版本号 */
		public static const VERSION:String = "JLoader_14_01_27";
		
		/** 最大同时下载任务数 */
		public var maxThreadNum:int = 2;
		/** 当前正在下载的任务数 */
		private var runningThreadNum:int = 0;
		/** 任务队列[优先级大的index小，所以先被取出先启动] */
		private var queue:Vector.<JLoadTask> = new Vector.<JLoadTask>();
		
		/** 已加载到的字节数 */
		private var lastBytesLoaded:Number = 0;
		/** 上次取已加载到的字节数的时间 */
		private var lastGetBytesTime:Number = 0;
		/** 当前速度[Byte/ms] */
		private var speed:Number = 0;
		/** 当前速度[Byte/ms]=[KB/s] */
		public function getSpeed():Number { return speed; }
		/** PROGRESS事件触发最低间隔（ms）,默认100毫秒 */
		public var progressInterval:int = 100;
		
		/** JLoader */
		public function JLoader(maxThreadNum:int=2)
		{
			super();
			this.maxThreadNum = maxThreadNum;
		}
		
		/** 添加加载任务 <br>
		 * add(task); <br>
		 * <b>参数:</b>task:JLoadTask  <br>
		 * 或者 <br>
		 * add(type,url,inSameDomain); <br>
		 * <b>参数:</b> type:String 如JLoadTask.TYPE_DISPLAY_CONTENT <br>
		 * <b>参数:</b> url:String 资源地址 <br>
		 * <b>参数:</b> inSameDomain:Boolean=true 是否在同一个域 <br>
		 * <b>参数:</b> priority:int=0  优先级 */
		public function add(...args):JLoadTask
		{
			if(args == null || args.length <= 0)
			{
				throw new Error("参数个数不正确,至少应该为一个");
			}
			var task:JLoadTask = null;
			if(args.length == 1)
			{
				task = args[0];
			}
			else
			{
				var inSameDomain:Boolean = true;
				var priority:int = 0;
				if(args.length > 2)
				{
					inSameDomain = args[2];
				}
				if(args.length > 3)
				{
					priority = args[3];
				}
				task = new JLoadTask(args[0], args[1], inSameDomain, priority);
			}
			insertToQueue(task);
			return task;
		}
		
		private function insertToQueue(task:JLoadTask):void
		{
			var inserted:Boolean = false;
			for(var i:int = 0; i < queue.length; i++)
			{
				if(task.priority > queue[i].priority)
				{
					queue.splice(i, 0, task);
					inserted = true;
					break;
				}
			}
			if(inserted == false)
			{
				queue.push(task);
			}
		}
		
		/** 启动加载任务<br>
		 * 并不是不主动调用就不会启动，如果加载队列中尚存在未启动的任务项，
		 * 则在当前运行的任务项完成的时候，也会被调用start() <br>
		 * 这就意味着在queue中的任务都有被唤醒的可能 */
		public function start():void
		{
			lastGetBytesTime = new Date().time;
			while(runTask())
			{
				JLoadLog.log("启动了一个新任务");
			}
		}
		
		/** 启动任务 */
		private function runTask():Boolean
		{
			if(runningThreadNum < maxThreadNum)
			{
				if(queue.length > 0)
				{
					runningThreadNum++;
					var task:JLoadTask = queue.shift();
					JBaseLoader.createLoader(task, this).load();
					return true;
				}
				else
				{
					JLoadLog.log("下载任务队列中任务部署完毕");
					return false;
				}
			}
			else
			{
				JLoadLog.log("已达到最大同时下载任务数" + maxThreadNum);
				return false;
			}
		}
		
		/** 移除任务 */
		public function remove(...args):JLoadTask
		{
			if(args.length == 0) return null;
			var uuid:int = -1;
			if(args[0] is JLoadTask)
			{
				uuid = JLoadTask(args[0]).uuid;
			}
			else
			{
				uuid = args[0];
			}
			for(var i:int = 0; i < queue.length; i++)
			{
				if(queue[i].uuid == uuid)
				{
					var delTask:JLoadTask = queue[i];
					queue.splice(i, 1);
					return delTask;
				}
			}
			return null;
		}
		
		
		/** 打印加载状态 */
		public function printState():void
		{
			var state:String = "{状态}";
			state += "当前正在下载的任务数/最大同时下载任务数" + runningThreadNum + "/" + maxThreadNum;
			state += "\r当前队列长度:" + queue.length;
			state += "\r";
			for(var i:int = 0; i < queue.length; i++)
			{
				state += " ["+i+"]" + queue[i].toString();
				state += "\r";
			}
			JLoadLog.log(state);
		}
		
		/** [为受理单个JbaseLoader的]progressHandler */
		public function progressHandler(bytesAdded:Number):void
		{
			lastBytesLoaded += bytesAdded;
			var pastTime:Number = new Date().time - lastGetBytesTime;
			if(pastTime > progressInterval)
			{
				speed = lastBytesLoaded/pastTime;
				lastGetBytesTime = new Date().time;
				lastBytesLoaded = 0;
				//trace("速度=", speed);
				var evt:JLoadEvent = new JLoadEvent(JLoadEvent.PROGRESS);
				evt.speed = speed;
				this.dispatchEvent(evt);
			}
		}
		
		/** [为受理单个JbaseLoader的]completeHandler */
		public function completeHandler():void
		{
			runningThreadNum--;
			start();
			checkFinish();
		}
		
		/** [为受理单个JbaseLoader的]IOErrorHandler */
		public function IOErrorHandler():void
		{
			runningThreadNum--;
			start();
			checkFinish();
		}
		
		/** [为受理单个JbaseLoader的]securityErrorHandler */
		public function securityErrorHandler():void
		{
			runningThreadNum--;
			start();
			checkFinish();
		}
		
		/** 检查是否任务队列完结 */
		private function checkFinish():void
		{
			if(queue.length == 0 && runningThreadNum == 0)
			{
				this.dispatchEvent(new JLoadEvent(JLoadEvent.FINISH));
			}
		}
		
	}
}