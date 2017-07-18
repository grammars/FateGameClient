package gamekit.ds
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class Map
	{
		private var dic:Dictionary = new Dictionary();
		private var key_arr:Array = new Array();
		private var value_arr:Array = new Array();
		
		/** key:index in arr */
		private var arr_indices:Dictionary = new Dictionary();
		
		public function Map()
		{
		}
		
		public function keys():Array { return key_arr; }
		public function values():Array { return value_arr; }
		
		public function clear():void
		{
			dic = new Dictionary();
			key_arr = new Array();
			value_arr = new Array();
			
			arr_indices = new Dictionary();
		}
		
		private function getIndexInArr(key:Object):int
		{
			if(undefined == arr_indices[key])
			{
				throw new Error("arr_indices error");
			}
			var index_in_arr:int = arr_indices[key];
			return index_in_arr;
		}
		
		public function put(key:Object, value:Object):void
		{
			if(!dic[key])
			{
				key_arr.push(key);
				value_arr.push(value);
			}
			else
			{
				var index_in_arr:int = getIndexInArr(key);
				key_arr.splice(index_in_arr, 1, key);
				value_arr.splice(index_in_arr, 1, value);
			}
			dic[key] = value;
			arr_indices[key] = key_arr.length-1;
		}
		
		public function get(key:Object):Object
		{
			return dic[key];
		}
		
		public function remove(key:Object):Object
		{
			if(!dic[key])
			{
				return null;
			}
			var value:Object = dic[key];
			delete dic[key];
			var index_in_arr:int = getIndexInArr(key);
			key_arr.splice(index_in_arr, 1);
			value_arr.splice(index_in_arr, 1);
			delete arr_indices[key];
			return value;
		}
		
		public function size():int
		{
			return key_arr.length;
		}
		
		public function print(bNeedTrace:Boolean=true):String
		{
			var debugStr:String = "";
			for(var i:int = 0; i < key_arr.length; i++)
			{
				debugStr += "[" + key_arr[i] + "]" + value_arr[i] + " ; ";
			}
			if(bNeedTrace)
			{
				trace(debugStr);
			}
			return debugStr;
		}
		
		public static function test():void
		{
			var map:Map = new Map();
			map.put("a", "A_value");
			var strOne:String = "1";
			map.put(strOne, "strOne");
			//map.put(1, "numOne");
			map.print();
			map.put("a", "New_AV");
			map.put(new Sprite(), "sp1");
			map.put(new Sprite(), "sp2");
			map.print();
			map.remove(1);
			map.print();
		}
		
	}
}