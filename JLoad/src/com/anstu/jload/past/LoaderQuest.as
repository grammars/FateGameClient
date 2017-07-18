package com.anstu.jload.past
{
	public class LoaderQuest
	{
		/** 请求类型 */
		public var reqType:String = LoadTarType.BINARY;
		/** 请求的资源地址 */
		public var addr:String = "";
		/** Complete回调函数 */
		public var onComplete:Function;
		/** IOError回调函数 */
		public var onIOError:Function;
		/** Pregress回调函数 */
		public var onLoading:Function;
		/** callback owner */
		public var owner:Object;
		/** 回调函数附加参数 */
		public var args:*;
		/** 是否在同一个域内 */
		public var inSameDomain:Boolean = true;
		
		/** 尝试加载次数 */
		public var tryTimes:int = 0;
		
		public function LoaderQuest(reqType:String=LoadTarType.BINARY, addr:String="", onComplete:Function=null, onLoading:Function=null, onIOError:Function=null, owner:Object=null, args:*=null, inSameDomain:Boolean=true)
		{
			this.reqType = reqType;
			this.addr = addr;
			this.onComplete = onComplete;
			this.onLoading = onLoading;
			this.onIOError = onIOError;
			this.owner = owner;
			this.args = args;
			this.inSameDomain = inSameDomain;
		}
		
	}
}
