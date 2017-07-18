package gamekit.map.material
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import gamekit.map.events.MapConfigEvent;
	import gamekit.map.events.MapMonitor;

	public class MapConfig
	{
		private var META_DONE:Boolean = false;
		/** 来自metadata的数据接收完毕 */
		public function metaDone():void
		{
			META_DONE = true;
			checkFullDone();
		}
		private var CFG_DONE:Boolean = false;
		/** 来自.map的数据接收完毕 */
		public function cfgDone():void
		{
			CFG_DONE = true;
			checkFullDone();
		}
		/** 检查是否MapConfig被完整部署了 */
		private function checkFullDone():void
		{
			if(META_DONE && CFG_DONE)
			{
				MapConfigEvent.dispatchMapConfigFullDone(this);
			}
		}
		
		private var grids:Vector.<StGrid>;
		public function getGrids():Vector.<StGrid> { return grids; }
		
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
		
		/** X轴上的格子个数 */
		private var gridCountX:int = 0;
		/** X轴上的格子个数 */
		public function getGridCountX():int { return gridCountX; }
		/** Y轴上的格子个数 */
		private var gridCountY:int = 0;
		/** Y轴上的格子个数 */
		public function getGridCountY():int { return gridCountY; }
		/** 格子总数 */
		public function getTotalGridsCount():int { return gridCountX * gridCountY; }
		
		
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
		
		private var tileWidth:int = 0;
		public function setTileWidth(w:int):void
		{
			tileWidth = w;
		}
		public function getTileWidth():int { return tileWidth; }
		
		private var tileHeight:int = 0;
		public function setTileHeight(h:int):void
		{
			tileHeight = h;
		}
		public function getTileHeight():int { return tileHeight; }
		
		private var tileCol:int = 0;
		public function setTileCol(c:int):void
		{
			tileCol = c;
		}
		public function getTileCol():int { return tileCol; }
		
		private var tileRow:int = 0;
		public function setTileRow(r:int):void
		{
			tileRow = r;
		}
		public function getTileRow():int { return tileRow; }
			
		public function MapConfig()
		{
		}
		
		private function install():void
		{
			const total:int = gridCountX * gridCountY;
			grids = new Vector.<StGrid>(total);
			for(var i:int = 0; i < gridCountY; i++)
			{
				for(var j:int = 0; j < gridCountX; j++)
				{
					var g:StGrid = new StGrid();
					g.ind_X = j;
					g.ind_Y = i;
					grids[i * gridCountX + j] = g;
				}
			}
		}
		
		private function uninstall():void
		{
			grids = null;
			gridCountX = 0;
			gridCountY = 0;
		}
		
		/** 在某一范围内，寻找最合适的非阻碍点 */
		public function retrieveNonBlockNode(bestX:int, bestY:int, range:int=10):AStarNode
		{
			var arr:Array = AroundTraver.find(bestX, bestY, range);
			for(var i:int = 0; i < arr.length; i++)
			{
				var pt:Point = arr[i];
				var node:AStarNode = getNonBlockNode(pt.x, pt.y);
				if(node) { return node; }
			}
			return null;
		}
		
		/** 获取非阻碍点 */
		public function getNonBlockNode(iX:uint, iY:uint):AStarNode
		{
			if (iX < 0 || iX >= gridCountX || iY < 0 || iY >= gridCountY)
			{
				return null;
			}
			var node:AStarNode = grids[iY*gridCountX+iX] as AStarNode;
			if (!node.isBlock)
			{
				return node;
			}
			return null;
		}
		
		
		/** 获取阻碍点*/
		public function getBlockNode(iX:uint, iY:uint):AStarNode
		{
			if (iX < 0 || iX >= gridCountX || iY < 0 || iY >= gridCountY)
			{
				return null;
			}
			var node:AStarNode = grids[iY*gridCountX+iX] as AStarNode;
			if (node.isBlock)
			{
				return node;
			}
			return null;
		}
		
		/** 是否是阻碍点 */
		public function isBlock(iX:uint, iY:uint):Boolean
		{
			if (iX < 0 || iX >= gridCountX || iY < 0 || iY >= gridCountY)
			{
				return true;
			}
			var node:AStarNode = grids[iY*gridCountX+iX] as AStarNode;
			return node.isBlock;
		}
		
		public function decodeMeta(obj:Object):void
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
			setGridW(cfg["grid_w"]);
			setGridH(cfg["grid_h"]);
			setMapWidth(cfg["map_w"]);
			setMapHeight(cfg["map_h"]);
			setTileWidth(cfg["tile_w"]);
			setTileHeight(cfg["tile_h"]);
			setTileCol(cfg["tile_col"]);
			setTileRow(cfg["tile_row"]);
		}
		
		public function decodeCfg(bytes:ByteArray):Boolean
		{
			if(bytes.bytesAvailable < 12)
			{
				return false;
			}
			var mapid:int = bytes.readInt();
			gridCountX = bytes.readInt();
			gridCountY = bytes.readInt();
			//
			install();
			//
			for(var i:int = 0; i < grids.length; i++)
			{
				var ret:Boolean = grids[i].decode(bytes);
				if(ret == false) { return false; }
			}
			return true;
		}
		
		public function toString():String
		{
			return "[MapConfig] id=" + mapId + " name=" + mapName + " gw=" + gridW + " gh=" + gridH
				+ " col=" + gridCountX + " row=" + gridCountY;
		}
		
	}
}