package gamekit.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.system.ApplicationDomain;
	import flash.utils.setTimeout;
	
	import gamekit.FateGameKit;
	import gamekit.avatar.res.AvatarLoader;
	
	public class Swf
	{
		/** 指定swf资源地址 */
		protected var url:String;
		/** 链接的类名 */
		protected var _className:String = null;
		public function set className(value:String):void
		{
			if(value == null)
			{
				trace("企图设空");
			}
			else
			{
				_className = value;
			}
		}
		public function get className():String { return _className; }
		/** domain */
		protected var domain:ApplicationDomain;
		/** 显示内容 */
		protected var content:DisplayObject;
		/** 显示对象容器 */
		protected var container:DisplayObjectContainer;
		/** 获取显示对象容器 */
		public function getContainer():DisplayObjectContainer { return container; }
		
		protected var _x:Number = 0;
		public function set x(value:Number):void
		{
			_x = value;
			refresh();
		}
		public function get x():Number { return _x; }
		
		protected var _y:Number = 0;
		public function set y(value:Number):void
		{
			_y = value;
			refresh();
		}
		public function get y():Number { return _y; }
		
		protected var _alpha:Number = 1;
		public function set alpha(value:Number):void
		{
			_alpha = value;
			refresh();
		}
		public function get alpha():Number { return _alpha; }
		
		protected var _visible:Boolean = true;
		public function set visible(value:Boolean):void
		{
			_visible = value;
			refresh();
		}
		public function get visible():Boolean { return _visible; }
		
		/** 自动移除时间[单位毫秒, <=0 为不自动移除] */
		public var autoRemoveTime:int = -1;
		
		protected var mouseEnabled:Object = null;
		protected var mouseChildren:Object = null;
		
		public function Swf(url:String=null, className:String=null, autoRemoveTime:int=-1, 
							mouseEnabled:Object=null, mouseChildren:Object=null)
		{
			this.autoRemoveTime = autoRemoveTime;
			this.mouseEnabled = mouseEnabled;
			this.mouseChildren = mouseChildren;
			if(url != null && className != null)
			{
				load(url, className, autoRemoveTime);
			}
		}
		
		/** 加载指定资源
		 * @param url:String 指定swf资源地址
		 * @param className:String 链接的类名
		 * @param autoRemoveTime:Object=null 为null则不改变自动移除设置,否则设置int毫秒数 */
		public function load(url:String, className:String, autoRemoveTime:Object=null):void
		{
			if(autoRemoveTime != null)
			{
				this.autoRemoveTime = int(autoRemoveTime);
			}
			if(url == null || className == null)
			{
				return;
			}
			if(url == this.url)
			{
				if(className != this.className)
				{
					this.className = className;
					if(content != null)
					{
						content = createDisObj(domain, className);
						addTo(container);
						refresh();
					}
				}
			}
			else
			{
				this.url = url;
				this.className = className;
				AvatarLoader.getInstance().getDomain(url, __domainGot);
			}
		}
		
		private function __domainGot(pDomain:ApplicationDomain, url:String):void
		{
			this.domain = pDomain;
			content = createDisObj(this.domain, this.className);
			addTo(this.container);
			refresh();
			if(this.autoRemoveTime > 0)
			{
				setTimeout(remove, this.autoRemoveTime);
			}
		}
		
		private function createDisObj(pDomain:ApplicationDomain, pClassName:String):DisplayObject
		{
			if(pClassName == null)
			{
				trace("Swf::createDisObj pClassName不应该==null");
			}
			if(pDomain.hasDefinition(pClassName))
			{
				var Cls:Class = pDomain.getDefinition(pClassName) as Class;
				var ins:DisplayObject = new Cls() as DisplayObject;
				if( (mouseEnabled != null) && (ins is InteractiveObject) )
				{
					(ins as InteractiveObject).mouseEnabled = Boolean(mouseEnabled);
				}
				if( (mouseChildren != null) && (ins is DisplayObjectContainer) )
				{
					(ins as DisplayObjectContainer).mouseChildren = Boolean(mouseChildren);
				}
				return ins;
			}
			return null;
		}
		
		/** 添加到某显示容器中去 */
		public function addTo(pContainer:DisplayObjectContainer):void
		{
			this.container = pContainer;
			if(this.content && this.container)
			{
				this.container.addChild(this.content);
			}
		}
		
		/** 从显示容器中移除 */
		public function remove():void
		{
			if(content && content.parent) { content.parent.removeChild(content); }
			container = null;
			content = null;
			domain = null;
			AvatarLoader.getInstance().disposeDomain(url);
		}
		
		/** 刷新显示对象所需的属性  */
		private function refresh():void
		{
			if(content != null)
			{
				content.x = _x;
				content.y = _y;
				content.alpha = _alpha;
				content.visible = _visible;
			}
		}
		
	}
}