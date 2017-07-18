package gamekit.algorithm.dijkstra
{
	public class DigraphVertex
	{
		public var name:String;
		public var preVertex:DigraphVertex;
		/** 绑定数据 */
		public var data:Object;
		
		public function DigraphVertex(name:String)
		{
			this.name = name;
		}
		
	}
}