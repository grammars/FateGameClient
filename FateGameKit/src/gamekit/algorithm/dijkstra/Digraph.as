package gamekit.algorithm.dijkstra
{
	public class Digraph
	{
		public static const INFINITY:Number = 999999999;
		
		/** 顶点们 */
		private var vertexes:Vector.<DigraphVertex> = new Vector.<DigraphVertex>();
		/** 邻接矩阵  matrix[i][j]表示 从节点i到节点j的累计权值 */
		private var matrix:Array;
		
		public function Digraph()
		{
		}
		
		public function addVertex(vertex:DigraphVertex):void
		{
			vertexes.push(vertex);
			setValue(vertex.name, vertex.name, 0);
		}
		
		public function getVertex(name:String):DigraphVertex
		{
			for(var i:int = 0; i < vertexes.length; i++)
			{
				var v:DigraphVertex = vertexes[i];
				if(v.name == name) { return v; }
			}
			return null;
		}
		
		public var valueMap:Object = new Object();
		
		/** 到目标点的权值 */
		public function setValue(fromVName:String, toVName:String, value:Number):void
		{
			var key:String = fromVName+"->"+toVName;
			valueMap[key] = value;
			
//			if(toVName != fromVName)
//			{
//				getVertex(toVName).preVertex = getVertex(fromVName);
//			}
		}
		/** 获取到目标点的权值 */
		public function getValue(fromVName:String, toVName:String):Number
		{
			var key:String = fromVName+"->"+toVName;
			if(valueMap[key]) return valueMap[key];
			return INFINITY;
		}
		
		
		/** 生成有向图
		 * @param vertexNum:int 顶点数 */
		public function find(startVtxName:String, endVtxName:String):Vector.<DigraphVertex>
		{
			var startV:DigraphVertex = getVertex(startVtxName);
			if(!startV) { return null; }
			var endV:DigraphVertex = getVertex(endVtxName);
			if(!endV) { return null; }
			
			var i:int = 0;
			var j:int = 0;
			
			for(i = 0; i < vertexes.length; i++)
			{
				var v:DigraphVertex = vertexes[i];
				v.preVertex = null;
			}
			var v:DigraphVertex;
			
			var S:Vector.<DigraphVertex> = new Vector.<DigraphVertex>();
			var U:Vector.<DigraphVertex> = new Vector.<DigraphVertex>();
			S.push(startV);
			for(i = 0; i < vertexes.length; i++)
			{
				v = vertexes[i];
				if(v != startV) { U.push(v); }
			}
			
			while(U.length > 0)
			{
				var min:Number = INFINITY;
				var k:int = -1;
				for(i = 0; i < U.length; i++)
				{
					v = U[i];
					var val:Number = getValue(startV.name, v.name);
					if(val < min)
					{
						min = val;
						k = i;
					}
				}
				if(k == -1) { break; }//没有任何点跟起始点相通
				var midV:DigraphVertex = U[k];
				//
				S.push(midV);
				U.splice(k,1);
				for(i = 0; i < U.length; i++)
				{
					var v:DigraphVertex = U[i];
					var gapVal:Number = getValue(midV.name, v.name);
					if( (min+gapVal) < getValue(startV.name, v.name))
					{
						setValue(startV.name, v.name, min+gapVal);
						v.preVertex = midV;
					}
				}
			}
			
			var steps:Vector.<DigraphVertex> = new Vector.<DigraphVertex>();
			var valueResult:Number = getValue(startVtxName, endVtxName);
			if(valueResult >= INFINITY) { return null; }
			var pv:DigraphVertex = endV;
			while(pv)
			{
				steps.push(pv);
				if(startV == pv) { break; }
				pv = pv.preVertex;
			}
			steps.push(startV);
			return steps;
		}
		
		public function print(startVtxName:String, endVtxName:String):void
		{
			var debug:String = "print:";
			var steps:Vector.<DigraphVertex> = find(startVtxName, endVtxName);
			while(steps && steps.length > 0)
			{
				var v:DigraphVertex = steps.pop();
				debug += v.name + " -> ";
			}
			trace(debug);
		}
		
	}
}