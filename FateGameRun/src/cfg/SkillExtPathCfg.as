package cfg
{
	import flash.utils.Dictionary;

	public class SkillExtPathCfg
	{
		public static const TYPE:String = "skill_ext_path";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):SkillExtPathCfg
		{
			return cfgs[id];
		}
		
		/** id */
		public var id:int = 0;
		/** 技能名 */
		public var name:String = "";
		/** Path飞行特效 */
		public var pathFlyEffect:String = "";
		/** Path飞行每格耗时 */
		public var pathFlyGridTime:int = 0;
		/** Path最大作用次数 */
		public var pathUseMaxTimes:int = 0;
		/** Path停飞作用次数 */
		public var pathStopFlyUseTimes:int = 0;
		/** Path作用特效 */
		public var pathHitEffect:String = "";
		
		public function SkillExtPathCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:SkillExtPathCfg = new SkillExtPathCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["技能名"][i]);
				c.pathFlyEffect = (dataDic["Path飞行特效"][i]);
				c.pathFlyGridTime = parseInt(dataDic["Path飞行每格耗时"][i]);
				c.pathUseMaxTimes = parseInt(dataDic["Path最大作用次数"][i]);
				c.pathStopFlyUseTimes = parseInt(dataDic["Path停飞作用次数"][i]);
				c.pathHitEffect = (dataDic["Path作用特效"][i]);
				
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		
		public function toString():String
		{
			return "[SkillExtPathCfg] id:" + id + " name:" + name 
				+ " pathFlyEffect=" + pathFlyEffect + " pathFlyGridTime=" + pathFlyGridTime
				+ " pathUseMaxTimes=" + pathUseMaxTimes + " pathStopFlyUseTimes=" + pathStopFlyUseTimes
				+ " pathHitEffect=" + pathHitEffect;
		}
		
	}
}