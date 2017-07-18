package cfg
{
	import flash.utils.Dictionary;

	public class SkillExtAimCfg
	{
		public static const TYPE:String = "skill_ext_aim";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):SkillExtAimCfg
		{
			return cfgs[id];
		}
		
		/** id */
		public var id:int = 0;
		/** 技能名 */
		public var name:String = "";
		/** Aim对自己使用 */
		public var aimSelf:Boolean = false;
		/** Aim最大目标数 */
		public var aimMaxCount:int = 0;
		/** Aim范围 */
		public var aimRange:int = 0;
		/** Aim飞行特效 */
		public var aimFlyEffect:String = "";
		/** Aim飞行每格耗时 */
		public var aimFlyGridTime:int = 0;
		/** Aim作用特效 */
		public var aimHitEffect:String = "";
		
		public function SkillExtAimCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:SkillExtAimCfg = new SkillExtAimCfg();
				
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["技能名"][i]);
				c.aimSelf = parseInt(dataDic["Aim对自己使用"][i]) == 1;
				c.aimMaxCount = parseInt(dataDic["Aim最大目标数"][i]);
				c.aimRange = parseInt(dataDic["Aim范围"][i]);
				c.aimFlyEffect = (dataDic["Aim飞行特效"][i]);
				c.aimFlyGridTime = parseInt(dataDic["Aim飞行每格耗时"][i]);
				c.aimHitEffect = (dataDic["Aim作用特效"][i]);
				
				//trace(c);
				cfgs[c.id] = c;
			}
		}
		
		
		public function toString():String
		{
			return "[SkillExtAimCfg] id:" + id + " name:" + name
				+ " aimSelf=" + aimSelf + " aimMaxCount=" + aimMaxCount 
				+ " aimRange=" + aimRange + " aimFlyEffect=" + aimFlyEffect
				+ " aimFlyGridTime=" + aimFlyGridTime + " aimHitEffect=" + aimHitEffect;
		}
	}
}