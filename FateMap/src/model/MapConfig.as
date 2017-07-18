package model
{
	import flash.utils.ByteArray;

	public class MapConfig
	{
		private static var _me:MapConfig;
		public static function me():MapConfig
		{
			if(_me == null) { _me = new MapConfig(); }
			return _me;
		}
		
//		/** 阻碍点信息,元素Boolean */
//		private var blockArr:Array;
//		/** 遮罩点信息,元素Boolean */
//		private var maskArr:Array;
//		/** 摆摊点信息,元素Boolean */
//		private var stallArr:Array;
//		/** 传送点信息,元素Boolean */
//		private var deliverArr:Array;
//		/** 数字标识信息,元素int */
//		private var numTagArr:Array;
		
		private var grids:Vector.<StGrid>;
		public function getGrids():Vector.<StGrid> { return grids; }
		
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
		
		/** 获取被标记的次数 */
		public function getMarkCount(ind:int):int
		{
			if(ind >= getTotalGridsCount()) { return -1; }
			var count:int = 0;
			if(grids[ind].isBlock == true) { count++; }
			if(grids[ind].isMask == true) { count++; }
			if(grids[ind].isStall == true) { count++; }
			if(grids[ind].isDeliver == true) { count++; }
			if(grids[ind].isNumTag == true) { count++; }
			return count;
		}
		
		public function MapConfig()
		{
		}
		
		public function install():void
		{
			if(WorkConfig.me().isLegal() == false) { return; }
			gridCountX = Math.floor( WorkConfig.me().getMapWidth() / WorkConfig.me().getGridW() );
			gridCountY = Math.floor( WorkConfig.me().getMapHeight() / WorkConfig.me().getGridH() );
			const total:int = gridCountX * gridCountY;
			grids = new Vector.<StGrid>(total);
			for(var i:int = 0; i < total; i++)
			{
				grids[i] = new StGrid();
			}
		}
		
		public function uninstall():void
		{
			grids = null;
			gridCountX = 0;
			gridCountY = 0;
		}
		
		public function encode():ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeInt(WorkConfig.me().getMapId());
			bytes.writeInt(gridCountX);
			bytes.writeInt(gridCountY);
			for(var i:int = 0; i < grids.length; i++)
			{
				bytes.writeBytes(grids[i].encode());
			}
			return bytes;
		}
		
		public function decode(bytes:ByteArray):Boolean
		{
			if(bytes.bytesAvailable < 12)
			{
				return false;
			}
			var mapid:int = bytes.readInt();
			gridCountX = bytes.readInt();
			gridCountY = bytes.readInt();
			for(var i:int = 0; i < grids.length; i++)
			{
				var ret:Boolean = grids[i].decode(bytes);
				if(ret == false) { return false; }
			}
			return true;
		}
		
	}
}