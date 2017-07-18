package com.anstu.jui.assets
{
	import com.anstu.jui.components.Grid9Bmd;
	import com.anstu.jui.components.Grid9Bmp;
	import com.anstu.jui.components.TileBmp;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	public class JResource
	{
		private static var cache:Dictionary = new Dictionary();
		
		/** 使用[非重复]平铺  */
		public static const OPT_TILE_SINGLE:String = "OPT_TILE_SINGLE";
		/** 使用[重复]平铺  */
		public static const OPT_TILE_REPEAT:String = "OPT_TILE_REPEAT";
		
		//private static var fillTasks:Vector.<FillTask> = new Vector.<FillTask>();
		private static var fillTasks:Array = new Array();
		
		public function JResource()
		{
		}
		
		/** 会返回Grid9Bmd/BitmapData */
		public static function getBmd(cls:String, ns:String="base"):Object
		{
			var key:String = ns + "::" + cls;
			return cache[key];
		}
		
		/** 会返回Grid9Bmp/Bitmap */
		public static function getBmp(cls:String, ns:String="base", option:Object=null):DisplayObject
		{
			var bmd:Object = getBmd(cls, ns);
			if(bmd is Grid9Bmd)
			{
				return new Grid9Bmp((bmd as Grid9Bmd));
			}
			else if(bmd is BitmapData)
			{
				if(option == OPT_TILE_SINGLE)
				{
					var singleTile:TileBmp = new TileBmp((bmd as BitmapData));
					singleTile.repeat = false;
					return singleTile;
				}
				else if(option == OPT_TILE_REPEAT)
				{
					var repeatTile:TileBmp = new TileBmp((bmd as BitmapData));
					repeatTile.repeat = true;
					return repeatTile;
				}
				else
				{
					return new Bitmap((bmd as BitmapData));
				}
			}
			return new Bitmap();
		}
		
		/** 预定式索取资源并填充[对传入的回调方法有着严重的形式要求]<br>
		 * @param fillCallback:Function  fillCallback(vo:DisplayObject,...args)
		 * 如将JPanel::fillBackground作为fillCallback传入 */
		public static function fill(fillCallback:Function, cls:String, ns:String="default", option:Object=null, owner:Object=null, args:Array=null):void
		{
			var bmd:Object = getBmd(cls, ns);
			if(bmd)
			{
				var argsArr:Array = [getBmp(cls, ns, option)];
				if(args) { argsArr = argsArr.concat(args) }
				fillCallback.apply(owner, argsArr);
			}
			else
			{
				var ft:FillTask = new FillTask();
				ft.put(fillCallback, cls, ns, option, owner, args);
				fillTasks.push(ft);
			}
		}
		/** 处理延迟待填充的任务 */
		private static function handleFillTasks(ns:String):void
		{
			for(var i:int = fillTasks.length-1; i >= 0; i--)
			{
				var task:FillTask = fillTasks[i];
				if(task.ns == ns)
				{
					var argsArr:Array = [getBmp(task.cls, task.ns, task.option)];
					if(task.args) { argsArr = argsArr.concat(task.args) }
					task.fillCallback.apply(task.owner, argsArr);
					fillTasks.splice(i, 1);
				}
			}
		}
		
		/** 添加资源包  */
		public static function add(xml:XML, domain:ApplicationDomain):void
		{
			var swfUrl:String = xml.property.@url;
			var swfNs:String = xml.property.@ns;
			var items:XMLList = xml.list.item;
			for(var i:int = 0; i < items.length(); i++)
			{
				var item:XML = items[i];
				var cls:String = item.@cls;
				var slice:Boolean = item.@slice == "true" ? true : false;
				if(domain.hasDefinition(cls))
				{
					var CLAZZ:Class = domain.getDefinition(cls) as Class;
					var bmd:BitmapData = new CLAZZ(0, 0) as BitmapData;
					var key:String = swfNs + "::" + cls;
					if(slice == true)
					{
						var left:int = parseInt(item.@left);
						var right:int = parseInt(item.@right);
						var top:int = parseInt(item.@top);
						var bottom:int = parseInt(item.@bottom);
						var g9bmd:Grid9Bmd = new Grid9Bmd(bmd, left, right, top, bottom);
						cache[key] = g9bmd;
						//trace("已生成", key, g9bmd.srcWidth, g9bmd.srcHeight);
					}
					else
					{
						cache[key] = bmd;
						//trace("已生成", key, bmd.width, bmd.height);
					}
					
				}
				else
				{
					trace("在" + swfUrl + "中" + "未找到定义" + cls);
				}
			}
			//处理延迟待填充的任务
			handleFillTasks(swfNs);
		}
		
	}
}

/** 延迟填充任务 */
class FillTask
{
	public var fillCallback:Function;
	public var cls:String;
	public var ns:String;
	public var option:Object;
	public var owner:Object;
	public var args:Array;
	
	public function FillTask()
	{
		//
	}
	
	public function put(fillCallback:Function=null, cls:String=null, ns:String=null, option:Object=null, owner:Object=null, args:Array=null):void
	{
		this.fillCallback = fillCallback;
		this.cls = cls;
		this.ns = ns;
		this.option = option;
		this.owner = owner;
		this.args = args;
	}
}