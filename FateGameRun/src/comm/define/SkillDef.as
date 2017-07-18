package comm.define
{
	public class SkillDef
	{
		/** 类型::瞬时必中技能 */
		public static const TYPE_AIM:int = 1;
		/** 类型::非瞬时AOE技能 */
		public static const TYPE_AOE:int = 2;
		/** 类型::非瞬时轨迹技能 */
		public static const TYPE_PATH:int = 3;
		
		public var type:int;
		public var label:String;
		
		public function SkillDef()
		{
		}
		
		/** typeStr */
		public static function typeStr(type:int):String
		{
			switch(type)
			{
			case TYPE_AIM: return "瞬时必中";
			case TYPE_AOE: return "非瞬时AOE";
			case TYPE_PATH: return "非瞬时轨迹";
			}
			return "未定义技能类型";
		}
		
		public static function makeItem(type:int):SkillDef
		{
			var def:SkillDef = new SkillDef();
			def.type = type;
			def.label = typeStr(type);
			return def;
		}
		
		/** 获得所有种类的SkillDef */
		public static function items():Array
		{
			var arr:Array = new Array();
			arr.push(makeItem(TYPE_AIM));
			arr.push(makeItem(TYPE_AOE));
			arr.push(makeItem(TYPE_PATH));
			return arr;
		}
		
		public static function types():Array
		{
			return [TYPE_AIM, TYPE_AOE, TYPE_PATH];
		}
		
		public function availabel():Boolean
		{
			return (types().indexOf(type) != -1) ;
		}
	
	}
}