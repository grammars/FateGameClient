package cfg
{
	import flash.utils.Dictionary;
	
	public class VocCfg
	{
		public static const TYPE:String = "voc";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):VocCfg
		{
			return cfgs[id];
		}
		
		/** 职业id */
		public var id:int = 0;
		/** 职业名称 */
		public var name:String = "";
		/** 职业描述 */
		public var desc:String = "";
		/** 普攻远程 */
		public var isRemoteHit:Boolean = false;
		/** 普攻距离 */
		public var hitDistance:Number = 1.6;
		/** 普攻飞行毫秒 */
		public var hitFlyTime:int = 0;
		/** 普工飞行特效 */
		public var hitFlyEffect:String = "null";
		
		public function VocCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:VocCfg = new VocCfg();
				c.id = parseInt(dataDic["职业id"][i]);
				c.name = (dataDic["职业名称"][i]);
				c.desc = (dataDic["职业描述"][i]);
				c.isRemoteHit = parseInt(dataDic["普攻远程"][i]) != 0;
				c.hitDistance = parseFloat(dataDic["普攻距离"][i]);
				c.hitFlyTime = parseInt(dataDic["普攻飞行毫秒"][i]);
				c.hitFlyEffect = (dataDic["普工飞行特效"][i]);
				trace(c);
				cfgs[c.id] = c;
			}
		}
		
		/** 根据职业id获取职业名称 */
		public static function getVocName(vocId:int):String
		{
			var c:VocCfg = get(vocId);
			if(c) { return c.name; }
			return "未定义职业";
		}
		
		public function toString():String
		{
			return "[VocCfg] id:" + id + " name:" + name + " desc:" + desc
				+ " isRemoteHit:" + isRemoteHit + " hitDistance:" + hitDistance
				+ " hitFlyTime:" + hitFlyTime + " hitFlyEffect:" + hitFlyEffect;
		}
	}
}