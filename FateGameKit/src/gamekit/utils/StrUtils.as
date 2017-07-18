package gamekit.utils
{
	public class StrUtils
	{
		public function StrUtils()
		{
		}
		
		/** 将分子分母转成百分比字符串 */
		public static function percent(p1:Number, p2:Number, precision:int=0):String
		{
			if(p2 == 0) { return "error%" }
			var value:int = (p1*Math.pow(10, precision+2)) / (p2*Math.pow(10, precision));
			return value + "%";
		}
		
		/** 将一个自然数转成一个固定长度的string,不足补零,超出或者等于就不补零<br>
		 * 比如： (27, 4)="0027" (3, 2)="03" */
		public static function uintFixLen(value:uint, fixLen:uint, radix:*=10):String
		{
			var str:String = value.toString(radix);
			var osize:int = str.length;
			for(var i:int = 0; i < fixLen-osize; i++)
			{
				str = "0" + str;
			}
			return str;
		}
		
	}
}