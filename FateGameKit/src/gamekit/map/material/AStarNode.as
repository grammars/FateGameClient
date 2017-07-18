package gamekit.map.material
{
	public class AStarNode
	{
		/** F = G + H */
		public var F:int = 0;
		/** 从起点A，沿着产生的路径，移动到网格上指定方格的移动耗费 */
		public var G:int = 0;
		/** 从网格上那个方格移动到终点B的预估移动耗费 */
		public var H:int = 0;
		
		/** 父节点 */
		public var parentNode:AStarNode;
		
		/** 是否是阻碍点 */
		public var isBlock:Boolean = false;
		
		/** 序列x */
		public var ind_X:int;
		/** 序列y */
		public var ind_Y:int;
		
		public function AStarNode(ix:int=0, iy:int=0)
		{
			this.ind_X = ix;
			this.ind_Y = iy;
		}
		
		
		public function toString():String
		{
			return "(" + ind_X + "," + ind_Y + ")";
		}
		
		public function equals(node:AStarNode):Boolean
		{
			if(node == null) { return false; }
			if(this.ind_X == node.ind_X && this.ind_Y == node.ind_Y)
			{
				return true;
			}
			return false;
		}
	}
}