package gamekit.map.material
{

	public class AStarEngine
	{
		/** 对角移动付出的代价 */
		private static const COST_DIAGONAL:int = 14;
		/** 直线移动付出的代价 */
		private static const COST_STRAIGHT:int = 10;
		
		/** 最大路径限制 */
		private static const PATH_MAX:int = 768;
		
		/** 关闭列表（不再处理的节点）*/
		private var _closeList:Array = [];
		
		/** 当前节点 */
		private var _curNode:AStarNode;
		
		/** 开始节点 */
		private var _startNode:AStarNode;
		/** 结束节点 */
		private var _endNode:AStarNode;
		
		/** 地图配置 */
		private var _cfg:MapConfig;
		
		/** 开放列表（等待处理的节点）*/
		private var _openList:Array = [];
		
		/** 父节点路径 */
		private var _parentNodes:Array;
		
		public function AStarEngine()
		{
			//
		}
		
		/** 设置地图配置 */
		public function setMapCfg(cfg:MapConfig):void
		{
			this._cfg = cfg;
		}
		/** 获取地图配置 */
		public function getMapCfg():MapConfig { return _cfg; }
		
		/** 开始寻路(没有包含起始Node[startX,startY]) */
		public function findPath(startX:int, startY:int, endX:int, endY:int):Array
		{
			//trace("寻路：从("+startX+","+startY+")到("+endX+","+endY+")");
			_openList = [];
			_closeList = [];
			_startNode = null;
			_endNode = null;
			_curNode = null;
			_startNode = _cfg.getNonBlockNode(startX, startY);
			_endNode = _cfg.getNonBlockNode(endX, endY);
			if (!_startNode || !_endNode)
			{
				return [];
			}
			//用于计算寻路的节点的尝试次数
			var times:int = 0;
			_parentNodes = [];
			_startNode.parentNode = null;
			_openList.push(_startNode);
			while (true)
			{
				if (_openList.length < 1 || times >= PATH_MAX)
				{
					return [];
				}
				_curNode = _openList.shift();
				//trace("引擎==>_openList.shift() ", _curNode);
				if (_curNode == _endNode)
				{
					//trace("引擎==>while!= ", _curNode.parentNode, _startNode.parentNode);
					while (_curNode.parentNode != _startNode.parentNode)
					{
						_parentNodes.push(_curNode);
						_curNode = _curNode.parentNode;
					}
					return _parentNodes.reverse();
					break;
				}
				_closeList.push(_curNode);
				detectionAround();
				times++;
			}
			return [];
		}
		
		
		/** 检测四周的节点 */
		private function detectionAround():void
		{
			var iX:int=_curNode.ind_X;
			var iY:int=_curNode.ind_Y;
			addOpenList(_cfg.getNonBlockNode(iX - 1, iY), COST_STRAIGHT); //左
			addOpenList(_cfg.getNonBlockNode(iX + 1, iY), COST_STRAIGHT); //右			
			addOpenList(_cfg.getNonBlockNode(iX, iY - 1), COST_STRAIGHT); //上
			addOpenList(_cfg.getNonBlockNode(iX, iY + 1), COST_STRAIGHT); //下
			addOpenList(_cfg.getNonBlockNode(iX + 1, iY - 1), COST_DIAGONAL);
			addOpenList(_cfg.getNonBlockNode(iX + 1, iY + 1), COST_DIAGONAL);
			addOpenList(_cfg.getNonBlockNode(iX - 1, iY - 1), COST_DIAGONAL);
			addOpenList(_cfg.getNonBlockNode(iX - 1, iY + 1), COST_DIAGONAL);
			_openList.sortOn('F', Array.NUMERIC);
		}
		
		
		/** 路径评估(距离优先) */
		private function getFGH(node:AStarNode, cost:int):void
		{
			var valG:int = _curNode.G + cost;
			node.G = valG < node.G ? valG + cost : node.G;
			node.H = ( Math.abs(node.ind_X - _endNode.ind_X) + Math.abs(node.ind_Y - _endNode.ind_Y) ) * 10;
			node.F = node.G + node.H;
		}
		
		
		/** 添加一个节点到开放列表 */
		private function addOpenList(node:AStarNode, cost:int):Boolean
		{
			//trace("引擎==>addOpenList::开始", node);
			//可走且不在关闭列表里
			if (node && !node.isBlock && _closeList.indexOf(node) < 0)
			{
				//不在开放列表中
				if (_openList.indexOf(node) < 0)
				{
					node.F=0;
					node.G=0;
					node.H=0;
					node.parentNode = _curNode;
					getFGH(node, cost);
					_openList.push(node);
					//trace("引擎==>addOpenList::不在开放列表中node=", node, " _curNode=", _curNode);
					return true;
				}
			}
			return false;
		}
		
		
	}
}