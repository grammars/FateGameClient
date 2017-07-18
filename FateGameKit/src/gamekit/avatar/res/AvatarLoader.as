package gamekit.avatar.res
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.system.System;
	import flash.utils.ByteArray;
	
	import gamekit.FateGameKit;
	import gamekit.avatar.material.struct.StAvatarCfg;

	public class AvatarLoader
	{
		private static var instance:AvatarLoader;
		
		public static function getInstance():AvatarLoader
		{
			if(instance == null) { instance = new AvatarLoader(); }
			return instance;
		}
		
		/** key:加载的资源地址<br>
		 * value:对应的ApplicationDomain */
		private var domainDic:Object = new Object();
		/** key:加载的配置地址<br>
		 * value:对应的StAvatarCfg */
		private var configDic:Object = new Object();
		
		private var domainUsed:Object = new Object();
		private var configUsed:Object = new Object();
		
		private var domainQuests:Array = new Array();
		private var configQuests:Array = new Array();
		
		private var domainLoader:Loader = new Loader();
		private var configLoader:URLLoader = new URLLoader();
		
		private var curDomainQuest:LoadQuest;
		private var curConfigQuest:LoadQuest;
		
		private var holder:LoadingHolder = new LoadingHolder();
		
		public function AvatarLoader()
		{
			if(instance != null) { throw new Error("AvatarLoader should be single!"); }
			instance = this;
			initialize();
		}
		
		private function initialize():void
		{
			domainLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, __domainLoaded);
			//临时注释以让其报错，显示堆栈
			//domainLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __domainLoadErr);
			configLoader.dataFormat = URLLoaderDataFormat.BINARY;
			configLoader.addEventListener(Event.COMPLETE, __configLoaded);
			//临时注释以让其报错，显示堆栈
			//configLoader.addEventListener(IOErrorEvent.IO_ERROR, __configLoadErr);
		}
		
		public function disposeDomain(swfAddr:String):void
		{
			var useCount:int = domainUsed[swfAddr];
			domainUsed[swfAddr] = --useCount;
			//trace("domainUsed["+swfAddr+"]=", domainUsed[swfAddr]);
			if(domainUsed[swfAddr] <= 0)
			{
				domainDic[swfAddr] = null;
				domainUsed[swfAddr] = 0;
				System.gc();
			}
		}
		
		public function getDomain(swfAddr:String, callBack:Function):void
		{
			//trace("AvatarLoader::getDomain");
			if(domainDic[swfAddr])
			{
				//trace("有现成的", swfAddr);
				callBack(domainDic[swfAddr], swfAddr);
				var useCount:int = domainUsed[swfAddr];
				domainUsed[swfAddr] = ++useCount;
			}
			else
			{
				var q:LoadQuest = new LoadQuest(swfAddr, callBack);
				if(holder.isLoading(swfAddr))
				{
					//trace("已经有人去加载了", swfAddr);
					holder.wait(q);
				}
				else	
				{
					//trace("新加载", swfAddr);
					holder.markLoading(swfAddr);
					domainQuests.push(q);
					if(curDomainQuest == null)
					{
						loadDomain();
					}
				}
			}
		}
		
		private function loadDomain():void
		{
			if(domainQuests.length > 0)
			{
				//trace("loadDomain", domainQuests.length);
				curDomainQuest = domainQuests.shift();
				var url:URLRequest = new URLRequest(curDomainQuest.addr);
				var context:LoaderContext = new LoaderContext(!FateGameKit.SAME_DOMAIN, new ApplicationDomain(ApplicationDomain.currentDomain));
				if(FateGameKit.SAME_DOMAIN == false)
				{
					context.securityDomain = SecurityDomain.currentDomain;
				}
				domainLoader.load(url, context);
			}
		}
		
		private function __domainLoaded(e:Event):void
		{
			//trace("AvatarLoader::__domainLoaded");
			var domain:ApplicationDomain = LoaderInfo(e.target).applicationDomain;
			curDomainQuest.callBack(domain, curDomainQuest.addr);
			var useCount:int = domainUsed[curDomainQuest.addr];
			domainUsed[curDomainQuest.addr] = ++useCount;
			domainDic[curDomainQuest.addr] = domain;
			holder.markLoaded(curDomainQuest.addr);
			holder.feedback(curDomainQuest.addr, domain);
			curDomainQuest = null;
			loadDomain();
		}
		
		private function __domainLoadErr(e:Event):void
		{
			trace("AvatarLoader::__domainLoadErr " + curDomainQuest.addr);
			holder.markLoaded(curDomainQuest.addr);
			curDomainQuest = null;
			loadDomain();
		}
		
		
		public function disposeConfig(cfgAddr:String):void
		{
			var useCount:int = configUsed[cfgAddr];
			configUsed[cfgAddr] = --useCount;
			if(configUsed[cfgAddr] <= 0)
			{
				configDic[cfgAddr] = null;
				configUsed[cfgAddr] = 0;
			}
		}
		
		public function getConfig(cfgAddr:String, callBack:Function):void
		{
			//trace("AvatarLoader::getConfig");
			if(!holder.isLoading(cfgAddr) && configDic[cfgAddr])
			{
				callBack(configDic[cfgAddr], cfgAddr);
				var useCount:int = configUsed[cfgAddr];
				configUsed[cfgAddr] = ++useCount;
			}
			else
			{
				var q:LoadQuest = new LoadQuest(cfgAddr, callBack);
				if(holder.isLoading(cfgAddr))
				{
					holder.wait(q);
				}
				else
				{
					holder.markLoading(cfgAddr);
					configQuests.push(q);
					if(curConfigQuest == null)
					{
						loadConfig();
					}
				}
			}
		}
		
		private function loadConfig():void
		{
			if(configQuests.length > 0)
			{
				curConfigQuest = configQuests.shift();
				var url:URLRequest = new URLRequest(curConfigQuest.addr);
				configLoader.load(url);
			}
		}
		
		private function __configLoaded(e:Event):void
		{
			//trace("AvatarLoader::__configLoaded");
			var bytes:ByteArray = (e.target as URLLoader).data as ByteArray;
			bytes.uncompress();
			var cfgXml:XMLList = XMLList(bytes);
			var stCfg:StAvatarCfg = new StAvatarCfg(cfgXml);
			var useCount:int = configUsed[curConfigQuest.addr];
			configUsed[curConfigQuest.addr] = ++useCount;
			configDic[curConfigQuest.addr] = stCfg;
			curConfigQuest.callBack(stCfg, curConfigQuest.addr);
			holder.markLoaded(curConfigQuest.addr);
			holder.feedback(curConfigQuest.addr, stCfg);
			curConfigQuest = null;
			loadConfig();
		}
		
		private function __configLoadErr(e:Event):void
		{
			trace("AvatarLoader::__configLoadErr " + curConfigQuest.addr);
			holder.markLoaded(curConfigQuest.addr);
			curConfigQuest = null;
			loadConfig();
		}
		
	}
}


class LoadQuest
{
	public var addr:String;
	public var callBack:Function;
	
	public function LoadQuest(addr:String, callBack:Function)
	{
		this.addr = addr;
		this.callBack = callBack;
	}
}

class LoadingHolder
{
	private var loadingDic:Object = new Object();
	private var waiting:Array = new Array();
	
	public function LoadingHolder()
	{
		//
	}
	
	/** 标记正在加载 */
	public function markLoading(addr:String):void
	{
		loadingDic[addr] = "loading";
	}
	
	/** 标记已加载完 */
	public function markLoaded(addr:String):void
	{
		loadingDic[addr] = null;
		//delete loadingDic[addr];
	}
	
	/** 此地址是否正被加载 */
	public function isLoading(addr:String):Boolean
	{
		return loadingDic[addr] == "loading";
	}
	
	/** 放入等待队列 */
	public function wait(q:LoadQuest):void
	{
		waiting.push(q);
	}
	
	/** 反馈队列结果 */
	public function feedback(addr:String, result:*):void
	{
		for(var i:int = 0; i < waiting.length; )
		{
			var q:LoadQuest = waiting[i];
			if(q.addr == addr)
			{
				q.callBack(result, addr);
				waiting.splice(i, 1);
			}
			else
			{
				i++;
			}
		}
	}
	
}