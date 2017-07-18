package imp
{
	public class XGrid
	{
		public static var counter:int = 0;
		
		public var x:int;
		public var y:int;
		
		public var index:int;
		
		public function XGrid()
		{
			index = XGrid.counter++;
		}
	}
}