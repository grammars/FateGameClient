package gamekit.utils
{
	import gamekit.avatar.material.AvatarDisplay;

	public class GeomUtils
	{
		public function GeomUtils()
		{
		}
		
		/** 计算距离 */
		public static function distance(fromX:Number, fromY:Number, toX:Number, toY:Number):Number
		{
			var sq:Number = Math.pow(toX-fromX, 2) + Math.pow(toY-fromY, 2);
			return Math.sqrt(sq);
		}
		
		/** 计算两个avatar之间的格子距离数 */
		public static function gridDistance(A:AvatarDisplay, B:AvatarDisplay):Number
		{
			return distance(A.getGridX(), A.getGridY(), B.getGridX(), B.getGridY());
		}
		
	}
}