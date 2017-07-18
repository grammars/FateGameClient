package gamekit.utils
{
	import gamekit.ds.pair.PairIntInt;

	public class StrParser
	{
		public function StrParser()
		{
		}
		
		/** String变成int[] */
		public static function str2arrInt(src:String, delim:String):Array
		{
			var strArr:Array = src.split(delim);
			const size:int = strArr.length;
			var result:Array = [];
			for(var i:int = 0; i < size; i++)
			{
				result.push( parseInt(strArr[i]) );
			}
			return result;
		}
		
		/** String变成Number[] */
		public static function str2arrNumber(src:String, delim:String):Array
		{
			var strArr:Array = src.split(delim);
			const size:int = strArr.length;
			var result:Array = [];
			for(var i:int = 0; i < size; i++)
			{
				result.push( parseFloat(strArr[i]) );
			}
			return result;
		}
		
		/** String变成Boolean[] */
		public static function str2arrBoolean(src:String, delim:String):Array
		{
			var strArr:Array = src.split(delim);
			const size:int = strArr.length;
			var result:Array = [];
			for(var i:int = 0; i < size; i++)
			{
				var unit:String = strArr[i];
				if(unit == "false" || unit == "0")
				{
					result.push( false );
				}
				else
				{
					result.push( true );
				}
			}
			return result;
		}
		
		/** String 9100341:2#9100342:13
		 * 变成Vector.<PairIntInt> */
		public static function toIntIntPair(str:String):Vector.<PairIntInt>
		{
			var pairs:Vector.<PairIntInt> = new Vector.<PairIntInt>();
			var items:Array = str.split("#");
			for(var i:int = 0; i < items.length; i++)
			{
				var itemStr:String = items[i];
				var kv:Array = itemStr.split(":");
				if(kv.length < 2) { break; }
				var p:PairIntInt = new PairIntInt();
				p.key = parseInt(kv[0]);
				p.value = parseInt(kv[1]);
				pairs.push(p);
			}
			return pairs;
		}
		
		
	}
}