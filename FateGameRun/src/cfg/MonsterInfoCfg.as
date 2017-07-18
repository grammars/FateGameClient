package cfg
{
	import flash.utils.Dictionary;
	
	import gamekit.utils.StrParser;
	
	public class MonsterInfoCfg
	{
		public static const TYPE:String = "monster_info";
		
		private static var cfgs:Dictionary = new Dictionary();
		/** 根据id获取单个配置 */
		public static function get(id:int):MonsterInfoCfg
		{
			return cfgs[id];
		}
		
		/** id */
		public var id:int = 0;
		/** 名字 */
		public var name:String = "";
		/** 性别 */
		public var sex:int = 0;
		/** 职业 */
		public var voc:int = 0;
		/** 等级 */
		public var level:int = 0;
		/** 外观id */
		public var look:String = "";
		/** 经验值 */
		public var exp:int = 0;
		/** 视野x */
		public var viewX:int = 0;
		/** 视野y */
		public var viewY:int = 0;
		/** 巡视半径x */
		public var walkRX:int = 0;
		/** 巡视半径y */
		public var walkRY:int = 0;
		/** 技能ids */
		public var skillIds:Array = [];
		/** 技能levels */
		public var skillLevels:Array = [];
		/** 掉落物 */
		public var dropId:int = 0;
		/** 掉落几率 */
		public var dropProb:int = 0;
		/** 掉落几率分母 */
		public static const PD:int = 1000000;
		
		public function MonsterInfoCfg()
		{
		}
		
		/** 解析 */
		public static function parse(dataDic:Dictionary, itemCount:int):void
		{
			for(var i:int = 0; i < itemCount; i++)
			{
				var c:MonsterInfoCfg = new MonsterInfoCfg();
				c.id = parseInt(dataDic["id"][i]);
				c.name = (dataDic["名字"][i]);
				c.sex = parseInt(dataDic["性别"][i]);
				c.voc = parseInt(dataDic["职业"][i]);
				c.level = parseInt(dataDic["等级"][i]);
				c.look = (dataDic["外观id"][i]);
				c.exp = parseInt(dataDic["经验值"][i]);
				c.viewX = parseInt(dataDic["视野x"][i]);
				c.viewY = parseInt(dataDic["视野y"][i]);
				c.walkRX = parseInt(dataDic["巡视半径x"][i]);
				c.walkRY = parseInt(dataDic["巡视半径y"][i]);
				c.dropId = parseInt(dataDic["掉落物"][i]);
				c.dropProb = parseInt(dataDic["掉落几率"][i]);
				
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
			return "[MonsterInfoCfg] id:" + id + " name:" + name + " sex=" + sex
				+ " voc=" + voc + " level=" + level + " look=" + look + " exp=" + exp
				+ " viewX=" + viewX + " viewY=" + viewY + " walkRX=" + walkRX + " walkRY=" + walkRY;
		}
		
	}
}