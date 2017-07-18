package model
{
	import flash.filesystem.File;

	public class WorkConfig
	{
		private static var _me:WorkConfig;
		public static function me():WorkConfig
		{
			if(_me == null) { _me = new WorkConfig(); }
			return _me;
		}
		
		private var mapName:String = "";
		public function setMapName(name:String):void
		{
			mapName = name;
		}
		public function getMapName():String { return mapName; }
		
		private var mapId:int = 0;
		public function setMapId(id:*):void
		{
			mapId = int(id);
		}
		public function getMapId():int { return mapId; }
		
		private var gridW:int = 0;
		public function setGridW(w:*):void
		{
			gridW = int(w);
		}
		public function getGridW():int { return gridW; }
		
		private var gridH:int = 0;
		public function setGridH(h:*):void
		{
			gridH = int(h);
		}
		public function getGridH():int { return gridH; }
		
		private var mapPicFile:File;
		private var mapPicAddr:String = "";
		public function setMapPicAddr(addr:String):void
		{
			if(mapPicAddr != addr)
			{
				mapPicAddr = addr;
				try
				{
					mapPicFile = new File(mapPicAddr);
				}
				catch(e:Error)
				{
					mapPicAddr = "该路径无效";
					mapPicFile = null;
				}
			}
		}
		public function getMapPicAddr():String
		{
			return mapPicAddr;
		}
		
		private var mapSpaceFile:File;
		private var mapSpaceDir:String = "";
		public function setMapSpaceDir(dir:String):void
		{
			if(mapSpaceDir != dir)
			{
				mapSpaceDir = dir;
				try
				{
					mapSpaceFile = new File(mapSpaceDir);
				}
				catch(e:Error)
				{
					mapSpaceDir = "该路径无效";
					mapSpaceFile = null;
				}
			}
		}
		public function getMapSpaceDir():String
		{
			return mapSpaceDir;
		}
		
		private var mapWidth:int = 0;
		public function setMapWidth(w:int):void
		{
			mapWidth = w;
		}
		public function getMapWidth():int { return mapWidth; }
		
		private var mapHeight:int = 0;
		public function setMapHeight(h:int):void
		{
			mapHeight = h;
		}
		public function getMapHeight():int { return mapHeight; } 
		
		private var tileW:int = 500;
		public function setTileW(value:int):void
		{
			tileW= value;
		}
		public function getTileW():int { return tileW; }
		
		private var tileH:int = 300;
		public function setTileH(value:int):void
		{
			tileH= value;
		}
		public function getTileH():int { return tileH; }
		
		public function getTileCol():int
		{ 
			return Math.ceil(mapWidth/tileW);
		}
		
		public function getTileRow():int
		{
			return Math.ceil(mapHeight/tileH);
		}
		
		public function isLegal():Boolean
		{
			if(mapName == null || mapName == "") return false;
			if(mapId == 0) return false;
			if(gridW <= 0) return false;
			if(gridH <= 0) return false;
			if(mapPicFile == null) return false;
			if(mapSpaceFile == null) return false;
			if(mapPicAddr.indexOf(mapSpaceDir) == -1) return false;
			return true;
		}
		
		/** 网格线是否可见 */
		public var VIEW_NET:Boolean = true;
		/** 底色是否可见 */
		public var VIEW_BG:Boolean = true;
		/** 坐标点是否可见 */
		public var VIEW_POINT:Boolean = true;
		/** 阻碍点是否可见 */
		public var VIEW_BLOCK:Boolean = true;
		/** 遮罩点是否可见 */
		public var VIEW_MASK:Boolean = true;
		/** 摆摊点是否可见 */
		public var VIEW_STALL:Boolean = true;
		/** 传送点是否可见 */
		public var VIEW_DELIVER:Boolean = true;
		/** 数字标识是否可见 */
		public var VIEW_NUM_TAG:Boolean = true;
		
		/** 绘制透明度 */
		public var DRAW_ALPHA:Number = 0.6;
		
		/** 绘制笔刷大小 */
		public var BRUSH_SIZE:int = 0;
		
		/** 是否是阻碍点 */
		public var IS_BLOCK_BRUSH:Boolean = false;
		/** 是否是遮罩点 */
		public var IS_MASK_BRUSH:Boolean = false;
		/** 是否是摆摊点 */
		public var IS_STALL_BRUSH:Boolean = false;
		/** 是否是传送点 */
		public var IS_DELIVER_BRUSH:Boolean = false;
		/** 传送点数值 */
		public var DELIVER_BRUSH_VAL:int = 0;
		/** 是否是数字标识位 */
		public var IS_NUM_TAG_BRUSH:Boolean = false;
		/** 数字标识位的数值 */
		public var NUM_TAG_BRUSH_VAL:int = 0;
		
		/** 是否是高性能表现 */
		public var HIGH_PERFORM:Boolean = false;
		
		public function WorkConfig()
		{
		}
		
		public function clear():void
		{
			setMapName("");
			setMapId(0);
			setGridW(0);
			setGridH(0);
			setMapPicAddr("");
			setMapSpaceDir("");
			setMapWidth(0);
			setMapHeight(0);
			setTileW(500);
			setTileH(300);
		}
		
		public function decode(obj:Object):void
		{
			var cfg:Object;
			if(obj is String)
			{
				cfg = new Object();
				var items:Array = String(obj).split("\r\n");
				for(var i:int = 0; i < items.length; i++)
				{
					var item:String = items[i];
					var key:String = item.split("=")[0];
					var value:String = item.split("=")[1];
					cfg[key] = value;
				}
			}
			else
			{
				cfg = obj;
			}
			setMapId(cfg["map_id"]);
			setMapName(cfg["map_name"]);
			setMapPicAddr(getMapSpaceDir() + "\\" + cfg["map_pic"]);
			setMapWidth(cfg["map_w"]);
			setMapHeight(cfg["map_h"]);
			setGridW(cfg["grid_w"]);
			setGridH(cfg["grid_h"]);
			setTileW(cfg["tile_w"]);
			setTileH(cfg["tile_h"]);
		}
		
		public function encode():String
		{
			var ret:String = "map_id=" + getMapId() + "\r\n" +
				"map_name=" + getMapName() + "\r\n" + 
				"map_pic=" + getMapPicAddr().replace(getMapSpaceDir()+"\\", "") + "\r\n" +
				"map_w=" + getMapWidth() + "\r\n" + 
				"map_h=" + getMapHeight() + "\r\n" + 
				"grid_w=" + getGridW() + "\r\n" + 
				"grid_h=" + getGridH() + "\r\n" + 
				"tile_w=" + getTileW() + "\r\n" + 
				"tile_h=" + getTileH() + "\r\n" + 
				"tile_col=" + getTileCol() + "\r\n" + 
				"tile_row=" + getTileRow();
			return ret;
		}
		
		public function toString():String
		{
			var ret:String = "地图名字:" + mapName + " 地图ID:" + mapId +
				" 格子宽:" + gridW + " 格子高:" + gridH + 
				" 切片宽" + tileW + " 切片高" + tileH + "\r\n" +
				"地图图片地址:" + mapPicAddr + " 地图配置文件输出位置:" + mapSpaceDir + "\r\n" +
				"网格线" + VIEW_NET + " 底色" + VIEW_BG + " 坐标点" + VIEW_POINT + " 阻碍点" + VIEW_BLOCK +
				" 遮罩点" + VIEW_MASK + " 摆摊点" + VIEW_STALL + " 传送点" + VIEW_DELIVER + " 数字标识" + VIEW_NUM_TAG;
			return ret;
		}
		
	}
}