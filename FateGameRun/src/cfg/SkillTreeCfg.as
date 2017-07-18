package cfg
{
	import flash.utils.Dictionary;
	
	import gamekit.utils.StrParser;

	public class SkillTreeCfg
	{
		public static const TYPE:String = "skill_tree";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):SkillTreeCfg
		{
			return cfgs[id];
		}
		
		/** 所属职业 */
		public var id:int = 0;
		/** 描述 */
		public var desc:String = "";
		/** 技能ids */
		public var skillIds:Array = [];
		/** 技能levels */
		public var skillLevels:Array = [];
		
		public function SkillTreeCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:SkillTreeCfg = new SkillTreeCfg();
				c.id = parseInt(dataDic["所属职业"][i]);
				c.desc = (dataDic["描述"][i]);
				
				var skillIdsStr:String = dataDic["技能ids"][i];
				c.skillIds = StrParser.str2arrInt(skillIdsStr, ",");
				var skillLevelsStr:String = dataDic["技能levels"][i];
				c.skillLevels = StrParser.str2arrInt(skillLevelsStr, ",");
				
				trace(c);
				cfgs[c.id] = c;
			}
		}
		
		
		public function toString():String
		{
			return "[SkillTreeCfg] id:" + id + " desc:" + desc
				+ " skillIds=" + skillIds + " skillLevels=" + skillLevels;
		}
		
		
	}
}