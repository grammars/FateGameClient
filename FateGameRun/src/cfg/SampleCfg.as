package cfg
{
	import flash.utils.Dictionary;

	public class SampleCfg
	{
		public static const TYPE:String = "sample";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):SampleCfg
		{
			return cfgs[id];
		}
		
		/** 整数字段 */
		public var id:int = 0;
		/** 字符串字段 */
		public var name:String = "";
		/** 浮点字段 */
		public var score:Number = 0;
		
		public function SampleCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:SampleCfg = new SampleCfg();
				c.id = parseInt(dataDic["整数字段"][i]);
				c.name = (dataDic["字符串字段"][i]);
				c.score = parseFloat(dataDic["浮点字段"][i]);
				trace(c);
				cfgs[c.id] = c;
			}
		}
		
		
		public function toString():String
		{
			return "[SampleCfg] id:" + id + " name:" + name
				+ " score=" + score;
		}
		
	}
}