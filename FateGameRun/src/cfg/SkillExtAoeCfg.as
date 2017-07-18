package cfg
{
	import flash.utils.Dictionary;

	public class SkillExtAoeCfg
	{
		public static const TYPE:String = "skill_ext_aoe";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):SkillExtAoeCfg
		{
			return cfgs[id];
		}
		
		/** id */
		public var id:int = 0;
		/** 技能名 */
		public var name:String = "";
		/** Aoe范围 */
		public var aoeRangeStr:String = "";
		/** Aoe预览 */
		public var aoePreview:String = "";
		/** Aoe特效 */
		public var aoeEffect:String = "";
		/** Aoe特效时长 */
		public var aoeEffectTime:int = 0;
		/** Aoe生命时长 */
		public var aoeLifeTime:int = 0;
		/** Aoe作用延迟 */
		public var aoeUseDelay:int = 0;
		/** Aoe作用次数 */
		public var aoeUseTimes:int = 0;
		/** Aoe作用间隔 */
		public var aoeUseInterval:int = 0;
		
		public function SkillExtAoeCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:SkillExtAoeCfg = new SkillExtAoeCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["技能名"][i]);
				
				c.aoeRangeStr = (dataDic["Aoe范围"][i]);
				c.aoeEffect = (dataDic["Aoe特效"][i]);
				c.aoePreview = (dataDic["Aoe预览"][i]);
				c.aoeEffectTime = parseInt(dataDic["Aoe特效时长"][i]);
				c.aoeLifeTime = parseInt(dataDic["Aoe生命时长"][i]);
				c.aoeUseDelay = parseInt(dataDic["Aoe作用延迟"][i]);
				c.aoeUseTimes = parseInt(dataDic["Aoe作用次数"][i]);
				c.aoeUseInterval = parseInt(dataDic["Aoe作用间隔"][i]);
				
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		
		public function toString():String
		{
			return "[SkillExtAoeCfg] id:" + id + " name:" + name + " aoeRangeStr=" + aoeRangeStr
				+ " aoePreview=" + aoePreview
				+ " aoeEffect=" + aoeEffect + " aoeEffectTime=" + aoeEffectTime
				+ " aoeLifeTime=" + aoeLifeTime + " aoeUseDelay=" + aoeUseDelay
				+ " aoeUseTimes=" + aoeUseTimes + " aoeUseInterval=" + aoeUseInterval;
		}
		
	}
}