package builder.view.assets
{
	import builder.Builder;
	import builder.view.StatusBar;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.components.Grid9Bmd;
	import com.anstu.jui.components.Grid9Bmp;
	import com.anstu.jui.components.TileBmp;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class AssetsNode extends EventDispatcher
	{
		private static var nodes:Dictionary = new Dictionary();
		public static function getNode(cls:String):AssetsNode
		{
			if(nodes[cls]) { return nodes[cls]; }
			return null;
		}
		
		public var parent:AssetsNode;
		
		public var children:Vector.<AssetsNode> = new Vector.<AssetsNode>();
		
		public var isPack:Boolean = false;
		
		protected var _name:String;
		protected var _itemCls:String;
		protected var _itemSrc:String;
		protected var _itemSlice:Boolean = false;
		protected var _itemLeft:int;
		protected var _itemRight:int;
		protected var _itemTop:int;
		protected var _itemBottom:int;
		
		public function get name():String { return this._name; }
		public function get itemCls():String { return this._itemCls; }
		public function get itemSrc():String { return this._itemSrc; }
		public function get itemSlice():Boolean { return this._itemSlice; }
		public function get itemLeft():int { return this._itemLeft; }
		public function get itemRight():int { return this._itemRight; }
		public function get itemTop():int { return this._itemTop; }
		public function get itemBottom():int { return this._itemBottom; }
		
		public function set name(value:String):void { this._name = value; }
		
		protected var _bmd:BitmapData;
		protected var _g9bmd:Grid9Bmd;
		
		/** 设置节点数据 */
		public function setup(name:String, itemCls:String, itemSrc:String, itemSlice:Boolean=false, 
							  itemLeft:int=0, itemRight:int=0, itemTop:int=0, itemBottom:int=0, 
							  needLoadPicData:Boolean=true, pBmd:BitmapData=null, pG9bmd:Grid9Bmd=null):void
		{
			this._name = name;
			this._itemCls = itemCls;
			this._itemSrc = itemSrc;
			this._itemSlice = itemSlice;
			this._itemLeft = itemLeft;
			this._itemRight = itemRight;
			this._itemTop = itemTop;
			this._itemBottom = itemBottom;
			if(needLoadPicData && isPack==false)
			{
				loadPicData();
			}
			else
			{
				this._bmd = pBmd;
				this._g9bmd = pG9bmd;
			}
			if(!isPack) { nodes[this._itemCls] = this; }
		}
		
		public function available():Boolean
		{
			if(_itemCls == null) { return false; }
			if(_itemCls.length <= 0) { return false; }
			if(_itemSrc == null) { return false; }
			if(_itemSrc.length <= 0) { return false; }
			return true;
		}
		
		/** 获取所在层级数,即多少层parent,如果没有parent即在0层 */
		public function hierarchyIndex():int
		{
			var debugStr:String = "-----" + this.name + "的上一辈有：";
			var index:int = 0;
			var thisPa:AssetsNode = this.parent;
			while(thisPa != null)
			{
				debugStr +=  ", " + thisPa.name;
				if(thisPa.name == null || thisPa.name == "")
				{
					debugStr += "[" + thisPa.toString() + "]";
				}
				
				if(thisPa == this)
				{
					throw new Error("parent层级存在循环嵌套的错误");
					break;
				}
				index++;
				thisPa = thisPa.parent;
				if(index > 256)
				{
					throw new Error("parent层级超出设定上限256");
					break;
				}
			}
			
			debugStr += " index=" + index;
			//trace(debugStr);
			return index;
		}
		
		public function AssetsNode(isPack:Boolean=false)
		{
			this.isPack = isPack;
		}
		
		public function addChild(child:AssetsNode):AssetsNode
		{
			if(-1 == children.indexOf(child))
			{
				children.push(child);
				child.parent = this;
			}
			return child;
		}
		
		public function remove(child:AssetsNode):AssetsNode
		{
			var index:int = children.indexOf(child);
			if(index != -1)
			{
				children.splice(index, 1);
				child.parent = null;
				delete nodes[child._itemCls];
			}
			return child;
		}
		
		public function removeFromParent():AssetsNode
		{
			if(this.parent != null)
			{
				return this.parent.remove(this);
			}
			return null;
		}
		
		public function removeChildren():void
		{
			children.length = 0;
		}
		
		private var loader:Loader = new Loader();
		/** 加载图片资源 */
		public function loadPicData():void
		{
			if(isPack) { return; }
			_bmd = null;
			_g9bmd = null;
			loader.unloadAndStop();
			if(_itemSrc)
			{
				var url:String = Builder.assetsDirFull() + _itemSrc;
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __picLoadErr);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __picLoaded);
				loader.load(new URLRequest(url));
			}
		}
		
		private function __picLoadErr(e:IOErrorEvent):void
		{
			StatusBar.instance.show("" + _itemSrc + "图片加载错误");
		}
		
		private function __picLoaded(e:Event):void
		{
			var bmp:Bitmap = loader.content as Bitmap;
			if(bmp && bmp.bitmapData)
			{
				if(_itemSlice)
				{
					_bmd = bmp.bitmapData;
					_g9bmd = new Grid9Bmd(bmp.bitmapData, _itemLeft, _itemRight, _itemTop, _itemBottom);
				}
				else
				{
					_bmd = bmp.bitmapData;
				}
			}
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/** 创建图像填充物 */
		public function createPic(option:Object=null):DisplayObject
		{
			if(isPack) { return null; }
			if(_itemSlice)
			{
				return new Grid9Bmp(_g9bmd);
			}
			else
			{
				if(option == JResource.OPT_TILE_SINGLE)
				{
					var singleTile:TileBmp = new TileBmp(_bmd);
					singleTile.repeat = false;
					return singleTile;
				}
				else if(option == JResource.OPT_TILE_REPEAT)
				{
					var repeatTile:TileBmp = new TileBmp(_bmd);
					repeatTile.repeat = true;
					return repeatTile;
				}
				else
				{
					return new Bitmap(_bmd);
				}
			}
		}
		
		public function digestXml(xml:XML):void
		{
			var name:String = "";
			var itemCls:String;
			var itemSrc:String;
			var itemSlice:Boolean = false;
			var itemLeft:int;
			var itemRight:int;
			var itemTop:int;
			var itemBottom:int;
			
			name = xml.@name;
			if(this.isPack)
			{
				_name = name;
			}
			else
			{
				itemCls = xml.@cls;
				itemSrc = xml.@src;
				if(xml.@slice == undefined)
				{
					itemSlice = false;
				}
				else
				{
					if(xml.@slice == "true")
					{
						itemSlice = true;
						itemLeft = parseInt(xml.@left);
						itemRight = parseInt(xml.@right);
						itemTop = parseInt(xml.@top);
						itemBottom = parseInt(xml.@bottom);
					}
					else
					{
						itemSlice = false;
					}
				}
				setup(name, itemCls, itemSrc, itemSlice, itemLeft, itemRight, itemTop, itemBottom);
			}
		}
		
		/** 打包导出资源的内容 */
		public function toPackStr():String
		{
			var str:String = '<item cls="'+itemCls+'"';
			if(itemSlice)
			{
				str += ' slice="true" left="'+itemLeft+'" right="'+itemRight+'" top="'+itemTop+'" bottom="'+itemBottom+'"';
			}
			str += '/>';
			return str;
		}
		
		override public function toString():String
		{
			var str:String = "{AssetsNode:";
			if(isPack)
			{
				str += "[pack] name:" + _name;
			}
			else
			{
				str += "[item] name:" + _name + " cls:" + _itemCls + " src:" + _itemSrc;
				if(_itemSlice)
				{
					str += "("+_itemLeft+","+_itemRight+","+_itemTop+","+_itemBottom+")";
				}
			}
			str += "}";
			return str;
		}
		
		public function clone():AssetsNode
		{
			var node:AssetsNode = new AssetsNode(this.isPack);
			node.setup(this._name, this._itemCls, this._itemSrc, this._itemSlice,
				this._itemLeft, this._itemRight, this._itemTop, this._itemBottom,
				false, this._bmd, this._g9bmd);
			return node;
		}
		
		public function clear():void
		{
			this._name = "";
			this._itemCls = null;
			this._itemSrc = null;
			this._itemSlice = false;
			this._itemLeft = 0;
			this._itemRight = 0;
			this._itemTop = 0;
			this._itemBottom = 0;
			this._bmd = null;
			this._g9bmd = null;
		}
		
	}
}