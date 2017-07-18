package com.anstu.jload
{
	import com.anstu.jload.loaders.JBaseLoader;
	import com.anstu.jload.struct.JLoadResult;
	import com.anstu.jload.struct.JLoadStatus;
	
	import flash.net.URLRequest;

	public class JLoadTask
	{
		/** 显示对象(为了获得应用程序域)[适用于有链接名的] */
		public static const TYPE_CLASS_DOMAIN:String = "TYPE_CLASS_DOMAIN";
		/** 显示对象(为了直接获得显示对象)[适用于无链接名的] */
		public static const TYPE_DISPLAY_CONTENT:String = "TYPE_DISPLAY_CONTENT";
		/** 数据对象[二进制] */
		public static const TYPE_DATA_BINARY:String = "TYPE_DATA_BINARY";
		/** 数据对象[纯文本] */
		public static const TYPE_DATA_TEXT:String = "TYPE_DATA_TEXT";
		/** 数据对象[URL变量] */
		public static const TYPE_DATA_VARIABLES:String = "TYPE_DATA_VARIABLES";
		/** 数据对象[XML] */
		public static const TYPE_DATA_XML:String = "TYPE_DATA_XML";
		/** 音频对象 */
		public static const TYPE_SOUND:String = "TYPE_SOUND";
		/** 视频对象 */
		public static const TYPE_VIDEO:String = "TYPE_VIDEO";
		
		/** 任务类型 */
		public var type:String = TYPE_DISPLAY_CONTENT;
		/** URL */
		public var url:String = null;
		/** 是否在同一个域 */
		public var inSameDomain:Boolean = true;
		/** 优先级 */
		public var priority:int = 0;
		/** 音频预加载buffer时间 */
		public var soundBufferTime:int = 3000;
		
		/** 唯一识别id生成计数 */
		private static var _uuidCount:int = 0;
		/** 唯一识别id[只读]在constructor中生成 */
		private var _uuid:int = -1;
		/** 唯一识别id[只读]在constructor中生成 */
		public function get uuid():int { return _uuid; }
		/** 设置 唯一识别id */
		private function makeUUID():void { _uuid = _uuidCount++; }
		
		/** 任务启动[希望被单独回调的方法,onStart(task)] */
		public var onStart:Function = null;
		/** 任务内容打开[希望被单独回调的方法,onOpen(task)] */
		public var onOpen:Function = null;
		/** 任务内容初始化[希望被单独回调的方法,onInit(task)] */
		public var onInit:Function = null;
		/** 任务Http状态事件[希望被单独回调的方法,onHttpStatus(task)] */
		public var onHttpStatus:Function = null;
		/** 任务进度[希望被单独回调的方法,onProgress(task)] */
		public var onProgress:Function = null;
		/** 任务完成[希望被单独回调的方法,onComplete(task)] */
		public var onComplete:Function = null;
		/** 任务安全错误[希望被单独回调的方法,onSecurityError(task)] */
		public var onSecurityError:Function = null;
		/** 任务IO错误[希望被单独回调的方法,onIOError(task)] */
		public var onIOError:Function = null;
		/** 任务失败[希望被单独回调的方法,onFail(task)] */
		public var onFail:Function = null;
		/** 视频元数据返回[希望被单独回调的方法,onVideoMetaData(task)] */
		public var onVideoMetaData:Function = null;
		
		/** [任务状态,只由具体JXxxxLoader写入] */
		public var status:JLoadStatus = new JLoadStatus();
		/** 任务所得到的结果 */
		public var result:JLoadResult = new JLoadResult();
		/** 任务所得到的信息 */
		public var info:Info = new Info();
		
		/** 关联的加载器 */
		private var loader:JBaseLoader;
		/** 设置[关联的加载器] */
		public function setLoader(loader:JBaseLoader):void
		{
			this.loader = loader;
		}
		
		/** 因任务失败而变更级别(>0 提升级别 =0 维持不变 <0降低级别) */
		public var failPriorityChange:int = -1;
		/** 名字[用户自取] */
		public var name:String = "unnamed";
		
		/** 任务消息 */
		public var message:String = "";
		
		/** JLoadTask <br>
		 * @param type:String JLoadTask.TYPE_DISPLAY_CONTENT <br>
		 * @param url:String 资源地址 <br>
		 * @param inSameDomain:Boolean=true 是否在同一个域<br>
		 * @param priority:int=0  优先级 */
		public function JLoadTask(type:String, url:String, inSameDomain:Boolean=true, priority:int=0)
		{
			this.type = type;
			this.url = url;
			this.inSameDomain = inSameDomain;
			this.priority = priority;
			makeUUID();
		}
		
		/** 关闭加载,放弃任务 */
		public function dispose():void
		{
			if(loader != null)
			{
				loader.unload();
				loader = null;
			}
		}
		
		/** equals */
		public function equals(t:JLoadTask):Boolean
		{
			if(this.uuid == t.uuid) { return true; }
			return false;
		}
		
		public function toString():String
		{
			var info:String = "[task] ";
			info += "uuid=" + uuid + " ";
			info += "url=" + url + " ";
			info += "inSameDomain=" + inSameDomain + " ";
			info += "\r" + status.toString();
			return info;
		}
		
	}
}


import com.anstu.jload.struct.JVideoMetaData;

class Info
{
	public var videoMetaData:JVideoMetaData;
}