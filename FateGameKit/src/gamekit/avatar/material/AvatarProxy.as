package gamekit.avatar.material
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import gamekit.FateGameKit;
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarFacade;
	import gamekit.avatar.AvatarRule;
	import gamekit.avatar.material.struct.StAvatarBmd;
	import gamekit.avatar.material.struct.StAvatarCfg;
	import gamekit.avatar.material.struct.StAvatarPicAttri;
	import gamekit.avatar.res.AvatarLoader;
	import gamekit.utils.IntervalCounter;

	public class AvatarProxy extends EventDispatcher
	{
		private var CONFIG_OK:Boolean = false;
		private var DOMAIN_OK:Boolean = false;
		
		private var cfgAddr:String;
		private var swfAddr:String;
		
		private var theConfig:StAvatarCfg;
		private var theDomain:ApplicationDomain;
		private var theBmd:StAvatarBmd;
		
		private var cartoon:Cartoon = new Cartoon();
		public function getCartoon():Cartoon { return cartoon; }
		
		/** key: cfgAddr + swfAddr <br>
		 * value: StAvatarBmd */
		private static var cartoonBmds:Object = new Object();
		
		/** key: cfgAddr + swfAddr <br>
		 * value: int */
		private static var bmdsUsed:Object = new Object();
		
		/** 是否被释放 */
		private var isDisposed:Boolean = false;
		
		/** 动作播放完之后回调
		 * actionDoneCall(curAction:String) */
		public var actionDoneCall:Function = null;
		
		/** 需要指定更新index */
		private var needAppIndex:Boolean;
		/** 该avatar诞生绝对时间 */
		protected var bornTime:Number;
		
		public function AvatarProxy(bornTime:Number)
		{
			this.bornTime = bornTime;
		}
		
		public function install(cfgAddr:String, swfAddr:String):void
		{
			if(cfgAddr == null || swfAddr == null) { return; }
			this.needAppIndex = true;
			this.cfgAddr = cfgAddr;
			this.swfAddr = swfAddr;
			AvatarLoader.getInstance().getConfig(cfgAddr, __configGot);
			AvatarLoader.getInstance().getDomain(swfAddr, __domainGot);
		}
		
		private function __configGot(val:StAvatarCfg, addr:String):void
		{
			//trace("AvatarProxy::__configGot");
			if(isDisposed) { return; }
			if(this.cfgAddr == addr)
			{
				theConfig = val;
				CONFIG_OK = true;
				setup();
			}
		}
		
		private function __domainGot(val:ApplicationDomain, addr:String):void
		{
			//trace("AvatarProxy::__domainGot");
			if(isDisposed) { return; }
			if(this.swfAddr == addr)
			{
				theDomain = val;
				DOMAIN_OK = true;
				setup();
			}
		}
		
		private function setup():void
		{
			if(CONFIG_OK && DOMAIN_OK)
			{
				const key:String = cfgAddr + swfAddr;
				var count:int = bmdsUsed[key];
				bmdsUsed[key] = ++count;
				if(cartoonBmds[key])
				{
					theBmd = cartoonBmds[key];
				}
				else
				{
					theBmd = new StAvatarBmd(theDomain, theConfig);
					cartoonBmds[key] = theBmd;
				}
				//
				AvatarFacade.getInstance().register(this);
				//
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function dispose():void
		{
			const key:String = cfgAddr + swfAddr;
			var count:int = bmdsUsed[key];
			bmdsUsed[key] = --count;
			if(bmdsUsed[key] <= 0)
			{
				cartoonBmds[key] = null;
				bmdsUsed[key] = 0;
			}
			//
			CONFIG_OK = false;
			DOMAIN_OK = false;
			theConfig = null;
			theDomain = null;
			theBmd = null;
			AvatarLoader.getInstance().disposeConfig(cfgAddr);
			AvatarLoader.getInstance().disposeDomain(swfAddr);
			AvatarFacade.getInstance().unregister(this);
			isDisposed = true;
		}
		
		/** 加入到某个显示对象容器中去 */
		public function addTo(parent:DisplayObjectContainer):void
		{
			parent.addChild(cartoon);
		}
		
		/** 从某个显示对象容器中移除 */
		public function remove():void
		{
			if(cartoon.parent) { cartoon.parent.removeChild(cartoon); }
			dispose();
		}
		
		public function setX(x:int):void
		{
			cartoon.x = x;
		}
		public function getX():int { return cartoon.x; }
		
		public function setY(y:int):void
		{
			cartoon.y = y;
		}
		public function getY():int { return cartoon.y; }
		
		private var invalid:Boolean = true;
		private var index:int = 1;
		private var curAction:String = ActionType.STAND;
		private var curDirection:int = 0;
		/** 动作播放速度 */
		public var actionSpeed:ActionSpeed = new ActionSpeed();
		
		/** 设置动作<br>
		 * action:ActionType */
		public function setAction(action:String):void
		{
			if(curAction != action)
			{
				invalid = true;
				curAction = action;
				lastActStartTime = getTimer();
			}
		}
		
		/** 设置方向 */
		public function setDirection(dir:int):void
		{
			if(curDirection != dir)
			{
				invalid = true;
				curDirection = dir;
			}
		}
		
		//----------------speed--------------
		
		/** 上一次动作起始时间(毫秒) */
		private var lastActStartTime:Number = 0;
		/** 返回true，需要更新，返回false，不需要更新 */
		private function updateIndex():Boolean
		{
			const FAT:Number = actionSpeed.getActionTime(curAction);
			if(needAppIndex)
			{
				var enterTime:Number = new Date().time-bornTime;
				enterTime = enterTime % FAT;
				lastActStartTime = getTimer() - enterTime;
				
				needAppIndex = false;
				invalid = false;
			}
			if(invalid)
			{
				index = 1;
				invalid = false;
				return true;
			}
			var deltTime:Number = getTimer() - lastActStartTime;
			if(deltTime < 0)
			{
				deltTime = FAT - ( (-deltTime) % FAT );
			}
			//var fullActionTime:Number = AvatarRule.getStdPlayTimeByAction(curAction);//每套动作所需的时间,比如一次砍需要的时间、一次走步需要的时间
			//fullActionTime = fullActionTime * 1000 / actionSpeed.getActionSpeed(curAction);
			var fullActionTime:Number = actionSpeed.getActionTime(curAction);
			var picNum:int = theConfig.getPicNumByAction(curAction);
			var needIndex:int = 1 + Math.floor(picNum * deltTime / fullActionTime);
			if(needIndex > picNum)
			{
				if(curAction == ActionType.DIE)
				{
					return false;//播到死亡的最后一帧就停住了。
				}
				needIndex = 1;
				lastActStartTime = getTimer();
				if(actionDoneCall != null)
				{
					actionDoneCall.call(this, curAction);
				}
			}
			if(needIndex != index)
			{
				//trace("需要更新" + needIndex);
				this.index = needIndex;
				return true;
			}
			return false;
		}
		//-----------------------------------
		
		
		/** nextFrame */
		public function nextFrame():void
		{
			if(!CONFIG_OK || !DOMAIN_OK) { return; }
			if( updateIndex() )
			{
				if(!theBmd) { return; }
				var bmd:BitmapData = theBmd.getFrameBmd(curAction, curDirection, index);
				var apa:StAvatarPicAttri = theConfig.getPicAttriByLinkName(AvatarRule.getLinkName(curAction, curDirection, index));
				cartoon.paint(bmd, apa, AvatarRule.getScaleXByDir(curDirection));
			}
		}
		
	}
}